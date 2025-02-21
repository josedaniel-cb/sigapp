import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:sigapp/auth/application/usecases/ensure_no_pending_survey_usecase.dart';
import 'package:sigapp/auth/application/usecases/get_stored_credentials_usecase.dart';
import 'package:sigapp/auth/application/usecases/keep_session_alive_usecase.dart';
import 'package:sigapp/auth/application/usecases/sign_in_usecase.dart';
import 'package:sigapp/auth/application/usecases/sign_out_usecase.dart';
import 'package:sigapp/core/http/siga_client.dart';
import 'package:sigapp/auth/domain/services/session_lifecycle_service.dart';
import 'package:sigapp/auth/domain/value-objects/api_path_and_method.dart';

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
            if (kDebugMode) {
              print('[🧢] No pending survey');
            }
          } catch (e, s) {
            if (kDebugMode) {
              print('[🧢] Pending survey found, execute sign out');
              print(e);
              print(s);
            }
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
          SigaClient.surveyPath,
        ),
      ],
      onSessionExpired: () {
        _signOutUseCase.execute();
      },
    );

    // try {
    // Schedule
    Timer.periodic(_sessionTimeoutDuration, (timer) {
      _keepSessionAlive();
    });

    // Run
    _keepSessionAlive();
    // } catch (e, s) {
    //   if (kDebugMode) {
    //     print(e);
    //     print(s);
    //   }
    //   _signOutUseCase.execute(e.toString());
    // }
  }

  Future<void> _keepSessionAlive() async {
    final storedCredentials = _getStoredCredentialsUseCase.execute();
    if (!storedCredentials.hasCredentials) {
      // Prevent from refreshing session if there is no session to keep alive
      return;
    }

    _refreshSessionCompleter = Completer<void>();
    try {
      // final keepSessionResponse = await _keepSessionAliveUsecase.execute();
      await _keepSessionAliveUsecase.execute();

      // final sessionHasExpired = _sessionService.evaluateSessionExpiration(
      //   headers: keepSessionResponse.headers,
      //   statusCode: keepSessionResponse.statusCode,
      // );
      // If the session has expired, sign in again
      // if (sessionHasExpired) {
      // Login
      final successfulSignIn = await _signInUseCase.execute(
        storedCredentials.username!,
        storedCredentials.password!,
      );
      if (!successfulSignIn) {
        throw Exception('Error refreshing session');
      }
      if (kDebugMode) {
        print('[🧢] Session refreshed');
      }
      // } else {
      //   if (kDebugMode) {
      //     print('[🧢] Session is still alive');
      //   }
      // }
      _refreshSessionCompleter!.complete();
    } catch (e, s) {
      if (kDebugMode) {
        print('[🧢] Error refreshing session: $e');
        print(s);
      }
      _refreshSessionCompleter!.completeError(e);
    } finally {
      _refreshSessionCompleter = null;
    }
  }

  Future<void> completeSessionRefresh() async {
    if (_refreshSessionCompleter == null) {
      if (kDebugMode) {
        print('[🧢] There is no session refresh in progress');
      }
      return;
    }
    await _refreshSessionCompleter!.future;
  }
}
