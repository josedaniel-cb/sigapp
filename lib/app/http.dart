import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  HttpClientBuilderResult build() {
    return HttpClientBuilderResult(
      client: _dio,
      cookieManager: _cookieManager,
    );
  }

  void _printRequest(RequestOptions options) {
    if (kDebugMode) {
      print('👻 [$_id] Request: ${options.method} ${options.uri}');
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
          '👻 [$_id] Response: ${response.requestOptions.method} ${response.requestOptions.uri} ${response.statusCode}');
      print('Headers: ${json.encode(response.headers.map)}');
      try {
        print('Data: ${json.encode(response.data)}');
      } catch (e) {
        print('Data: ${response.data}');
      }
    }
  }
}

class CookieManager {
  final SharedPreferences _prefs;
  final String _id;

  CookieManager({
    required String id,
    required SharedPreferences prefs,
  })  : _prefs = prefs,
        _id = id;

  String _buildKey(String host) {
    return '${_id}_cookies_$host';
  }

  Future<void> saveCookies(String host, List<String> newCookies) async {
    final key = _buildKey(host);
    var existingCookies = _prefs.getStringList(key) ?? [];

    // Create a map to track the latest cookie value by name
    final Map<String, String> cookiesMap = {};

    // Add existing cookies to the map
    for (var cookie in existingCookies) {
      final parts = cookie.split('=');
      if (parts.length >= 2) {
        cookiesMap[parts[0]] = parts.sublist(1).join('=');
      }
    }

    // Update the map with new cookies, replacing values for existing names
    for (var cookie in newCookies) {
      final parts = cookie.split('=');
      if (parts.length >= 2) {
        cookiesMap[parts[0]] = parts.sublist(1).join('=');
      }
    }

    // Convert the map back to a list of cookies
    final uniqueCookies =
        cookiesMap.entries.map((e) => "${e.key}=${e.value}").toList();

    // Save the updated list back to SharedPreferences
    await _prefs.setStringList(key, uniqueCookies);
  }

  List<String> getCookies(String host) {
    removeExpiredCookies(host);

    final key = _buildKey(host);
    final cookies = _prefs.getStringList(key) ?? [];
    return cookies;
  }

  void clearCookies(String host) {
    final key = _buildKey(host);
    _prefs.remove(key);
  }

  bool hasCookie(String host, String cookieKey) {
    final cookies = getCookies(host);
    return cookies.any((cookie) => cookie.contains(cookieKey));
  }

  Future<void> removeExpiredCookies(String host) async {
    final key = _buildKey(host);
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

class HttpClientBuilderResult {
  final Dio client;
  final CookieManager cookieManager;

  HttpClientBuilderResult({
    required this.client,
    required this.cookieManager,
  });
}
