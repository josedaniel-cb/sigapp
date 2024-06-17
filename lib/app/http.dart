import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@singleton
class DioClientBuilder {
  final Dio _dio = Dio();
  final SharedPreferences _prefs;

  DioClientBuilder(this._prefs) {
    _dio.interceptors.add(_CookieInterceptor(_prefs));
  }

  DioClientBuilder setBaseUrl(String baseUrl) {
    _dio.options.baseUrl = baseUrl;
    return this;
  }

  DioClientBuilder setConnectTimeout(int timeout) {
    _dio.options.connectTimeout = Duration(milliseconds: timeout);
    return this;
  }

  DioClientBuilder setReceiveTimeout(int timeout) {
    _dio.options.receiveTimeout = Duration(milliseconds: timeout);
    return this;
  }

  DioClientBuilder addHeader(String key, String value) {
    _dio.options.headers[key] = value;
    return this;
  }

  Dio build() {
    return _dio;
  }
}

class _CookieInterceptor extends Interceptor {
  final SharedPreferences _prefs;

  _CookieInterceptor(this._prefs);

  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final cookies = _prefs.getStringList('cookies_${options.uri.host}') ?? [];
    if (cookies.isNotEmpty) {
      options.headers['Cookie'] = cookies.join('; ');
    }
    return handler.next(options);
  }

  @override
  Future onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    final setCookieHeader = response.headers['set-cookie'];
    if (setCookieHeader != null && setCookieHeader.isNotEmpty) {
      final cookies = setCookieHeader.map((cookie) {
        final parts = cookie.split(';').first.split('=');
        return '${parts[0]}=${parts[1]}';
      }).toList();
      await _prefs.setStringList(
          'cookies_${response.requestOptions.uri.host}', cookies);
    }
    return handler.next(response);
  }
}

// // Uso del DioClientBuilder para crear un cliente Dio
// void main() async {
//   final dioClient = DioClientBuilder()
//       .setBaseUrl('https://example.com')
//       .setConnectTimeout(5000)
//       .setReceiveTimeout(3000)
//       .addHeader('Content-Type', 'application/json')
//       .build();

//   // Ejemplo de uso con solicitudes GET y POST
//   final responseGet = await dioClient.get('/path');
//   print(responseGet.data);

//   final responsePost = await dioClient.post('/path', data: {'key': 'value'});
//   print(responsePost.data);
// }
