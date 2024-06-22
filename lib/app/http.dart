import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@singleton
class HttpClientBuilder {
  final Dio _dio = Dio();
  final SharedPreferences _prefs;

  HttpClientBuilder(this._prefs) {
    _dio.interceptors.add(_PrintInterceptor(_prefs));
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
}

class _PrintInterceptor extends Interceptor {
  final SharedPreferences _prefs;

  _PrintInterceptor(this._prefs);

  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (kDebugMode) {
      print('👻 Request: ${options.method} ${options.path}');
      print('Headers: ${json.encode(options.headers)}');
      try {
        print('Data: ${json.encode(options.data)}');
      } catch (e) {
        print('Data: ${options.data}');
      }
    }
    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final response = err.response;
    if (response != null) {
      _responsePrint(response);
    }
    super.onError(err, handler);
  }

  @override
  Future onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    _responsePrint(response);

    var cookies =
        _prefs.getStringList('cookies_${response.requestOptions.uri.host}') ??
            [];

    final setCookieHeader = response.headers['set-cookie'];
    if (setCookieHeader != null && setCookieHeader.isNotEmpty) {
      cookies.addAll(setCookieHeader);

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

    return handler.next(response);
  }

  void _responsePrint(Response<dynamic> response) {
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
