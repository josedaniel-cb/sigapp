import 'dart:async';
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
import 'package:sigapp/core/infrastructure/http/siga_client.dart';
import 'package:sigapp/auth/domain/services/session_lifecycle_service.dart';
import 'package:sigapp/auth/domain/value-objects/api_path_and_method.dart';
import 'dart:developer' as developer;

/// Manager de autenticación que maneja el ciclo de vida de la sesión
/// Ejecuta refrescos periódicos de token y maneja transiciones entre
/// primer plano y segundo plano para mantener sesiones activas
@singleton
class AuthenticationManager {
  static const _sessionTimeoutDuration = Duration(seconds: 60);
  static const _backgroundTimeBeforeRefresh = Duration(minutes: 5);

  // Clave ÚNICA para todas las operaciones de refresco
  static const _sessionRefreshKey = 'session_refresh';

  final SessionLifecycleService _sessionService;
  final GetStoredCredentialsUseCase _getStoredCredentialsUseCase;
  final SignOutUseCase _signOutUseCase;
  final KeepSessionAliveUsecase _keepSessionAliveUsecase;
  final SignInUseCase _signInUseCase;

  // Clases de apoyo para separar responsabilidades
  late final AppLifecycleManager _lifecycleManager;
  late final AuthTokenRefreshManager _authTokenRefreshManager;
  late final AsyncOperationGuard _asyncOperationGuard;

  // Flag para asegurar que no se intente un refresco periódico durante el refresco inicial
  bool _initialRefreshComplete = false;

  AuthenticationManager(
    this._sessionService,
    this._getStoredCredentialsUseCase,
    this._signOutUseCase,
    this._keepSessionAliveUsecase,
    this._signInUseCase,
  ) {
    _authTokenRefreshManager = AuthTokenRefreshManager(
      _keepSessionAliveUsecase,
      _signInUseCase,
      _signOutUseCase,
      _getStoredCredentialsUseCase,
    );
    _asyncOperationGuard = AsyncOperationGuard();
    _lifecycleManager = AppLifecycleManager(
      onAppResumed: _handleAppResumed,
      onAppPaused: _handleAppPaused,
    );

    _inicializar();
  }

