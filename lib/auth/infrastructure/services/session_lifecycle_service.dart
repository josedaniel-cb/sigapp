import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:sigapp/app/siga_client.dart';
import 'package:sigapp/auth/domain/services/session_lifecycle_service.dart';
import 'package:sigapp/auth/domain/value-objects/api_path_and_method.dart';

@Singleton(as: SessionLifecycleService)
class SessionLifecycleServiceImpl implements SessionLifecycleService {
  final SigaClient _sigaClient;
  final GoRouter _router;
  // final AuthUsecases _authUsecases; // Nope, you will break the dependency injection

  SessionLifecycleServiceImpl(
    this._sigaClient,
    this._router,
  );

  @override
  bool evaluateSessionExpiration({
    required Map<String, List<String>> headers,
    required int statusCode,
  }) {
    final locationHeaderValue = headers['location'];
    if (!(statusCode == 302 && locationHeaderValue != null)) {
      return false;
    }
    return locationHeaderValue
            .contains(SigaClient.forceSignOutRedirectionLocation) ||
        locationHeaderValue.contains(SigaClient.signInPageRedirectionLocation);
  }

  @override
  void setup({
    required Future<void> Function() completeSessionRefresh,
    required List<ApiPathAndMethod> excludedRequests,
    required void Function() onSessionExpired,
  }) {
    _sigaClient.http.interceptors.add(InterceptorsWrapper(
      // Ensure that the session cookies are updated before making any request
      onRequest: (options, handler) async {
        final excluded = excludedRequests.any(
          (params) =>
              options.path == params.path && options.method == params.method,
        );
        if (excluded) {
          if (kDebugMode) {
            print('[👓] ${options.method} ${options.path}'
                ' was excluded from session refreshing');
          }
          handler.next(options);
          return;
        }

        if (kDebugMode) {
          print('[👓] Refreshing session before making a request');
        }
        await completeSessionRefresh();
        if (kDebugMode) {
          print('[👓] Session refreshed successfully');
        }

        final cookies = _sigaClient.cookieManager.getCookies(SigaClient.host);
        if (options.headers['Cookie'] != cookies.join('; ')) {
          if (kDebugMode) {
            print('[👓] Cookie header was updated from'
                ' "${options.headers['Cookie']}" to "${cookies.join('; ')}"');
          }
        }
        options.headers['Cookie'] = cookies.join('; ');

        handler.next(options);
      },
      // Check if the session has expired after receiving a response
      onResponse: (response, handler) {
        final RequestOptions(path: path, method: method) =
            response.requestOptions;
        final excluded = excludedRequests.any(
          (params) => path == params.path && method == params.method,
        );
        if (excluded) {
          if (kDebugMode) {
            print('[👓] ${response.requestOptions.method}'
                ' ${response.requestOptions.path}'
                ' was excluded from evaluating session expiration');
          }
          handler.next(response);
          return;
        }

        final sessionHasExpired = response.statusCode != null &&
            evaluateSessionExpiration(
              headers: response.headers.map,
              statusCode: response.statusCode!,
            );
        if (sessionHasExpired) {
          onSessionExpired();
        }
        handler.next(response);
      },
    ));
  }

  @override
  void refreshNavigation() {
    _router.refresh();
  }
}
