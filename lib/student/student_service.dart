import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:sigapp/app/siga_client.dart';
import 'package:sigapp/student/models/get_academic_report.dart';
import 'package:sigapp/student/models/get_class_schedule.dart';

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

  Future<List<GetClassScheduleModel>> getClassSchedule(String semester) async {
    // Request
    // curl 'https://academico.unp.edu.pe/Academico/ListarHorario' \
    //   -H 'accept: application/json, text/javascript, */*; q=0.01' \
    //   -H 'accept-language: en-US,en;q=0.9,es-PE;q=0.8,es-ES;q=0.7,es;q=0.6' \
    //   -H 'content-type: application/x-www-form-urlencoded; charset=UTF-8' \
    //   -H 'cookie: ASP.NET_SessionId=stactn4sojhvn4kxi4hyzgvv; .ASPXAUTH=D7B1D6E899CE40E4A8034E1BED6E74D84CFA3D54552C3EF6D9E7DD1924BC8F744C66E1823B1E7EAA57131AC3001369114A35394FA1A29802D73669025B47305E92083F32E7B400B6C00EF78E3862081CC1E6D13ED3E0ED6094F1430D2588F9A220EC35EA8B9117B7D7A5058AD40D5070038050AD663F5C16FA0771935FDA59CB2DE04F6F0B6B52E7CEF14A3342C0FFE5DC284EAD62C8B23FFC2F0DED8DEC6E5833E7949FF44CE308B625ECE6C5C24747C846E8D95D48AF92075D218BA6E29C816A22231C4D24AF95B447D802A7FDB1F7' \
    //   -H 'origin: https://academico.unp.edu.pe' \
    //   -H 'priority: u=1, i' \
    //   -H 'referer: https://academico.unp.edu.pe/Academico/Horario' \
    //   -H 'sec-ch-ua: "Not)A;Brand";v="99", "Microsoft Edge";v="127", "Chromium";v="127"' \
    //   -H 'sec-ch-ua-mobile: ?0' \
    //   -H 'sec-ch-ua-platform: "Windows"' \
    //   -H 'sec-fetch-dest: empty' \
    //   -H 'sec-fetch-mode: cors' \
    //   -H 'sec-fetch-site: same-origin' \
    //   -H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36 Edg/127.0.0.0' \
    //   -H 'x-requested-with: XMLHttpRequest' \
    //   --data-raw 'semestre=20202'

    // Response
    // {"results":[{"ExtensionData":{},"HoraFinal":"\/Date(1307539800000)\/","HoraInicio":"\/Date(1307534400000)\/","Jueves":"","Lunes":"","Martes":"","Miercoles":"DERECHO INFORMATICO ? PII-A14-4P","Sabado":"","Viernes":"SISTEMAS DE INFORMACION GERENCIAL ? I-6"},{"ExtensionData":{},"HoraFinal":"\/Date(1307545200000)\/","HoraInicio":"\/Date(1307539800000)\/","Jueves":"","Lunes":"","Martes":"SISTEMAS DE INFORMACION GERENCIAL ? I-6","Miercoles":"","Sabado":"","Viernes":"DERECHO INFORMATICO ? PII-A14-4P"},{"ExtensionData":{},"HoraFinal":"\/Date(1307552400000)\/","HoraInicio":"\/Date(1307545200000)\/","Jueves":"DERECHO INFORMATICO ? PII-A14-4P","Lunes":"SISTEMAS DE INFORMACION GERENCIAL ? I-6","Martes":"","Miercoles":"","Sabado":"","Viernes":""},{"ExtensionData":{},"HoraFinal":"\/Date(1307556000000)\/","HoraInicio":"\/Date(1307552400000)\/","Jueves":"","Lunes":"","Martes":"","Miercoles":"INGENIERIA DE SOFTWARE ? PII-A14-4P","Sabado":"","Viernes":""},{"ExtensionData":{},"HoraFinal":"\/Date(1307559600000)\/","HoraInicio":"\/Date(1307552400000)\/","Jueves":"QUIMICA GENERAL ? PII-A02-1P","Lunes":"INGENIERIA DE SOFTWARE ? PII-A14-4P","Martes":"INGENIERIA DE SOFTWARE ? PII-A14-4P","Miercoles":"","Sabado":"","Viernes":"QUIMICA GENERAL ? PII-A02-1P"},{"ExtensionData":{},"HoraFinal":"\/Date(1307559600000)\/","HoraInicio":"\/Date(1307556000000)\/","Jueves":"","Lunes":"","Martes":"","Miercoles":"QUIMICA GENERAL ? PII-A02-1P","Sabado":"","Viernes":""},{"ExtensionData":{},"HoraFinal":"\/Date(1307563200000)\/","HoraInicio":"\/Date(1307559600000)\/","Jueves":"","Lunes":"","Martes":"","Miercoles":"LOGISTICA EMPRESARIAL ? PII-A10-3P","Sabado":"","Viernes":""},{"ExtensionData":{},"HoraFinal":"\/Date(1307566800000)\/","HoraInicio":"\/Date(1307559600000)\/","Jueves":"ANALISIS DE ALGORITMOS ? PII-A10-3P","Lunes":"LOGISTICA EMPRESARIAL ? PII-A10-3P","Martes":"LOGISTICA EMPRESARIAL ? PII-A10-3P","Miercoles":"","Sabado":"","Viernes":"ANALISIS DE ALGORITMOS ? PII-A10-3P"},{"ExtensionData":{},"HoraFinal":"\/Date(1307566800000)\/","HoraInicio":"\/Date(1307563200000)\/","Jueves":"","Lunes":"","Martes":"","Miercoles":"ANALISIS DE ALGORITMOS ? PII-A10-3P","Sabado":"","Viernes":""},{"ExtensionData":{},"HoraFinal":"\/Date(1307572200000)\/","HoraInicio":"\/Date(1307566800000)\/","Jueves":"SISTEMAS OPERATIVOS ? PII-A02-1P","Lunes":"","Martes":"","Miercoles":"","Sabado":"","Viernes":""},{"ExtensionData":{},"HoraFinal":"\/Date(1307577600000)\/","HoraInicio":"\/Date(1307572200000)\/","Jueves":"","Lunes":"SISTEMAS OPERATIVOS ? PII-A02-1P","Martes":"","Miercoles":"","Sabado":"","Viernes":""},{"ExtensionData":{},"HoraFinal":"\/Date(1307584800000)\/","HoraInicio":"\/Date(1307577600000)\/","Jueves":"","Lunes":"","Martes":"","Miercoles":"","Sabado":"","Viernes":"SISTEMAS OPERATIVOS ? PII-A02-1P"}],"total":12}
    final response = await _sigaClient.http.post(
      '/Academico/ListarHorario',
      options: Options(
        headers: {
          // 'origin': 'https://academico.unp.edu.pe',
          // 'referer': 'https://academico.unp.edu.pe/Academico/Horario',
        },
      ),
      data: {
        'semestre': semester,
      },
    );
    return (response.data['results'] as List)
        .map((json) => GetClassScheduleModel.fromJson(json))
        .toList();
  }
}
