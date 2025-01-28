import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sigapp/core/http/http_client_builder.dart';
import 'package:sigapp/core/http/cookie_manager.dart';

@singleton
class SigaClient {
  static const host = 'academico.unp.edu.pe';
  static const url = 'https://$host';
  static const sigaAuthCookieKey = '.ASPXAUTH';
  static const forceSignOutRedirectionLocation = '/Cuenta/InicioSesion';
  static const signInPageRedirectionLocation = '/Home/Index';
  static const signInPath = '/';
  static const keepSessionPath = "/Home/KeepSession";

  late final HttpClientBuilderResult _httpClient;

  SigaClient(SharedPreferences prefs) {
    _httpClient = HttpClientBuilder(id: 'siga', prefs: prefs)
        .setBaseUrl(url)
        .addHeader('Content-Type', 'application/json')
        .addHeader('Origin', url)
        .addHeader('Referer', url)
        .build();
  }

  Dio get http => _httpClient.http;

  CookieManager get cookieManager => _httpClient.cookieManager;
}
