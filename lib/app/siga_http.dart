import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sigapp/app/http.dart';
import 'package:sigapp/app/router.dart';
import 'package:sigapp/auth/auth_service.dart';

const sigaHost = 'academico.unp.edu.pe';
const sigaApiUrl = 'https://$sigaHost';
const sigaAuthCookieKey = '.ASPXAUTH';

@singleton
class SigaHttpController {
  late final Dio _http;
  final SharedPreferences _prefs;
  // final AuthService _authService;
  final RouterRefreshListenable _routerRefreshListenable;

  SigaHttpController(
    HttpClientBuilder builder,
    this._prefs,
    // this._authService,
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
    final cookies = _prefs.getStringList('cookies_${options.uri.host}') ?? [];
    if (cookies.isNotEmpty) {
      options.headers['Cookie'] = cookies.join('; ');
    }
    return handler.next(options);
  }

  void _onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    var cookies =
        _prefs.getStringList('cookies_${response.requestOptions.uri.host}') ??
            [];

    // final setCookieHeader = response.headers['set-cookie'];
    // if (setCookieHeader != null && setCookieHeader.isNotEmpty) {
    //   cookies.addAll(setCookieHeader);

    //   // Check for expired cookies and remove them
    //   cookies.removeWhere((cookie) {
    //     final parts = cookie.split('=');
    //     if (parts[0].toLowerCase() == 'expires') {
    //       final expiresDate = DateTime.tryParse(parts[1]);
    //       if (expiresDate == null) {
    //         throw Exception("Couldn't parse ${parts[1]} as a date.");
    //       }
    //       if (expiresDate.isBefore(DateTime.now())) {
    //         return true;
    //       }
    //     }
    //     return false;
    //   });

    //   await _prefs.setStringList(
    //       'cookies_${response.requestOptions.uri.host}', cookies);
    // }

    final hasToken =
        cookies.any((cookie) => cookie.contains('$sigaAuthCookieKey='));
    if (!hasToken) {
      _routerRefreshListenable.refresh();
    }

    return handler.next(response);
  }

  void _onError(DioException err, ErrorInterceptorHandler handler) {
    final response = err.response;
    if (response != null) {
      if (response.statusCode == 302 &&
          response.headers['location'] != null &&
          response.headers['location']!.contains('/Cuenta/InicioSesion')) {
        if (kDebugMode) {
          print('Tried to access because');
          print(_prefs
              .getStringList('cookies_${response.requestOptions.uri.host}'));
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
    _prefs.remove('cookies_$sigaHost');
    _routerRefreshListenable.refresh();
  }

  get isAuthenticated {
    final cookies = _prefs.getStringList('cookies_$sigaHost');
    return cookies?.any((cookie) => cookie.contains('$sigaAuthCookieKey=')) ??
        false;
  }
}
