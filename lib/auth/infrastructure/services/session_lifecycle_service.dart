import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:sigapp/auth/domain/value-objects/api_response.dart';
import 'package:sigapp/core/http/siga_client.dart';
import 'package:sigapp/auth/domain/services/session_lifecycle_service.dart';
import 'package:sigapp/auth/domain/value-objects/api_path_and_method.dart';

@Singleton(as: SessionLifecycleService)
class SessionLifecycleServiceImpl implements SessionLifecycleService {
  final SigaClient _sigaClient;

  SessionLifecycleServiceImpl(this._sigaClient);

  @override
  void configureSurveyAssertionInterceptors({
    required Future<void> Function(ApiResponse a) ensureNoPendingSurvey,
  }) {
    _sigaClient.http.interceptors.add(
      InterceptorsWrapper(
        onResponse: (response, handler) async {
          await ensureNoPendingSurvey(ApiResponse(
            statusCode: response.statusCode ?? -1,
            headers: response.headers.map,
            pathAndMethod: ApiPathAndMethod(
              ApiMethod.fromString(response.requestOptions.method),
              response.requestOptions.path,
            ),
          ));

          handler.next(response);
        },
        onError: (error, handler) async {
          if (error.response != null) {
            await ensureNoPendingSurvey(ApiResponse(
              statusCode: error.response!.statusCode ?? -1,
              headers: error.response!.headers.map,
              pathAndMethod: ApiPathAndMethod(
                ApiMethod.fromString(error.requestOptions.method),
                error.requestOptions.path,
              ),
            ));
          }
          handler.next(error);
        },
      ),
    );
  }

  /// Sets up the logic to refresh the session before requests (unless excluded)
  /// and to detect session expiration after responses. Calls [onSessionExpired]
  /// if the session is determined to be expired.
  @override
  void configureSessionInterceptors({
    required Future<void> Function() awaitOngoingSessionRefresh,
    required List<ApiPathAndMethod> excludedEndpointsFromRefresh,
    required void Function() onSessionExpired,
  }) {
    Response handleResponse(Response response) {
      // Skip session expiration check if the response is from an excluded request.
      if (_isExcludedRequest(
          response.requestOptions, excludedEndpointsFromRefresh)) {
        _logDebug(
          'Response from ${response.requestOptions.method} ${response.requestOptions.path} '
          'is excluded from session expiration evaluation.',
        );
        return response;
      }

      // Evaluate if the session has expired based on headers and status code.
      final hasExpired = response.statusCode != null &&
          _evaluateSessionExpiration(
            headers: response.headers.map,
            statusCode: response.statusCode!,
          );
      if (hasExpired) {
        onSessionExpired();
      }

      // Check
      return response;
    }

    _sigaClient.http.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Skip session refresh if this request is in the excluded list.
          if (_isExcludedRequest(options, excludedEndpointsFromRefresh)) {
            _logDebug(
              'Request ${options.method} ${options.path} is excluded from session refresh.',
            );
            handler.next(options);
            return;
          }

          // Refresh the session before the request.
          _logDebug('Refreshing session before making the request...');
          await awaitOngoingSessionRefresh();
          _logDebug('Session refreshed successfully.');

          // Update cookies in the request headers if needed.
          _updateCookieHeader(options);
          handler.next(options);
        },
        onResponse: (response, handler) {
          handler.next(handleResponse(response));
        },
        onError: (error, handler) {
          if (error.response != null) {
            handleResponse(error.response!);
          }
          handler.next(error);
        },
      ),
    );
  }

  @override
  bool evaluateIsSurveyAvailable(ApiResponse response) {
    final locationHeaderValue = response.headers['location'];
    if (locationHeaderValue == null) {
      return false;
    }
    return locationHeaderValue.contains(SigaClient.surveyPath);
  }

  // ----------------
  // Private methods
  // ----------------

  /// Determines if the session has expired based on the provided response headers and status code.
  /// Returns `true` if there is a 302 redirect to the sign-out or sign-in page.
  bool _evaluateSessionExpiration({
    required Map<String, List<String>> headers,
    required int statusCode,
  }) {
    // If not a 302 redirect, no need to evaluate further.
    if (statusCode != 302) return false;

    // If there's no 'location' header, also no sign of redirection.
    final locationHeaderValue = headers['location'];
    if (locationHeaderValue == null) return false;

    // Check if the redirection matches "forceSignOut" or "signInPage".
    final forceSignOut = locationHeaderValue
        .contains(SigaClient.forceSignOutRedirectionLocation);
    final signInRedirect =
        locationHeaderValue.contains(SigaClient.signInPageRedirectionLocation);

    return forceSignOut || signInRedirect;
  }

  /// Checks if the request is in the list of excluded API paths and methods.
  bool _isExcludedRequest(
      RequestOptions options, List<ApiPathAndMethod> excludedRequests) {
    return excludedRequests.any((excludedRequest) {
      return excludedRequest ==
          ApiPathAndMethod(
            ApiMethod.fromString(options.method),
            options.path,
          );
    });
  }

  /// Updates the "Cookie" header with the latest session cookies from the CookieManager.
  void _updateCookieHeader(RequestOptions options) {
    final cookies =
        _sigaClient.cookieManager.getCookies(SigaClient.host).join('; ');
    final originalCookieHeader = options.headers['Cookie'];

    if (originalCookieHeader != cookies) {
      _logDebug(
        'Cookie header updated from "$originalCookieHeader" to "$cookies".',
      );
      options.headers['Cookie'] = cookies;
    }
  }

  /// Prints debug messages only when in debug mode.
  void _logDebug(String message) {
    if (kDebugMode) {
      print('[👓] $message');
    }
  }
}
