import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sigapp/core/infrastructure/http/http_client_builder.dart';
import 'package:sigapp/core/infrastructure/http/cookie_manager.dart';

@singleton
class RegevaClient {
  static const host = 'regeva.unp.edu.pe';
  static const url = 'http://$host:8081';
  static const forceSignOutRedirectionLocation = '/Cuenta/Login';
  static const successCourseRedirectionLocation = '/Cursos/Info';

  late final HttpClientBuilderResult _httpClient;

  RegevaClient(SharedPreferences prefs) {
    _httpClient = HttpClientBuilder(id: 'regeva', prefs: prefs)
        .setBaseUrl(url)
        .addHeader('Content-Type', 'application/json')
        // .addHeader('Origin', url)
        // .addHeader('Referer', url)
        .build();
  }

  Dio get http => _httpClient.http;

  CookieManager get cookieManager => _httpClient.cookieManager;
}
