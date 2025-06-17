import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:sigapp/auth/application/managers/authentication_manager/app_lifecycle_manager.dart';
import 'package:sigapp/auth/application/managers/authentication_manager/async_operation_guard.dart';
import 'package:sigapp/auth/application/managers/authentication_manager/auth_token_refresh_manager.dart';
import 'package:sigapp/auth/application/usecases/get_stored_credentials_usecase.dart';
import 'package:sigapp/auth/application/usecases/keep_session_alive_usecase.dart';
import 'package:sigapp/auth/application/usecases/sign_in_usecase.dart';
import 'package:sigapp/auth/application/usecases/sign_out_usecase.dart';
import 'package:sigapp/auth/domain/exceptions/session_exception.dart';
import 'package:sigapp/auth/domain/services/toast_service.dart';
import 'package:sigapp/core/infrastructure/http/siga_client.dart';
import 'package:sigapp/auth/domain/services/session_lifecycle_service.dart';
import 'package:sigapp/auth/domain/value-objects/api_path_and_method.dart';
import 'package:logger/logger.dart';

/// Manager de autenticación que maneja el ciclo de vida de la sesión
/// Ejecuta refrescos periódicos de token y maneja transiciones entre
/// primer plano y segundo plano para mantener sesiones activas
@singleton
class AuthenticationManager {
  static const _sessionTimeoutDuration = Duration(seconds: 60);

  // Clave ÚNICA para todas las operaciones de refresco
  static const _sessionRefreshKey = 'session_refresh';
  final SessionLifecycleService _sessionService;
  final GetStoredCredentialsUseCase _getStoredCredentialsUseCase;
  final SignOutUseCase _signOutUseCase;
  final KeepSessionAliveUsecase _keepSessionAliveUsecase;
  final SignInUseCase _signInUseCase;
  final ToastService _toastService;
  final Logger _logger;

  // Variables para manejo offline
  static const _offlineGracePeriod = Duration(hours: 12);
  DateTime? _lastSuccessfulRefresh;
  DateTime _lastSuccessfulRefreshTime = DateTime.fromMillisecondsSinceEpoch(0);
  bool _isOfflineMode = false;

  // Clases de apoyo para separar responsabilidades
  late final AppLifecycleManager _lifecycleManager;
  late final AuthTokenRefreshManager _authTokenRefreshManager;
  late final AsyncOperationGuard _asyncOperationGuard;
  // Flag para asegurar que no se intente un refresco periódico durante el refresco inicial
  AuthenticationManager(
    this._sessionService,
    this._getStoredCredentialsUseCase,
    this._signOutUseCase,
    this._keepSessionAliveUsecase,
    this._signInUseCase,
    this._toastService,
    this._logger,
  ) {
    _authTokenRefreshManager = AuthTokenRefreshManager(
      _keepSessionAliveUsecase,
      _signInUseCase,
      _signOutUseCase,
      _getStoredCredentialsUseCase,
      _toastService,
      _logger,
    );
    _asyncOperationGuard = AsyncOperationGuard(_logger);
    _lifecycleManager = AppLifecycleManager(
      onAppResumed: _handleAppResumed,
      onAppPaused: _handleAppPaused,
      logger: _logger,
    );

    _inicializar();
  }

  /// Determina si se necesita refrescar la sesión antes de una solicitud
  bool _shouldRefreshBeforeRequest() {
    // Verificar si nunca se ha refrescado o si han pasado más de 60 segundos
    return DateTime.now().difference(_lastSuccessfulRefreshTime) >
        _sessionTimeoutDuration;
  }

