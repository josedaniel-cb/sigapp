import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:sigapp/app/siga_http.dart';

@lazySingleton
class AuthService {
  final SigaClient _sigaClient;

  AuthService(this._sigaClient);

  Future<bool> login(String username, String password) async {
    // First

    // curl 'https://academico.unp.edu.pe/' \
    //   -H 'accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7' \
    //   -H 'accept-language: en-US,en;q=0.9,es-PE;q=0.8,es-ES;q=0.7,es;q=0.6' \
    //   -H 'cache-control: max-age=0' \
    //   -H 'content-type: application/x-www-form-urlencoded' \
    //   -H 'origin: https://academico.unp.edu.pe' \
    //   -H 'priority: u=0, i' \
    //   -H 'referer: https://academico.unp.edu.pe/' \
    //   -H 'sec-ch-ua: "Not/A)Brand";v="8", "Chromium";v="126", "Microsoft Edge";v="126"' \
    //   -H 'sec-ch-ua-mobile: ?0' \
    //   -H 'sec-ch-ua-platform: "Windows"' \
    //   -H 'sec-fetch-dest: document' \
    //   -H 'sec-fetch-mode: navigate' \
    //   -H 'sec-fetch-site: same-origin' \
    //   -H 'sec-fetch-user: ?1' \
    //   -H 'upgrade-insecure-requests: 1' \
    //   -H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36 Edg/126.0.0.0' \
    //   --data-raw 'Instancia=01&CodAlumno=0512017039&ClaveWeb=fanatico&g-recaptcha-response='

    // (expected response is a 302 redirect to https://academico.unp.edu.pe/Home/Index)

    // Now, replicate using Dio
    final loginResponse = await _sigaClient.http.post(
      '/',
      data: {
        'Instancia': '01',
        'CodAlumno': username,
        'ClaveWeb': password,
        'g-recaptcha-response': '',
      },
      options: Options(
        headers: {
          // 'accept':
          //     'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7',
          // 'accept-language': 'en-US,en;q=0.9,es-PE;q=0.8,es-ES;q=0.7,es;q=0.6',
          // 'cache-control': 'max-age=0',
          'content-type': 'application/x-www-form-urlencoded',
          // 'origin': 'https://academico.unp.edu.pe',
          // 'referer': 'https://academico.unp.edu.pe/',
          // 'sec-ch-ua':
          //     '"Not/A)Brand";v="8", "Chromium";v="126", "Microsoft Edge";v="126"',
          // 'sec-ch-ua-mobile': '?0',
          // 'sec-ch-ua-platform': '"Windows"',
          // 'sec-fetch-dest': 'document',
          // 'sec-fetch-mode': 'navigate',
          // 'sec-fetch-site': 'same-origin',
          // 'sec-fetch-user': '?1',
          // 'upgrade-insecure-requests': '1',
        },
        followRedirects: false,
        validateStatus: (status) {
          return true;
        },
      ),
    );

    // Success
    if (loginResponse.statusCode == 302) {
      return true;
    }

    // Failure
    if (loginResponse.statusCode == 200) {
      return false;
    }

    // Error
    throw Exception('Status code ${loginResponse.statusCode}');
  }

  void logout() {
    // final key = 'cookies_${'academico.unp.edu.pe'}';
    // final cookies = _prefs
    //     .getStringList(key)
    //     // ?.where((cookie) => !cookie.startsWith('.ASPXAUTH='))
    //     ?.where((cookie) => !cookie.contains('.ASPXAUTH=')
    //         // || !cookie.contains('ASP.NET_SessionId=')
    //         )
    //     .toList();
    // if (cookies == null) {
    //   _prefs.remove(key);
    // } else {
    //   _prefs.setStringList(key, cookies);
    // }
    // getIt<RouterRefreshListenable>().refresh();
    _sigaClient.logout();
  }
}
