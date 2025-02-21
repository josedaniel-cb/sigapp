import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sigapp/core/http/cookie_manager.dart';

class HttpClientBuilder {
  final Dio _dio = Dio();
  late String _id;
  late final CookieManager _cookieManager;

  HttpClientBuilder({
    required String id,
    required SharedPreferences prefs,
  }) {
    _id = id;
    _cookieManager = CookieManager(id: _id, prefs: prefs);
    _setup();
  }

  void _setup() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final cookies = _cookieManager.getCookies(options.uri.host);
        if (cookies.isNotEmpty) {
          options.headers['cookie'] = cookies.join('; ');
        }
        _printRequest(options);
        return handler.next(options);
      },
      onResponse: (response, handler) async {
        _printResponse(response, '✅');
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
          _printResponse(response, '❌');
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

  HttpClientBuilderResult build() {
    return HttpClientBuilderResult(
      http: _dio,
      cookieManager: _cookieManager,
    );
  }

  void _printRequest(RequestOptions options) {
    if (kDebugMode) {
      print('[📡] ⬆️ $_id: ${options.method} ${options.uri}');
      print('Headers: ${json.encode(options.headers)}');
      try {
        print('Data: ${json.encode(options.data)}');
      } catch (e) {
        print('Data: ${options.data}');
      }
    }
  }

  void _printResponse(Response<dynamic> response, String emoji) {
    if (kDebugMode) {
      print(
          '[📡] ⬇️$emoji $_id: ${response.requestOptions.method} ${response.requestOptions.uri} ${response.statusCode}');
      print('Headers: ${json.encode(response.headers.map)}');
      try {
        print('Data: ${json.encode(response.data)}');
      } catch (e) {
        print('Data: ${response.data}');
      }
    }
  }
}

class HttpClientBuilderResult {
  final Dio http;
  final CookieManager cookieManager;

  HttpClientBuilderResult({
    required this.http,
    required this.cookieManager,
  });
}
