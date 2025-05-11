import 'package:dio/dio.dart';
import 'dart:developer' as developer;
import 'package:injectable/injectable.dart';
import 'package:sigapp/auth/domain/exceptions/session_exception.dart';
import 'package:sigapp/auth/domain/value-objects/api_response.dart';
import 'package:sigapp/core/infrastructure/http/siga_client.dart';
import 'package:sigapp/auth/domain/services/session_lifecycle_service.dart';
import 'package:sigapp/auth/domain/value-objects/api_path_and_method.dart';

@Singleton(as: SessionLifecycleService)
class SessionLifecycleServiceImpl implements SessionLifecycleService {
  final SigaClient _sigaClient;

  // Renombrando para mayor claridad en su propósito
  bool _isHttpInterceptorRefreshInProgress = false;

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
    // Actualizando el nombre del parámetro para que coincida con la interfaz
    required List<ApiPathAndMethod> endpointsExcludedFromPreRequestRefresh,
    required void Function() onSessionExpired,
  }) {
    Response handleResponse(Response response) {
      // Skip session expiration check if the response is from an excluded request.
      if (_isExcludedRequest(
          response.requestOptions, endpointsExcludedFromPreRequestRefresh)) {
        developer.log(
          'Response from ${response.requestOptions.method} ${response.requestOptions.path} '
          'is excluded from session expiration evaluation.',
        );
        return response;
      }

      // Evaluate if the session has expired based on headers and status code.
      final hasExpired = response.statusCode != null &&
          _checkSessionExpiration(
            headers: response.headers.map,
            statusCode: response.statusCode!,
          );
      if (hasExpired) {
        // Lanzar una excepción específica en lugar de simplemente llamar a onSessionExpired
        final locationUrl =
            response.headers.map['location']?.first ?? 'Unknown redirection';

        if (locationUrl.contains(SigaClient.forceSignOutRedirectionLocation)) {
          developer.log(
            'Lanzando SessionException.authenticationError por forceSignOut',
            name: 'SessionLifecycle',
          );
          throw SessionException.authenticationError(
            message: 'Sesión cerrada por el servidor',
            originalError: 'Redirección a forceSignOut: $locationUrl',
          );
        } else {
          developer.log(
            'Lanzando SessionException.refreshError por redirección a login',
            name: 'SessionLifecycle',
          );
          throw SessionException.refreshError(
            message: 'Sesión expirada',
            originalError: 'Redirección a página de login: $locationUrl',
          );
        }
      }

      return response;
    }

    _sigaClient.http.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          if (_isHttpInterceptorRefreshInProgress) {
            developer.log('Skipping recursive session refresh');
            _updateCookieHeader(options);
            handler.next(options);
            return;
          }

          // Skip session refresh if this request is in the excluded list.
          if (_isExcludedRequest(
              options, endpointsExcludedFromPreRequestRefresh)) {
            developer.log(
              'Request ${options.method} ${options.path} is excluded from session refresh.',
            );
            handler.next(options);
            return;
          }

          // Refresh the session before the request.
          developer.log('Refreshing session before making the request...');
          try {
            _isHttpInterceptorRefreshInProgress = true;
            await awaitOngoingSessionRefresh();
            developer.log('Session refreshed successfully.');
          } catch (e) {
            // Si falla el refresco de sesión, maneja el error pero permite que la solicitud continue
            developer.log(
              'Error refrescando sesión antes de solicitud: $e',
              name: 'SessionLifecycle',
              error: e,
            );
            // No relanzamos la excepción para permitir que la solicitud continúe
          } finally {
            _isHttpInterceptorRefreshInProgress = false;
          }

          // Update cookies in the request headers if needed.
          _updateCookieHeader(options);
          handler.next(options);
        },
        onResponse: (response, handler) {
          try {
            handler.next(handleResponse(response));
          } catch (e) {
            // Si es un SessionException, no lo manejamos aquí, lo propagamos
            if (e is SessionException) {
              onSessionExpired();
              handler.reject(DioException(
                requestOptions: response.requestOptions,
                error: e,
              ));
            } else {
              // Otros errores se pasan a través normalmente
              handler.next(response);
            }
          }
        },
        onError: (error, handler) {
          if (error.response != null) {
            try {
              handleResponse(error.response!);
              handler.next(error);
            } catch (e) {
              // Si es un SessionException, no lo manejamos aquí, lo propagamos
              if (e is SessionException) {
                onSessionExpired();
                handler.reject(DioException(
                  requestOptions: error.requestOptions,
                  error: e,
                ));
              } else {
                // Otros errores se pasan a través normalmente
                handler.next(error);
              }
            }
          } else {
            handler.next(error);
          }
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
    return _evaluateSurveyRedirection(locationHeaderValue.first);
  }

  bool _evaluateSurveyRedirection(String locationUrl) {
    return locationUrl.contains(SigaClient.survey1RedirectionLocation) ||
        locationUrl.contains(SigaClient.survey2RedirectionLocation);
  }

  // ----------------
  // Private methods
  // ----------------

  /// Determines if the session has expired based on the provided response headers and status code.
  /// Returns `true` if there is a 302 redirect to the sign-out or sign-in page.
  bool _checkSessionExpiration({
    required Map<String, List<String>> headers,
    required int statusCode,
  }) {
    final locationHeaderValue = headers['location'] ?? [];
    if (statusCode != 302 && locationHeaderValue.isEmpty) {
      developer.log(
        'No hay respuesta 302 o header location, no se evalúa expiración',
        name: 'SessionLifecycle',
      );
      return false;
    }

    final locationUrl = locationHeaderValue.first;

    if (_evaluateSignOutRedirection(locationUrl)) {
      developer.log(
        'SESIÓN EXPIRADA: Detectada redirección de cierre se sesión: $locationUrl',
        name: 'SessionLifecycle',
      );
      return true;
    }

    // WTF LOL
    // if (_evaluateSignInRedirection(locationUrl)) {
    //   developer.log(
    //     'SESIÓN EXPIRADA: Detectada redirección a página de login: $locationUrl',
    //     name: 'SessionLifecycle',
    //   );
    //   return true;
    // }

    // Si llegamos aquí, es una redirección 302 a otra página (no expiró la sesión)
    developer.log(
      'Redirección 302 detectada pero NO es expiración de sesión: $locationUrl',
      name: 'SessionLifecycle',
    );
    return false;
  }

  bool _evaluateSignOutRedirection(String locationUrl) {
    return locationUrl.contains(SigaClient.forceSignOutRedirectionLocation);
  }

  bool _evaluateSignInRedirection(String locationUrl) {
    return locationUrl.contains(SigaClient.successSignInRedirectionLocation);
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
      developer.log(
        'Cookie header updated from "$originalCookieHeader" to "$cookies".',
      );
      options.headers['Cookie'] = cookies;
    }
  }

  @override
  bool checkLoginResult({
    required Map<String, List<String>> headers,
    required int statusCode,
  }) {
    final locationHeaderValue = headers['location'] ?? [];
    if (statusCode == 200 && locationHeaderValue.isEmpty) {
      developer.log(
        'Failed login',
        name: 'SessionLifecycle',
      );
      return false;
    }

    if (_evaluateSignInRedirection(locationHeaderValue.first)) {
      developer.log(
        'Successful login',
        name: 'SessionLifecycle',
      );
      return true;
    }

    if (statusCode == 302) {
      throw SessionException.authenticationError(
        message: 'Proceso pendiente en SIGA web: $locationHeaderValue',
        originalError:
            'Status code: $statusCode, Location: $locationHeaderValue',
      );
    }

    throw SessionException.authenticationError(
      message: 'Ocurrió un error inesperado',
      originalError: 'Status code: $statusCode, Location: $locationHeaderValue',
    );
  }
}