  Future<void> _inicializar() async {
    // Configurar interceptores para encuestas pendientes
    _configureEncuestasPendientesInterceptors();

    // Configurar interceptores de sesión
    _configureSessionInterceptors();

    // Programar refresco periódico DESPUÉS del inicial
    // Esto evita tener dos refrescos intentando ejecutarse al inicio
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // Primero realizamos el refresco inicial
      await _forceSessionRefresh();

      // Una vez completado, iniciamos el timer periódico
      Timer.periodic(_sessionTimeoutDuration, (_) => _refreshSession());
    });
  }

  void _configureEncuestasPendientesInterceptors() {
    _sessionService.configureSurveyAssertionInterceptors(
      ensureNoPendingSurvey: (response) async {
        if (_sessionService.evaluateIsSurveyAvailable(response)) {
          if (!_sessionService.evaluateIsSurveyAvailable(response)) {
            developer.log(
              'No hay encuestas pendientes',
              name: 'AuthenticationManager',
            );
            return;
          }
          developer.log(
            'Encuesta pendiente encontrada, cerrando sesión',
            name: 'AuthenticationManager',
          );
          _signOutUseCase.execute(SessionException.pendingSurveyError(
            message: 'Encuesta pendiente encontrada',
            originalError: 'Encuesta pendiente encontrada',
          ));
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
        ApiPathAndMethod(
          ApiMethod.post,
          SigaClient.signInPath,
        ),
        ApiPathAndMethod(
          ApiMethod.post,
          SigaClient.keepSessionPath,
        ),
        ApiPathAndMethod(
          ApiMethod.get,
          SigaClient.survey1RedirectionLocation,
        ),
        ApiPathAndMethod(
          ApiMethod.get,
          SigaClient.survey2RedirectionLocation,
        ),
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
        developer.log(
          'Esperando refresco de sesión en curso',
          name: 'AuthenticationManager',
        );
        await _authTokenRefreshManager.waitForOngoingRefresh();
      } else {
        developer.log(
          'Iniciando nuevo refresco de sesión desde interceptor',
          name: 'AuthenticationManager',
        );
        await _authTokenRefreshManager.refreshSession();
      }
    }, operationKey: _sessionRefreshKey); // MISMA CLAVE que otros refrescos
  }

  /// Fuerza un refresco completo de sesión
  Future<void> _forceSessionRefresh() async {
    final storedCredentials = _getStoredCredentialsUseCase.execute();
    if (!storedCredentials.hasCredentials) {
      developer.log(
        'No hay credenciales almacenadas, no se intenta refresco',
        name: 'AuthenticationManager',
      );

      _initialRefreshComplete = true;
      return;
    }

    await _asyncOperationGuard.executeSafely(() async {
      try {
        developer.log(
          'Iniciando refresco forzado de sesión al iniciar la app',
          name: 'AuthenticationManager',
        );

        _authTokenRefreshManager.reset();
        await _authTokenRefreshManager.refreshSession();

        developer.log(
          'Refresco forzado completado exitosamente',
          name: 'AuthenticationManager',
        );
      } catch (e, s) {
        developer.log(
          'Error en refresco forzado: $e',
          name: 'AuthenticationManager',
          error: e,
          stackTrace: s,
        );
      } finally {
        _initialRefreshComplete = true;
      }
    }, operationKey: _sessionRefreshKey); // MISMA CLAVE que otros refrescos
  }

  /// Maneja el evento cuando la app vuelve a primer plano
  Future<void> _handleAppResumed(Duration backgroundDuration) async {
    if (backgroundDuration < _backgroundTimeBeforeRefresh) {
      developer.log(
        'App estuvo en segundo plano solo ${backgroundDuration.inSeconds} segundos, '
        'no se requiere refresco',
        name: 'AuthenticationManager',
      );
      return;
    }

    _refreshOnResume(backgroundDuration);
  }

  /// Maneja el evento cuando la app va a segundo plano
  void _handleAppPaused() {
    // No se requiere acción específica cuando la app va a segundo plano
  }

  /// Refresca la sesión después de que la app vuelve a primer plano
  Future<void> _refreshOnResume(Duration backgroundDuration) async {
    final storedCredentials = _getStoredCredentialsUseCase.execute();
    if (!storedCredentials.hasCredentials) {
      return;
    }

    await _asyncOperationGuard.executeSafely(() async {
      try {
        developer.log(
          'Refrescando sesión después de ${backgroundDuration.inSeconds} segundos en segundo plano',
          name: 'AuthenticationManager',
        );

        _authTokenRefreshManager.reset();
        await _authTokenRefreshManager.refreshSession();

        developer.log(
          'Refresco después de reactivación completado exitosamente',
          name: 'AuthenticationManager',
        );
      } catch (e, s) {
        developer.log(
          'Error al refrescar sesión después de reactivar: $e',
          name: 'AuthenticationManager',
          error: e,
          stackTrace: s,
        );
      }
    }, operationKey: _sessionRefreshKey); // MISMA CLAVE que otros refrescos
  }

  /// Refresca la sesión (utilizado por el timer periódico)
  Future<void> _refreshSession() async {
    // No intentar refresco periódico hasta que el inicial haya terminado
    if (!_initialRefreshComplete) {
      developer.log(
        'Omitiendo refresco periódico porque el refresco inicial aún no ha terminado',
        name: 'AuthenticationManager',
      );
      return;
    }

    await _asyncOperationGuard.executeSafely(() async {
      try {
        await _authTokenRefreshManager.refreshSession();
      } catch (e, s) {
        developer.log(
          'Error en refresco programado: $e',
          name: 'AuthenticationManager',
          error: e,
          stackTrace: s,
        );
      }
    }, operationKey: _sessionRefreshKey); // MISMA CLAVE que otros refrescos
  }

  @disposeMethod
  void dispose() {
    _lifecycleManager.dispose();
  }
}
