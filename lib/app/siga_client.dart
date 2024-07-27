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
const sigaForceLogoutRedirectionLocation = '/Cuenta/InicioSesion';
const sigaLoginPageRedirectionLocation = '/Home/Index';

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
        // curl 'https://academico.unp.edu.pe/Academico/ListarParametrosInforme' \
        //   -X 'POST' \
        //   -H 'accept: */*' \
        //   -H 'accept-language: en-US,en;q=0.9,es-PE;q=0.8,es-ES;q=0.7,es;q=0.6' \
        //   -H 'content-length: 0' \
        //   -H 'cookie: ASP.NET_SessionId=stactn4sojhvn4kxi4hyzgvv; .ASPXAUTH=929317BE1CDA2280F93339067788DE08A6C7AA093AB4BD5B0F154DE8E6C630B909D5DBFB8CB97E9D30FE155270BF5B691E37F3128C2FBE33AA45E355BFC2A859884C16758D22081C2D491403A7924387E0E306255CBD86CF3D4891DCD4B6A9C82FC9881F7E483E4BCCB9F92DF032887D8453DF114B1A53DEBF7B59E36EF33B35134F123474AB35712237F59D2862026E24EA3212048F4C71ABAD4342B5F8A190F64AFAEAC2C6C5ECF4EFE26A3E339C6189BDE8F5098473DE5B77E2E0BAA93FE7D927B7C9B165A82D19CBA4DCBEDE4300' \
        //   -H 'origin: https://academico.unp.edu.pe' \
        //   -H 'priority: u=1, i' \
        //   -H 'referer: https://academico.unp.edu.pe/Academico/InformeAcademico' \
        //   -H 'sec-ch-ua: "Not/A)Brand";v="8", "Chromium";v="126", "Microsoft Edge";v="126"' \
        //   -H 'sec-ch-ua-mobile: ?0' \
        //   -H 'sec-ch-ua-platform: "Windows"' \
        //   -H 'sec-fetch-dest: empty' \
        //   -H 'sec-fetch-mode: cors' \
        //   -H 'sec-fetch-site: same-origin' \
        //   -H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36 Edg/126.0.0.0' \
        //   -H 'x-requested-with: XMLHttpRequest'
        .addHeader('Content-Type', 'application/json')
        .addHeader('Origin', sigaApiUrl)
        .addHeader('Referer', sigaApiUrl)
        .addRequestHandler(_onRequest)
        .addResponseHandler(_onResponse)
        .addErrorHandler(_onError)
        .build();
    _http = result.client;
    _cookieManager = result.cookieManager;

    _authClient = HttpClientBuilder(id: 'siga_auth_🛡️', prefs: _prefs)
        .setBaseUrl(sigaApiUrl)
        .addHeader('Content-Type', 'application/json')
        // .addRequestHandler(...)
        // .addResponseHandler(...)
        // .addErrorHandler(...)
        .build();

    _authRepository = BaseAuthRepository(_authClient.client);
    Timer.periodic(const Duration(seconds: 60), (timer) {
      _refreshSession();
    });
    _refreshSession();
  }

  Future<void> _refreshSession() async {
    if (!hasAuthCredentials) {
      return;
    }

    _refreshSessionCompleter = Completer<void>();
    try {
      final keepSessionResponse = await _authRepository.keepSession();
      if (_evaluateSessionExpiration(keepSessionResponse)) {
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
      }
      _refreshSessionCompleter!.complete();
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

  bool _evaluateSessionExpiration(Response<dynamic> keepSessionResponse) {
    final locationHeaderValue = keepSessionResponse.headers['location'];
    if (!(keepSessionResponse.statusCode == 302 &&
        locationHeaderValue != null)) {
      return false;
    }
    return locationHeaderValue.contains(sigaForceLogoutRedirectionLocation) ||
        locationHeaderValue.contains(sigaLoginPageRedirectionLocation);
  }

  Dio get http => _http;

  void _onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (_refreshSessionCompleter == null) {
      return handler.next(options);
    }
    return _refreshSessionCompleter!.future.then((_) {
      final cookies = _cookieManager.getCookies(sigaHost);
      options.headers['Cookie'] = cookies.join('; ');
      handler.next(options);
    }).catchError((e, s) {
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
    if (response != null && _evaluateSessionExpiration(response)) {
      if (kDebugMode) {
        print('This should not happen, the session has expired!');
      }
      logout();
    }
    // this is not helping us because we need to retry to use the correct cookies
    return handler.next(err);
  }

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
}


// check this out #file:siga_client.dart

// re write this file in order to change te way of keeping the session credentials (cookies)

// what you have to do is perform a "keep session" with every request. if keep session fails, then logout. the reasoj behind this is to use fresh cookies every time of a request.

// keep the periodic "refresh session"
