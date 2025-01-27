import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:sigapp/app/siga_client.dart';
import 'package:sigapp/auth/application/usecases.dart';
import 'package:sigapp/auth/domain/services/session_lifecycle_service.dart';
import 'package:sigapp/auth/domain/value-objects/api_path_and_method.dart';

@singleton
class AuthenticationManager {
  static const _sessionTimeoutDuration = Duration(seconds: 60);

  final SessionLifecycleService _sessionService;
  final AuthUsecases _authUsecases;
  Completer<void>? _refreshSessionCompleter;

  AuthenticationManager(this._sessionService, this._authUsecases) {
    _sessionService.setup(
      completeSessionRefresh: completeSessionRefresh,
      excludedRequests: [
        ApiPathAndMethod(SigaClient.forceSignOutRedirectionLocation, 'POST'),
        ApiPathAndMethod(SigaClient.signInPath, 'POST'),
        ApiPathAndMethod(SigaClient.keepSessionPath, 'POST'),
      ],
      onSessionExpired: () {
        _authUsecases.signOut.execute();
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
    final storedCredentials = _authUsecases.getStoredCredentials.execute();
    if (!storedCredentials.hasCredentials) {
      // Prevent from refreshing session if there is no session to keep alive
      return;
    }

    _refreshSessionCompleter = Completer<void>();
    try {
      final keepSessionResponse =
          await _authUsecases.keepSessionAlive.execute();

      final sessionHasExpired = _sessionService.evaluateSessionExpiration(
        headers: keepSessionResponse.headers,
        statusCode: keepSessionResponse.statusCode,
      );
      // If the session has expired, sign in again
      if (sessionHasExpired) {
        // Login
        final successfulSignIn = await _authUsecases.signIn.execute(
          storedCredentials.username!,
          storedCredentials.password!,
        );
        if (!successfulSignIn) {
          throw Exception('Error refreshing session');
        }
        // // transfer cookies to main client
        // final authCookieManager = _auxiliarAuthClient.cookieManager;
        // final authCookies = authCookieManager.getCookies(sigaHost);
        // _cookieManager.saveCookies(sigaHost, authCookies);
        if (kDebugMode) {
          print('[🧢] Session refreshed');
        }
      } else {
        if (kDebugMode) {
          print('[🧢] Session is still alive');
        }
      }
      _refreshSessionCompleter!.complete();
    } on Exception catch (e, s) {
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
    if (kDebugMode) {
      if (_refreshSessionCompleter == null) {
        print('[🧢] There is no session refresh in progress');
      }
    }
    await _refreshSessionCompleter?.future;
  }
}
