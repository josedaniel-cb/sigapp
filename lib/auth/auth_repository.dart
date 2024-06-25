import 'dart:async';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:sigapp/app/siga_client.dart';

@singleton
class AuthRepository {
  final SigaClient _sigaClient;

  AuthRepository(this._sigaClient);

  Future<Response<dynamic>> login(String username, String password) async {
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
    final response = await _sigaClient.http.post(
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
    return response;
  }

  Future<Response<dynamic>> keepSession() async {
    // curl 'https://academico.unp.edu.pe/Home/KeepSession' \
    //   -X 'POST' \
    //   -H 'accept: application/json, text/javascript, */*; q=0.01' \
    //   -H 'accept-language: en-US,en;q=0.9,es-PE;q=0.8,es-ES;q=0.7,es;q=0.6' \
    //   -H 'content-length: 0' \
    //   -H 'cookie: ASP.NET_SessionId=stactn4sojhvn4kxi4hyzgvv; .ASPXAUTH=887F6F1D4D9E4EA7B6D76273C2AFC9212D87F79799A3037E0D48D5358128A18340543D9D5CF4C0BFE0E5F0429EB7843E3332F6E5D5C90265AF6038F57F80D14213C7AAD547664A7312D33B366595E86842F38E565666705850D084DBCB4AEF0DA9A4773E7659BD6B138C99C29FE488F5A273370E053D950512BFF4E8C06DB7865227C6AD5DA6B2740399A130AA58FE1F5DC49420A1EA4335F81DDA3A83485950D536263D342FB338CEB4F92E9118FE25FF4F7ABDA99F9EBFF63FF0A3957CCD47A8C9FB24116DA389B33A0071FB3974AD' \
    //   -H 'origin: https://academico.unp.edu.pe' \
    //   -H 'priority: u=1, i' \
    //   -H 'referer: https://academico.unp.edu.pe/Home/Index' \
    //   -H 'sec-ch-ua: "Not)A;Brand";v="99", "Microsoft Edge";v="127", "Chromium";v="127"' \
    //   -H 'sec-ch-ua-mobile: ?0' \
    //   -H 'sec-ch-ua-platform: "Windows"' \
    //   -H 'sec-fetch-dest: empty' \
    //   -H 'sec-fetch-mode: cors' \
    //   -H 'sec-fetch-site: same-origin' \
    //   -H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36 Edg/127.0.0.0' \
    //   -H 'x-requested-with: XMLHttpRequest'
    final response = await _sigaClient.http.post('/Home/KeepSession',
        options: Options(
          validateStatus: (status) => true,
        ));
    return response;
  }
}