  Future<void> _inicializar() async {
    // Configurar interceptores para encuestas pendientes
    _configureEncuestasPendientesInterceptors();

    // Configurar interceptores de sesión
    _configureSessionInterceptors();

    // Programar SOLO refresco inicial, eliminamos el timer periódico
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // Realizamos el refresco inicial
      await _forceSessionRefresh();
    });
  }

  void _configureEncuestasPendientesInterceptors() {
    _sessionService.configureSurveyAssertionInterceptors(
      ensureNoPendingSurvey: (response) async {
        if (_sessionService.evaluateIsSurveyAvailable(response)) {
          if (!_sessionService.evaluateIsSurveyAvailable(response)) {
            _logger.i('[DOMAIN] No hay encuestas pendientes');
            return;
          }
          _logger.w('[DOMAIN] Encuesta pendiente encontrada, cerrando sesión');
          _signOutUseCase.execute(
            SessionException.pendingSurveyError(
              message: 'Encuesta pendiente encontrada',
              originalError: 'Encuesta pendiente encontrada',
            ),
          );
        }
      },
    );
  }

  void _configureSessionInterceptors() {
    _sessionService.configureSessionInterceptors(
      awaitOngoingSessionRefresh: _handleHttpInterceptorRefreshRequest,
      endpointsExcludedFromPreRequestRefresh: [
        ApiPathAndMethod(
          ApiMethod.post,
          SigaClient.forceSignOutRedirectionLocation,
        ),
        ApiPathAndMethod(ApiMethod.post, SigaClient.signInPath),
        ApiPathAndMethod(ApiMethod.post, SigaClient.keepSessionPath),
        ApiPathAndMethod(ApiMethod.get, SigaClient.survey1RedirectionLocation),
        ApiPathAndMethod(ApiMethod.get, SigaClient.survey2RedirectionLocation),
      ],
      onSessionExpired: () {
        _signOutUseCase.execute();
      },
    );
  }

  /// Maneja solicitudes de refresco de sesión desde interceptores
  Future<void> _handleHttpInterceptorRefreshRequest() async {
    await _asyncOperationGuard.executeSafely(() async {
      if (_authTokenRefreshManager.isRefreshing) {
        _logger.d('[DOMAIN] Esperando refresco de sesión en curso');
        await _authTokenRefreshManager.waitForOngoingRefresh();
      } else if (_shouldRefreshBeforeRequest()) {
        // Solo refrescamos si ha pasado el umbral de tiempo
        _logger.i(
          '[DOMAIN] Han pasado más de ${_sessionTimeoutDuration.inSeconds} segundos desde el último refresco, iniciando nuevo refresco',
        );
        await _authTokenRefreshManager.refreshSession();
        _lastSuccessfulRefreshTime = DateTime.now();
        _lastSuccessfulRefresh = DateTime.now();

        if (_isOfflineMode) {
          _isOfflineMode = false;
          _toastService.show('Conexión recuperada');
        }
      } else {
        _logger.d(
          '[DOMAIN] Refresco no necesario, último refresco hace ${DateTime.now().difference(_lastSuccessfulRefreshTime).inSeconds} segundos',
        );
      }
    }, operationKey: _sessionRefreshKey);
  }

  /// Fuerza un refresco completo de sesión
  Future<void> _forceSessionRefresh() async {
    final storedCredentials = _getStoredCredentialsUseCase.execute();
    if (!storedCredentials.hasCredentials) {
      _logger.i(
        '[DOMAIN] No hay credenciales almacenadas, no se intenta refresco',
      );
      return;
    }

    await _asyncOperationGuard.executeSafely(() async {
      try {
        _logger.i(
          '[DOMAIN] Iniciando refresco forzado de sesión al iniciar la app',
        );

        _authTokenRefreshManager.reset();
        await _authTokenRefreshManager.refreshSession();
        _lastSuccessfulRefresh = DateTime.now();
        _lastSuccessfulRefreshTime = DateTime.now();
        if (_isOfflineMode) {
          _isOfflineMode = false;
          _toastService.show('Conexión recuperada');
        }
        _logger.i('[DOMAIN] Refresco forzado completado exitosamente');
      } catch (e, s) {
        _handleRefreshError(e, s, 'forzado');
      }
    }, operationKey: _sessionRefreshKey); // MISMA CLAVE que otros refrescos
  }

  /// Maneja el evento cuando la app vuelve a primer plano
  Future<void> _handleAppResumed(Duration backgroundDuration) async {
    _logger.i(
      '[DOMAIN] App volvió a primer plano después de ${backgroundDuration.inSeconds} segundos, refrescando sesión',
    );

    _refreshOnResume();
  }

  /// Maneja el evento cuando la app va a segundo plano
  void _handleAppPaused() {
    // No se requiere acción específica cuando la app va a segundo plano
  }

  /// Refresca la sesión después de que la app vuelve a primer plano
  Future<void> _refreshOnResume() async {
    final storedCredentials = _getStoredCredentialsUseCase.execute();
    if (!storedCredentials.hasCredentials) {
      return;
    }
    await _asyncOperationGuard.executeSafely(() async {
      try {
        _logger.i(
          '[DOMAIN] Refrescando sesión después de volver a primer plano',
        );

        _authTokenRefreshManager.reset();
        await _authTokenRefreshManager.refreshSession();
        _lastSuccessfulRefresh = DateTime.now();
        _lastSuccessfulRefreshTime = DateTime.now();
        if (_isOfflineMode) {
          _isOfflineMode = false;
          _toastService.show('Conexión recuperada');
        }
        _logger.i(
          '[DOMAIN] Refresco después de reactivación completado exitosamente',
        );
      } catch (e, s) {
        _handleRefreshError(e, s, 'reactivación');
      }
    }, operationKey: _sessionRefreshKey); // MISMA CLAVE que otros refrescos
  }

  void _handleRefreshError(
    Object error,
    StackTrace stackTrace,
    String refreshType,
  ) {
    final isNetworkError = _isNetworkError(error);
    if (isNetworkError) {
      if (!_isOfflineMode) {
        _isOfflineMode = true;
        _toastService.show('Modo sin conexión activo', isError: false);
      }
      if (_isWithinOfflineGracePeriod()) {
        _logger.w(
          '[DOMAIN] Error de red en refresco $refreshType, pero dentro del período de gracia offline',
          error: error,
          stackTrace: stackTrace,
        );
      } else {
        _logger.e(
          '[DOMAIN] Error de red en refresco $refreshType y FUERA del período de gracia',
          error: error,
          stackTrace: stackTrace,
        );
        _toastService.show(
          'Sesión cerrada por estar demasiado tiempo sin conexión',
          isError: true,
        );
        _signOutUseCase.execute(
          SessionException.refreshError(
            message: 'Período de modo offline expirado',
            originalError: 'Sin conexión por demasiado tiempo',
          ),
        );
      }
    } else {
      _logger.e(
        '[DOMAIN] Error en refresco $refreshType: $error',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  bool _isNetworkError(Object error) {
    if (error is DioException) {
      return error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.sendTimeout ||
          error.type == DioExceptionType.receiveTimeout ||
          error.type == DioExceptionType.connectionError ||
          (error.type == DioExceptionType.unknown &&
              (error.error is SocketException ||
                  error.message?.contains('Failed host lookup') == true));
    }
    return false;
  }

  bool _isWithinOfflineGracePeriod() {
    if (_lastSuccessfulRefresh == null) return false;
    final timeSinceLastRefresh = DateTime.now().difference(
      _lastSuccessfulRefresh!,
    );
    return timeSinceLastRefresh < _offlineGracePeriod;
  }

  @disposeMethod
  void dispose() {
    _lifecycleManager.dispose();
  }
}
