import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sigapp/app/get_it.dart';
import 'package:sigapp/app/router.dart';
import 'package:sigapp/auth/auth_service.dart';

@singleton
class DioClientBuilder {
  final Dio _dio = Dio();
  final SharedPreferences _prefs;

  DioClientBuilder(this._prefs) {
    // TODO: Disable this?
    // _dio.options.validateStatus = (status) => status! < 400;
    _dio.interceptors.add(_CookieInterceptor(_prefs));
  }

  DioClientBuilder setBaseUrl(String baseUrl) {
    _dio.options.baseUrl = baseUrl;
    return this;
  }

  DioClientBuilder setConnectTimeout(int timeout) {
    _dio.options.connectTimeout = Duration(milliseconds: timeout);
    return this;
  }

  DioClientBuilder setReceiveTimeout(int timeout) {
    _dio.options.receiveTimeout = Duration(milliseconds: timeout);
    return this;
  }

  DioClientBuilder addHeader(String key, String value) {
    _dio.options.headers[key] = value;
    return this;
  }

  Dio build() {
    return _dio;
  }
}

class _CookieInterceptor extends Interceptor {
  final SharedPreferences _prefs;

  _CookieInterceptor(this._prefs);

  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final cookies = _prefs.getStringList('cookies_${options.uri.host}') ?? [];
    if (cookies.isNotEmpty) {
      options.headers['Cookie'] = cookies.join('; ');
    }
    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final response = err.response;
    if (response != null) {
      _debugPrint(response);

      if (response.statusCode == 302 &&
          response.headers['location'] != null &&
          response.headers['location']!.contains('/Cuenta/InicioSesion')) {
        print('Tried to access because');
        print(_prefs
            .getStringList('cookies_${response.requestOptions.uri.host}'));
        print(
            'haha redirection is for removing this: ${jsonEncode(response.requestOptions.headers['Cookie'])}');
        getIt<AuthService>().logout();
        // getIt<RouterRefreshListenable>().refresh();
      }
    }
    super.onError(err, handler);
  }

  @override
  Future onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    // Detailed print for debug reasons (path, method, status code, headers, body)
    _debugPrint(response);

    var cookies =
        _prefs.getStringList('cookies_${response.requestOptions.uri.host}') ??
            [];

    // TODO LOGOUT

    // TODO OVERRIDE COOKIES

    final setCookieHeader = response.headers['set-cookie'];
    if (setCookieHeader != null && setCookieHeader.isNotEmpty) {
      cookies.addAll(setCookieHeader);
      // .map((cookie) {
      //   final parts = cookie.split(';').first.split('=');
      //   return '${parts[0]}=${parts[1]}';
      // }).toList();

      // Check for expired cookies and remove them
      cookies.removeWhere((cookie) {
        final parts = cookie.split('=');
        if (parts[0].toLowerCase() == 'expires') {
          final expiresDate = DateTime.tryParse(parts[1]);
          if (expiresDate == null) {
            throw Exception("Couldn't parse ${parts[1]} as a date.");
          }
          if (expiresDate.isBefore(DateTime.now())) {
            return true;
          }
        }
        return false;
      });

      await _prefs.setStringList(
          'cookies_${response.requestOptions.uri.host}', cookies);
    }

    final hasToken =
        cookies.any((cookie) => cookie.startsWith('.ASPXAUTH=')) ?? false;
    if (!hasToken) {
      getIt<RouterRefreshListenable>().refresh();
    }

    return handler.next(response);
  }

  void _debugPrint(Response<dynamic> response) {
    // Detailed print for debug reasons (path, method, status code, headers, body)
    if (kDebugMode) {
      print(
          '👻 Response: ${response.requestOptions.method} ${response.requestOptions.path} ${response.statusCode}');
      print('Headers: ${json.encode(response.headers.map)}');
      try {
        print('Data: ${json.encode(response.data)}');
      } catch (e) {
        print('Data: ${response.data}');
      }
    }
  }
}
