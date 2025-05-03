import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sigapp/core/infrastructure/http/cookie_manager.dart';
import 'dart:developer' as developer;

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

  String _truncateString(String text, int maxLength) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}...';
  }

  Map<String, dynamic> _processHeadersForLog(Map<String, dynamic> headers) {
    final processedHeaders = Map<String, dynamic>.from(headers);
    if (processedHeaders.containsKey('cookie')) {
      processedHeaders['cookie'] =
          _truncateString(processedHeaders['cookie'], 100);
    }
    return processedHeaders;
  }

  void _printRequest(RequestOptions options) {
    developer.log('⬆️ $_id: ${options.method} ${options.uri}', name: 'HTTP');
    developer.log(
        'Headers: ${json.encode(_processHeadersForLog(options.headers))}',
        name: 'HTTP');
    try {
      developer.log('Data: ${json.encode(options.data)}', name: 'HTTP');
    } catch (e) {
      developer.log('Data: ${options.data}', name: 'HTTP');
    }
  }

  void _printResponse(Response<dynamic> response, String emoji) {
    developer.log(
        '⬇️$emoji $_id: ${response.requestOptions.method} ${response.requestOptions.uri} ${response.statusCode}',
        name: 'HTTP');

    final processedHeaders = _processHeadersForLog(response.headers.map);
    developer.log('Headers: ${json.encode(processedHeaders)}', name: 'HTTP');

    try {
      developer.log('Data: ${json.encode(response.data)}', name: 'HTTP');
    } catch (e) {
      developer.log('Data: ${response.data}', name: 'HTTP');
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
