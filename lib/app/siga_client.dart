import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sigapp/app/get_it.dart';
import 'package:sigapp/app/http.dart';
import 'package:sigapp/auth/auth_repository.dart';

const sigaHost = 'academico.unp.edu.pe';
const sigaApiUrl = 'https://$sigaHost';
const sigaAuthCookieKey = '.ASPXAUTH';
const sigaLogoutRedirectionLocation = '/Cuenta/InicioSesion';

@singleton
class SigaClient {
  late final Dio _http;
  late final CookieManager _cookieManager;

  late final BaseAuthRepository _authRepository;
  late final HttpClientBuilderResult _authClient;

  // final GoRouter _router;
  final SharedPreferences _prefs;

  Completer<void>? _refreshSessionCompleter;

  SigaClient(
    this._prefs,
    // this._router,
  ) {
    final result = HttpClientBuilder(id: 'siga', prefs: _prefs)
        .setBaseUrl(sigaApiUrl)
        .addHeader('Content-Type', 'application/json')
        .addRequestHandler(_onRequest)
        .addResponseHandler(_onResponse)
        .addErrorHandler(_onError)
        .build();
    _http = result.client;
    _cookieManager = result.cookieManager;

    _authClient = HttpClientBuilder(id: 'siga_auth', prefs: _prefs)
        .setBaseUrl(sigaApiUrl)
        .addHeader('Content-Type', 'application/json')
        // .addRequestHandler(...)
        // .addResponseHandler(...)
        // .addErrorHandler(...)
        .build();

    _authRepository = BaseAuthRepository(_authClient.client);
    Timer.periodic(const Duration(seconds: 30), (timer) async {
      if (hasAuthCredentials) {
        await _refreshSession();
      }
    });
  }

  Future<void> _refreshSession() async {
    _refreshSessionCompleter = Completer<void>();

    try {
      final keepSessionResponse = await _authRepository.keepSession();
      if (keepSessionResponse.statusCode == 302 &&
          keepSessionResponse.headers['location'] != null &&
          keepSessionResponse.headers['location']!
              .contains(sigaLogoutRedirectionLocation)) {
        // Login
        final loginResponse = await _authRepository.login(
          username!,
          password!,
        );
        if (loginResponse.statusCode != 302) {
          throw Exception('Error refreshing session');
        }
        // transfer cookies to main client
        final authCookieManager = _authClient.cookieManager;
        final authCookies = authCookieManager.getCookies(sigaHost);
        _cookieManager.saveCookies(sigaHost, authCookies);
        if (kDebugMode) {
          print('Session refreshed');
        }

        _refreshSessionCompleter!.complete();
      }
    } on Exception catch (e, s) {
      if (kDebugMode) {
        print('Error refreshing session: $e');
        print(s);
      }
      _refreshSessionCompleter!.completeError(e);
    } finally {
      _refreshSessionCompleter = null;
    }
  }

  Dio get http => _http;

  String? get username {
    return _prefs.getString('username');
  }

  String? get password {
    return _prefs.getString('password');
  }

  get hasAuthCredentials {
    return username != null && password != null;
  }

  List<String>? getAuthCredentials() {
    if (!hasAuthCredentials) {
      return null;
    }
    return [username!, password!];
  }

  void saveCredentials(String username, String password) {
    _prefs.setString('username', username);
    _prefs.setString('password', password);
  }

  void logout() {
    _prefs.remove('password');
    getIt<GoRouter>().refresh();
  }

  void _onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (_refreshSessionCompleter == null) {
      return handler.next(options);
    }
    return _refreshSessionCompleter!.future
        .then((_) => handler.next(options))
        .catchError((e, s) {
      if (kDebugMode) {
        print('Error refreshing session: $e');
        print(s);
      }
      logout();
    });
  }

  void _onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    return handler.next(response);
  }

  void _onError(DioException err, ErrorInterceptorHandler handler) {
    final response = err.response;
    if (response != null &&
        response.statusCode == 302 &&
        response.headers['location'] != null &&
        response.headers['location']!.contains(sigaLogoutRedirectionLocation)) {
      logout();
    }
    // this is not helping us because we need to retry to use the correct cookies
    return handler.next(err);
  }
}
