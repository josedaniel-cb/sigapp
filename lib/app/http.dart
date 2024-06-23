import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@singleton
class HttpClientBuilder {
  final Dio _dio = Dio();
  final CookieManager _cookieManager;

  HttpClientBuilder(this._cookieManager) {
    _setup();
  }

  void _setup() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        _printRequest(options);
        final cookies = _cookieManager.getCookies(options.uri.host);
        if (cookies.isNotEmpty) {
          options.headers['cookie'] = cookies.join('; ');
        }
        return handler.next(options);
      },
      onResponse: (response, handler) async {
        _printResponse(response);
        final setCookieHeader = response.headers['set-cookie'];
        if (setCookieHeader != null && setCookieHeader.isNotEmpty) {
          _cookieManager.saveCookies(
            response.requestOptions.uri.host,
            setCookieHeader,
          );
        }
        return handler.next(response);
      },
      onError: (err, handler) async {
        final response = err.response;
        if (response != null) {
          _printResponse(response);
        }
        return handler.next(err);
      },
    ));
  }

  HttpClientBuilder setBaseUrl(String baseUrl) {
    _dio.options.baseUrl = baseUrl;
    return this;
  }

  HttpClientBuilder setConnectTimeout(int timeout) {
    _dio.options.connectTimeout = Duration(milliseconds: timeout);
    return this;
  }

  HttpClientBuilder setReceiveTimeout(int timeout) {
    _dio.options.receiveTimeout = Duration(milliseconds: timeout);
    return this;
  }

  HttpClientBuilder addHeader(String key, String value) {
    _dio.options.headers[key] = value;
    return this;
  }

  HttpClientBuilder addRequestHandler(
    void Function(
      RequestOptions options,
      RequestInterceptorHandler handler,
    ) onRequest,
  ) {
    _dio.interceptors.add(InterceptorsWrapper(onRequest: onRequest));
    return this;
  }

  HttpClientBuilder addResponseHandler(
    void Function(
      Response response,
      ResponseInterceptorHandler handler,
    ) onResponse,
  ) {
    _dio.interceptors.add(InterceptorsWrapper(onResponse: onResponse));
    return this;
  }

  HttpClientBuilder addErrorHandler(
    void Function(
      DioException err,
      ErrorInterceptorHandler handler,
    ) onError,
  ) {
    _dio.interceptors.add(InterceptorsWrapper(onError: onError));
    return this;
  }

  Dio build() {
    return _dio;
  }

  void _printRequest(RequestOptions options) {
    if (kDebugMode) {
      print('👻 Request: ${options.method} ${options.uri}');
      print('Headers: ${json.encode(options.headers)}');
      try {
        print('Data: ${json.encode(options.data)}');
      } catch (e) {
        print('Data: ${options.data}');
      }
    }
  }

  void _printResponse(Response<dynamic> response) {
    if (kDebugMode) {
      print(
          '👻 Response: ${response.requestOptions.method} ${response.requestOptions.uri} ${response.statusCode}');
      print('Headers: ${json.encode(response.headers.map)}');
      try {
        print('Data: ${json.encode(response.data)}');
      } catch (e) {
        print('Data: ${response.data}');
      }
    }
  }
}

@singleton
class CookieManager {
  final SharedPreferences _prefs;

  CookieManager(this._prefs);

  Future<void> saveCookies(String host, List<String> newCookies) async {
    final key = 'cookies_$host';
    var existingCookies = _prefs.getStringList(key) ?? [];
    existingCookies.addAll(newCookies);

    // Remove duplicates
    final uniqueCookies = existingCookies.toSet().toList();

    // Save the updated list back to SharedPreferences
    await _prefs.setStringList(key, uniqueCookies);
  }

  List<String> getCookies(String host) {
    final key = 'cookies_$host';
    return _prefs.getStringList(key) ?? [];
  }

  void clearCookies(String host) {
    final key = 'cookies_$host';
    _prefs.remove(key);
  }

  bool hasCookie(String host, String cookieKey) {
    final key = 'cookies_$host';
    final cookies = _prefs.getStringList(key) ?? [];
    return cookies.any((cookie) => cookie.contains(cookieKey));
  }

  Future<void> removeExpiredCookies(String host) async {
    final key = 'cookies_$host';
    var cookies = _prefs.getStringList(key) ?? [];

    cookies.removeWhere((cookie) {
      final parts = cookie.split(';').map((e) => e.trim()).toList();
      for (var part in parts) {
        if (part.toLowerCase().startsWith('expires=')) {
          final expiresValue = part.substring('expires='.length);
          final expiresDate = DateTime.tryParse(expiresValue);
          if (expiresDate != null && expiresDate.isBefore(DateTime.now())) {
            return true;
          }
        }
      }
      return false;
    });

    await _prefs.setStringList(key, cookies);
  }
}
