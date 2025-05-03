import 'dart:async';
import 'package:sigapp/auth/application/usecases/get_stored_credentials_usecase.dart';
import 'package:sigapp/auth/application/usecases/keep_session_alive_usecase.dart';
import 'package:sigapp/auth/application/usecases/sign_in_usecase.dart';
import 'package:sigapp/auth/application/usecases/sign_out_usecase.dart';
import 'package:sigapp/auth/domain/exceptions/session_exception.dart';
import 'dart:developer' as developer;

/// Maneja el refresco de la sesión con estrategias de reintentos
class AuthTokenRefreshManager {
  static const int _maxRetries = 3;

  final KeepSessionAliveUsecase _keepSessionAliveUsecase;
  final SignInUseCase _signInUseCase;
  final SignOutUseCase _signOutUseCase;
  final GetStoredCredentialsUseCase _getStoredCredentialsUseCase;

  Completer<void>? _refreshSessionCompleter;

  AuthTokenRefreshManager(
    this._keepSessionAliveUsecase,
    this._signInUseCase,
    this._signOutUseCase,
    this._getStoredCredentialsUseCase,
  );

  /// Refresca la sesión con reintentos y backoff exponencial
  Future<void> refreshSession() async {
    final storedCredentials = _getStoredCredentialsUseCase.execute();
    if (!storedCredentials.hasCredentials) {
      return;
    }

    _refreshSessionCompleter = Completer<void>();

    dynamic lastError;
    StackTrace? lastStack;

    for (int attempt = 1; attempt <= _maxRetries; attempt++) {
      try {
        developer.log(
          'Intento $attempt/$_maxRetries de refresco de sesión',
          name: 'SessionRefreshManager',
        );

        await _keepSessionAliveUsecase.execute();

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
          'Sesión refrescada exitosamente en intento $attempt',
          name: 'SessionRefreshManager',
        );

        _refreshSessionCompleter!.complete();
        return;
      } catch (e, s) {
        lastError = e;
        lastStack = s;

        developer.log(
          'Error al refrescar sesión (intento $attempt/$_maxRetries): $e',
          name: 'SessionRefreshManager',
          error: e,
          stackTrace: s,
        );

        if (attempt < _maxRetries) {
          final waitTime = Duration(seconds: attempt * 2);
          developer.log(
            'Reintentando en ${waitTime.inSeconds} segundos...',
            name: 'SessionRefreshManager',
          );
          await Future.delayed(waitTime);
        }
      }
    }

    developer.log(
      'Todos los intentos de refresco fallaron',
      name: 'SessionRefreshManager',
      error: lastError,
      stackTrace: lastStack,
    );

    _refreshSessionCompleter!.completeError(lastError);

    final sessionError = lastError is SessionException
        ? lastError
        : SessionException.refreshError(
            message: 'Error en múltiples intentos de refresco de sesión',
            originalError: lastError,
          );

    await _signOutUseCase.execute(sessionError);
    _refreshSessionCompleter = null;
  }

  /// Agrega un log al inicio de waitForOngoingRefresh para mayor visibilidad
  Future<void> waitForOngoingRefresh() async {
    if (_refreshSessionCompleter != null) {
      developer.log(
        'Esperando a que termine el refresco de sesión en curso',
        name: 'SessionRefreshManager',
      );
      await _refreshSessionCompleter!.future;
    }
  }

  bool get isRefreshing => _refreshSessionCompleter != null;

  /// Reinicia el estado del refresco para evitar inconsistencias
  void reset() {
    developer.log(
      'Reiniciando estado de AuthTokenRefreshManager',
      name: 'SessionRefreshManager',
    );
    _refreshSessionCompleter = null;
  }
}
