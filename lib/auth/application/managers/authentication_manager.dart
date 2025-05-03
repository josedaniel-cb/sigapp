import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:sigapp/auth/application/usecases/ensure_no_pending_survey_usecase.dart';
import 'package:sigapp/auth/application/usecases/get_stored_credentials_usecase.dart';
import 'package:sigapp/auth/application/usecases/keep_session_alive_usecase.dart';
import 'package:sigapp/auth/application/usecases/sign_in_usecase.dart';
import 'package:sigapp/auth/application/usecases/sign_out_usecase.dart';
import 'package:sigapp/core/infrastructure/http/siga_client.dart';
import 'package:sigapp/auth/domain/services/session_lifecycle_service.dart';
import 'package:sigapp/auth/domain/value-objects/api_path_and_method.dart';
import 'package:sigapp/auth/domain/exceptions/session_exception.dart';
import 'dart:developer' as developer;

@singleton
class AuthenticationManager with WidgetsBindingObserver {
  static const _sessionTimeoutDuration = Duration(seconds: 60);

  final SessionLifecycleService _sessionService;
  final GetStoredCredentialsUseCase _getStoredCredentialsUseCase;
  final SignOutUseCase _signOutUseCase;
  final KeepSessionAliveUsecase _keepSessionAliveUsecase;
  final SignInUseCase _signInUseCase;
  final EnsureNoPendingSurveyUseCase _ensureNoPendingSurveyUseCase;
  Completer<void>? _refreshSessionCompleter;
  Future<void>? _ongoingSessionRefresh;
  DateTime? _lastBackgroundTime;

