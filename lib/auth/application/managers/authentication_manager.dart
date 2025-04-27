import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:sigapp/auth/application/usecases/ensure_no_pending_survey_usecase.dart';
import 'package:sigapp/auth/application/usecases/get_stored_credentials_usecase.dart';
import 'package:sigapp/auth/application/usecases/keep_session_alive_usecase.dart';
import 'package:sigapp/auth/application/usecases/sign_in_usecase.dart';
import 'package:sigapp/auth/application/usecases/sign_out_usecase.dart';
import 'package:sigapp/core/infrastructure/http/siga_client.dart';
import 'package:sigapp/auth/domain/services/session_lifecycle_service.dart';
import 'package:sigapp/auth/domain/value-objects/api_path_and_method.dart';
import 'dart:developer' as developer;

@singleton
class AuthenticationManager {
  static const _sessionTimeoutDuration = Duration(seconds: 60);

  final SessionLifecycleService _sessionService;
  final GetStoredCredentialsUseCase _getStoredCredentialsUseCase;
  final SignOutUseCase _signOutUseCase;
  final KeepSessionAliveUsecase _keepSessionAliveUsecase;
  final SignInUseCase _signInUseCase;
  final EnsureNoPendingSurveyUseCase _ensureNoPendingSurveyUseCase;
  Completer<void>? _refreshSessionCompleter;

  AuthenticationManager(
      this._sessionService,
      this._getStoredCredentialsUseCase,
      this._signOutUseCase,
      this._keepSessionAliveUsecase,
      this._signInUseCase,
      this._ensureNoPendingSurveyUseCase) {
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

  Future<void> _keepSessionAlive() async {
    final storedCredentials = _getStoredCredentialsUseCase.execute();
    if (!storedCredentials.hasCredentials) {
      // Prevent from refreshing session if there is no session to keep alive
      return;
    }

    _refreshSessionCompleter = Completer<void>();
    try {
      await _keepSessionAliveUsecase.execute();

      // Login
      final successfulSignIn = await _signInUseCase.execute(
        storedCredentials.username!,
        storedCredentials.password!,
      );
      if (!successfulSignIn) {
        throw Exception('Error refreshing session');
      }
      developer.log(
        'Session refreshed',
        name: 'AuthenticationManager',
      );
      _refreshSessionCompleter!.complete();
    } catch (e, s) {
      developer.log(
        'Error refreshing session: $e',
        name: 'AuthenticationManager',
        error: e,
        stackTrace: s,
      );
      _refreshSessionCompleter!.completeError(e);

      // Sign out if there is an error refreshing the session
      await _signOutUseCase.execute();
    } finally {
      _refreshSessionCompleter = null;
    }
  }

  Future<void> completeSessionRefresh() async {
    if (_refreshSessionCompleter == null) {
      developer.log(
        'There is no session refresh in progress',
        name: 'AuthenticationManager',
      );
      return;
    }
    await _refreshSessionCompleter!.future;
  }
}
