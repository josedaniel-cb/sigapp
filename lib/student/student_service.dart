import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:sigapp/app/siga_http.dart';
import 'package:sigapp/student/models/get_academic_report.dart';

@lazySingleton
class StudentService {
  final SigaClient _sigaClient;

  StudentService(this._sigaClient);

  Future<GetAcademicReportInform> getAcademicService() async {
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

    // expected response
    // {"results":{"Facultad":"INGENIERIA INDUSTRIAL","NomAlumno":"0512017039 - CALLE BRICEÑO, JOSE DANIEL","Promocion":"2017","SemestreIngreso":"20171 ","SemestrePlan":"20181 ","UltSemestre":"20212 ","PPA":14.47,"PPAAprob":14.47,"UPPS":15.48,"TotalCredAprob":243,"CredObligPlan":220,"CredElectPlan":15,"CredObligAprob":220,"CredElectAprob":16}}

    final response = await _sigaClient.http.post(
      '/Academico/ListarParametrosInforme',
      options: Options(
        headers: {
          // 'origin': 'https://academico.unp.edu.pe',
          // 'referer': 'https://academico.unp.edu.pe/Academico/InformeAcademico',
        },
      ),
    );
    final result = GetAcademicReportInform.fromJson(response.data['results']);
    return result;
  }
}