  AuthenticationManager(
      this._sessionService,
      this._getStoredCredentialsUseCase,
      this._signOutUseCase,
      this._keepSessionAliveUsecase,
      this._signInUseCase,
      this._ensureNoPendingSurveyUseCase) {
    // Registrar para eventos del ciclo de vida de la app
    WidgetsBinding.instance.addObserver(this);

    // First
    _sessionService.configureSurveyAssertionInterceptors(
      ensureNoPendingSurvey: (response) async {
        if (_sessionService.evaluateIsSurveyAvailable(response)) {
          try {
            await _ensureNoPendingSurveyUseCase.execute(response);
            developer.log(
              'No pending survey',
              name: 'AuthenticationManager',
            );
          } catch (e, s) {
            developer.log(
              'Pending survey found, execute sign out',
              name: 'AuthenticationManager',
              error: e,
              stackTrace: s,
            );
            _signOutUseCase.execute(e.toString());
            rethrow;
          }
        }
      },
    );

    // Second
    _sessionService.configureSessionInterceptors(
      awaitOngoingSessionRefresh: completeSessionRefresh,
      excludedEndpointsFromRefresh: [
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

    // Schedule
    Timer.periodic(_sessionTimeoutDuration, (timer) {
      _keepSessionAlive();
    });

    // Run
    _keepSessionAlive();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _lastBackgroundTime = DateTime.now();
      developer.log(
        'App went to background at $_lastBackgroundTime',
        name: 'AuthenticationManager',
      );
    } else if (state == AppLifecycleState.resumed) {
      final now = DateTime.now();
      final timeSinceBackground = _lastBackgroundTime != null
          ? now.difference(_lastBackgroundTime!)
          : const Duration(seconds: 0);

      developer.log(
        'App resumed after ${timeSinceBackground.inSeconds} seconds in background',
        name: 'AuthenticationManager',
      );

      // Refrescar inmediatamente la sesión cuando la app vuelve al primer plano
      // especialmente después de un largo período de inactividad
      _refreshOnResume(timeSinceBackground);
    }
  }

  Future<void> _refreshOnResume(Duration backgroundDuration) async {
    // Si la app estuvo en segundo plano por más de 5 minutos, forzar un refresco
    // El valor de 5 minutos (300 segundos) puede ajustarse según tus necesidades
    if (backgroundDuration.inSeconds < 300) {
      developer.log(
        'App estuvo en segundo plano menos de 5 minutos, no se fuerza refresco',
        name: 'AuthenticationManager',
      );
      return;
    }

    final storedCredentials = _getStoredCredentialsUseCase.execute();
    if (!storedCredentials.hasCredentials) {
      developer.log(
        'No hay credenciales almacenadas, no se intenta refresco al reactivar',
        name: 'AuthenticationManager',
      );
      return;
    }

    // Usar synchronized para prevenir operaciones mientras se completa el refresco
    await synchronized(() async {
      try {
        developer.log(
          'Refrescando proactivamente la sesión después de reactivar la app',
          name: 'AuthenticationManager',
        );

        // Reiniciar el estado del refreshSessionCompleter para asegurar un refresco limpio
        _refreshSessionCompleter = null;

        // Forzar un refresco completo de la sesión
        await _keepSessionAlive();

        developer.log(
          'Refresco de sesión después de reactivación completado exitosamente',
          name: 'AuthenticationManager',
        );
      } catch (e, s) {
        developer.log(
          'Error al refrescar sesión después de reactivar: $e',
          name: 'AuthenticationManager',
          error: e,
          stackTrace: s,
        );
        // El manejo de errores ya está implementado en _keepSessionAlive
      }
    });
  }

  Future<void> _keepSessionAlive() async {
    final storedCredentials = _getStoredCredentialsUseCase.execute();
    if (!storedCredentials.hasCredentials) {
      // Prevent from refreshing session if there is no session to keep alive
      return;
    }

    _refreshSessionCompleter = Completer<void>();

    // Implementación con reintentos
    const maxRetries = 3;
    dynamic lastError;
    StackTrace? lastStack;

    for (int attempt = 1; attempt <= maxRetries; attempt++) {
      try {
        developer.log(
          'Intento $attempt/$maxRetries de mantener la sesión activa',
          name: 'AuthenticationManager',
        );

        await _keepSessionAliveUsecase.execute();

        // Login
        final successfulSignIn = await _signInUseCase.execute(
          storedCredentials.username!,
          storedCredentials.password!,
        );

        if (!successfulSignIn) {
          throw SessionException.refreshError(
            message: 'Error refreshing session: Sign in returned false',
            originalError: 'SignIn returned false',
          );
        }

        developer.log(
          'Session refreshed successfully on attempt $attempt',
          name: 'AuthenticationManager',
        );

        _refreshSessionCompleter!.complete();
        return; // Éxito, salir del método
      } catch (e, s) {
        lastError = e;
        lastStack = s;

        developer.log(
          'Error refreshing session (attempt $attempt/$maxRetries): $e',
          name: 'AuthenticationManager',
          error: e,
          stackTrace: s,
        );

        if (attempt < maxRetries) {
          // Esperar antes de reintentar, con backoff exponencial
          final waitTime = Duration(seconds: attempt * 2);
          developer.log(
            'Reintentando en ${waitTime.inSeconds} segundos...',
            name: 'AuthenticationManager',
          );
          await Future.delayed(waitTime);
        }
      }
    }

    // Si llegamos aquí, todos los intentos fallaron
    developer.log(
      'Todos los intentos de refresco de sesión fallaron, cerrando sesión',
      name: 'AuthenticationManager',
      error: lastError,
      stackTrace: lastStack,
    );

    _refreshSessionCompleter!.completeError(lastError);

    // Convertir error original a un SessionException si no lo es ya
    final sessionError = lastError is SessionException
        ? lastError
        : SessionException.refreshError(
            message: 'Error en múltiples intentos de refresco de sesión',
            originalError: lastError,
          );

    // Sign out if there is an error refreshing the session after all retries
    await _signOutUseCase.execute(sessionError);

    _refreshSessionCompleter = null;
  }

  Future<void> completeSessionRefresh() async {
    // Si hay un refresh en progreso, simplemente espera a que termine
    // en lugar de iniciar uno nuevo
    synchronized(() async {
      if (_refreshSessionCompleter == null) {
        developer.log(
          'Starting new session refresh',
          name: 'AuthenticationManager',
        );
        await _keepSessionAlive();
      } else {
        developer.log(
          'Waiting for ongoing session refresh',
          name: 'AuthenticationManager',
        );
        await _refreshSessionCompleter!.future;
      }
    });
  }

  // Método para sincronizar las solicitudes de actualización de sesión
  Future<T> synchronized<T>(Future<T> Function() fn) async {
    // Evitar que múltiples hilos inicien una actualización de sesión al mismo tiempo
    final localFuture = _ongoingSessionRefresh;
    if (localFuture != null) {
      // Ya hay una actualización en progreso, espera a que termine
      developer.log(
        'Found ongoing session refresh, waiting...',
        name: 'AuthenticationManager',
      );
      await localFuture;
      developer.log(
        'Previous session refresh completed, continuing',
        name: 'AuthenticationManager',
      );
      return fn();
    }

    // No hay actualización en progreso, inicia una nueva
    final completer = Completer<T>();
    _ongoingSessionRefresh = completer.future;
    try {
      final result = await fn();
      completer.complete(result);
      return result;
    } catch (e) {
      completer.completeError(e);
      rethrow;
    } finally {
      _ongoingSessionRefresh = null;
    }
  }

  @disposeMethod
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
  }
}
