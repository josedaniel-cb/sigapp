import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:sigapp/app/http.dart';
import 'package:sigapp/app/router.dart';

const sigaHost = 'academico.unp.edu.pe';
const sigaApiUrl = 'https://$sigaHost';
const sigaAuthCookieKey = '.ASPXAUTH';
const sigaLogoutRedirectionLocation = '/Cuenta/InicioSesion';

@singleton
class SigaClient {
  late final Dio _http;
  final CookieManager _cookieManager;
  final RouterRefreshListenable _routerRefreshListenable;

  SigaClient(
    HttpClientBuilder builder,
    this._cookieManager,
    this._routerRefreshListenable,
  ) {
    _http = builder
        .setBaseUrl(sigaApiUrl)
        .addHeader('Content-Type', 'application/json')
        .addRequestHandler(_onRequest)
        .addResponseHandler(_onResponse)
        .addErrorHandler(_onError)
        .build();
  }

  Dio get http => _http;

  get hasAuthToken {
    return _cookieManager.hasCookie(sigaHost, sigaAuthCookieKey);
  }

  void _onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    return handler.next(options);
  }

  void _onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    if (!hasAuthToken) {
      _handleExpiredAuthCookie();
    }

    return handler.next(response);
  }

  void _onError(DioException err, ErrorInterceptorHandler handler) {
    final response = err.response;
    if (response != null &&
        response.statusCode == 302 &&
        response.headers['location'] != null &&
        response.headers['location']!.contains(sigaLogoutRedirectionLocation)) {
      _cookieManager.clearCookies(sigaHost);
      _handleExpiredAuthCookie();
    }
    // this is not helping us because we need to retry to use the correct cookies
    return handler.next(err);
  }

  void _handleExpiredAuthCookie() {
    _routerRefreshListenable.refresh();
  }
}
