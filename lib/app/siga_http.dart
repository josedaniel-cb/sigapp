import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:sigapp/app/http.dart';
import 'package:sigapp/app/router.dart';

const sigaHost = 'academico.unp.edu.pe';
const sigaApiUrl = 'https://$sigaHost';
const sigaAuthCookieKey = '.ASPXAUTH';
const sigaLogoutRedirectionLocation = '/Cuenta/InicioSesion';

@singleton
class SigaClient {
  late final Dio _http;
  final CookieManager _cookieManager;
  final RouterRefreshListenable _routerRefreshListenable;

  SigaClient(
    HttpClientBuilder builder,
    this._cookieManager,
    this._routerRefreshListenable,
  ) {
    _http = builder
        .setBaseUrl(sigaApiUrl)
        .addHeader('Content-Type', 'application/json')
        .addRequestHandler(_onRequest)
        .addResponseHandler(_onResponse)
        .addErrorHandler(_onError)
        .build();
  }

  Dio get http => _http;

  void _onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    return handler.next(options);
  }

  void _onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    if (!isAuthenticated) {
      _routerRefreshListenable.refresh();
    }

    return handler.next(response);
  }

  void _onError(DioException err, ErrorInterceptorHandler handler) {
    final response = err.response;
    if (response != null) {
      if (response.statusCode == 302 &&
          response.headers['location'] != null &&
          response.headers['location']!
              .contains(sigaLogoutRedirectionLocation)) {
        if (kDebugMode) {
          print('Tried to access because');
          print(_cookieManager.getCookies(response.requestOptions.uri.host));
          print(
              'ha ha redirection is for removing this: ${jsonEncode(response.requestOptions.headers['Cookie'])}');
        }
        // _authService.logout();
        logout();
      }
    }
    return handler.next(err);
  }

  void logout() {
    // _prefs.remove('cookies_$sigaHost');
    _cookieManager.clearCookies(sigaHost);
    _routerRefreshListenable.refresh();
  }

  get isAuthenticated {
    return _cookieManager.hasCookie(sigaHost, sigaAuthCookieKey);
  }
}
