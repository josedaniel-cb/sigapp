import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sigapp/core/infrastructure/http/cookie_manager.dart';
import 'package:logger/logger.dart';

final _loggingHeaders = [
  'Authorization',
  'Content-Type',
  'Location',
  'Set-Cookie',
  'Cookie',
  'Redirect-Location',
];

class HttpClientBuilder {
  final Dio _dio = Dio();
  late String _id;
  late final CookieManager _cookieManager;
  final Logger _logger;

  HttpClientBuilder({
    required String id,
    required SharedPreferences prefs,
    required Logger logger,
  }) : _logger = logger {
    _id = id;
    _cookieManager = CookieManager(id: _id, prefs: prefs, logger: logger);
    _setup();
  }

  void _setup() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final cookies = _cookieManager.getCookies(options.uri.host);
          if (cookies.isNotEmpty) {
            options.headers['cookie'] = cookies.join('; ');
          }
          _logger.d(
            '[INFRASTRUCTURE] ⬆️ $_id: ${options.method} ${options.uri}',
          );
          _logger.d(
            '[INFRASTRUCTURE] Headers: ${json.encode(_processHeadersForLog(options.headers))}',
          );
          if (options.data != null) {
            try {
              _logger.d('[INFRASTRUCTURE] Data: ${json.encode(options.data)}');
            } catch (e) {
              _logger.d('[INFRASTRUCTURE] Data: ${options.data}');
            }
          }
          return handler.next(options);
        },
        onResponse: (response, handler) async {
          _logger.d(
            '[INFRASTRUCTURE] ⬇️✅ $_id: ${response.requestOptions.method} ${response.requestOptions.uri} ${response.statusCode}',
          );

          final processedHeaders = _processHeadersForLog(response.headers.map);
          _logger.d(
            '[INFRASTRUCTURE] Headers: ${json.encode(processedHeaders)}',
          );

          if (response.headers.map.containsKey('location')) {
            _logger.d(
              '[INFRASTRUCTURE] Redirección a: ${response.headers.map['location']}',
            );
          }

          try {
            var responseData = json.encode(response.data);
            _logger.d(
              '[INFRASTRUCTURE] Data: ${_truncateString(responseData, 500)}',
            );
          } catch (e) {
            var responseStr = response.data.toString();
            _logger.d(
              '[INFRASTRUCTURE] Data: ${_truncateString(responseStr, 500)}',
            );
          }

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
            _logger.d(
              '[INFRASTRUCTURE] ⬇️❌ $_id: ${response.requestOptions.method} ${response.requestOptions.uri} ${response.statusCode}',
            );

            final processedHeaders = _processHeadersForLog(
              response.headers.map,
            );
            _logger.d(
              '[INFRASTRUCTURE] Headers: ${json.encode(processedHeaders)}',
            );

            if (response.headers.map.containsKey('location')) {
              _logger.d(
                '[INFRASTRUCTURE] Redirección a: ${response.headers.map['location']}',
              );
            }

            try {
              var responseData = json.encode(response.data);
              _logger.d(
                '[INFRASTRUCTURE] Data: ${_truncateString(responseData, 500)}',
              );
            } catch (e) {
              var responseStr = response.data.toString();
              _logger.d(
                '[INFRASTRUCTURE] Data: ${_truncateString(responseStr, 500)}',
              );
            }
          }
          return handler.next(err);
        },
      ),
    );
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
    void Function(RequestOptions options, RequestInterceptorHandler handler)
    onRequest,
  ) {
    _dio.interceptors.add(InterceptorsWrapper(onRequest: onRequest));
    return this;
  }

  HttpClientBuilder addResponseHandler(
    void Function(Response response, ResponseInterceptorHandler handler)
    onResponse,
  ) {
    _dio.interceptors.add(InterceptorsWrapper(onResponse: onResponse));
    return this;
  }

  HttpClientBuilder addErrorHandler(
    void Function(DioException err, ErrorInterceptorHandler handler) onError,
  ) {
    _dio.interceptors.add(InterceptorsWrapper(onError: onError));
    return this;
  }

  HttpClientBuilderResult build() {
    return HttpClientBuilderResult(http: _dio, cookieManager: _cookieManager);
  }

  String _truncateString(String text, int maxLength) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}...';
  }

  Map<String, dynamic> _processHeadersForLog(Map<String, dynamic> headers) {
    final processedHeaders = <String, dynamic>{};

    for (var header in _loggingHeaders) {
      if (headers.containsKey(header)) {
        processedHeaders[header] = headers[header];
      }
    }

    if (processedHeaders.containsKey('cookie')) {
      processedHeaders['cookie'] = _truncateString(
        processedHeaders['cookie'],
        50,
      );
    }

    return processedHeaders;
  }
}

class HttpClientBuilderResult {
  final Dio http;
  final CookieManager cookieManager;

  HttpClientBuilderResult({required this.http, required this.cookieManager});
}
