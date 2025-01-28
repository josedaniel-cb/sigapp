import 'package:injectable/injectable.dart';
import 'package:sigapp/core/http/siga_client.dart';
import 'package:sigapp/student/infrastructure/models/get_academic_report.dart';
import 'package:sigapp/student/infrastructure/models/get_class_schedule.dart';
import 'package:html/parser.dart' as htmlParser;
import 'package:sigapp/student/infrastructure/models/get_session_student_info.dart';

@lazySingleton
class StudentRepository {
  final SigaClient _sigaClient;

  StudentRepository(this._sigaClient);

  Future<GetSessionStudentInfoModel> getSessionStudentInfo() async {
    final response = await _sigaClient.http.get('/Home/Index');
    final rawHtml = response.data as String;
    final html = htmlParser.parse(rawHtml);
    final parts =
        html.querySelectorAll('dd').map((e) => e.text.trim()).toList();
    if (parts.length < 4) {
      // TODO: LOGOUT?
      throw Exception('Session info not found');
    }
    final currentSemesterId = parts[3];
    final schoolName = parts[1];
    return GetSessionStudentInfoModel(
      currentSemesterId: currentSemesterId,
      schoolName: schoolName,
    );
  }

  Future<GetAcademicReportModel> getAcademicReport() async {
    // {"results":{"Facultad":"INGENIERIA INDUSTRIAL","NomAlumno":"0512017039 - CALLE BRICEÑO, JOSE DANIEL","Promocion":"2017","SemestreIngreso":"20171 ","SemestrePlan":"20181 ","UltSemestre":"20212 ","PPA":14.47,"PPAAprob":14.47,"UPPS":15.48,"TotalCredAprob":243,"CredObligPlan":220,"CredElectPlan":15,"CredObligAprob":220,"CredElectAprob":16}}
    final response =
        await _sigaClient.http.post('/Academico/ListarParametrosInforme');
    final result = GetAcademicReportModel.fromJson(response.data['results']);

    return result;
  }

  Future<List<GetClassScheduleModel>> getClassSchedule(
      String semesterId) async {
    // {"results":[{"ExtensionData":{},"HoraFinal":"\/Date(1307539800000)\/","HoraInicio":"\/Date(1307534400000)\/","Jueves":"","Lunes":"","Martes":"","Miercoles":"DERECHO INFORMATICO ? PII-A14-4P","Sabado":"","Viernes":"SISTEMAS DE INFORMACION GERENCIAL ? I-6"},{"ExtensionData":{},"HoraFinal":"\/Date(1307545200000)\/","HoraInicio":"\/Date(1307539800000)\/","Jueves":"","Lunes":"","Martes":"SISTEMAS DE INFORMACION GERENCIAL ? I-6","Miercoles":"","Sabado":"","Viernes":"DERECHO INFORMATICO ? PII-A14-4P"},{"ExtensionData":{},"HoraFinal":"\/Date(1307552400000)\/","HoraInicio":"\/Date(1307545200000)\/","Jueves":"DERECHO INFORMATICO ? PII-A14-4P","Lunes":"SISTEMAS DE INFORMACION GERENCIAL ? I-6","Martes":"","Miercoles":"","Sabado":"","Viernes":""},{"ExtensionData":{},"HoraFinal":"\/Date(1307556000000)\/","HoraInicio":"\/Date(1307552400000)\/","Jueves":"","Lunes":"","Martes":"","Miercoles":"INGENIERIA DE SOFTWARE ? PII-A14-4P","Sabado":"","Viernes":""},{"ExtensionData":{},"HoraFinal":"\/Date(1307559600000)\/","HoraInicio":"\/Date(1307552400000)\/","Jueves":"QUIMICA GENERAL ? PII-A02-1P","Lunes":"INGENIERIA DE SOFTWARE ? PII-A14-4P","Martes":"INGENIERIA DE SOFTWARE ? PII-A14-4P","Miercoles":"","Sabado":"","Viernes":"QUIMICA GENERAL ? PII-A02-1P"},{"ExtensionData":{},"HoraFinal":"\/Date(1307559600000)\/","HoraInicio":"\/Date(1307556000000)\/","Jueves":"","Lunes":"","Martes":"","Miercoles":"QUIMICA GENERAL ? PII-A02-1P","Sabado":"","Viernes":""},{"ExtensionData":{},"HoraFinal":"\/Date(1307563200000)\/","HoraInicio":"\/Date(1307559600000)\/","Jueves":"","Lunes":"","Martes":"","Miercoles":"LOGISTICA EMPRESARIAL ? PII-A10-3P","Sabado":"","Viernes":""},{"ExtensionData":{},"HoraFinal":"\/Date(1307566800000)\/","HoraInicio":"\/Date(1307559600000)\/","Jueves":"ANALISIS DE ALGORITMOS ? PII-A10-3P","Lunes":"LOGISTICA EMPRESARIAL ? PII-A10-3P","Martes":"LOGISTICA EMPRESARIAL ? PII-A10-3P","Miercoles":"","Sabado":"","Viernes":"ANALISIS DE ALGORITMOS ? PII-A10-3P"},{"ExtensionData":{},"HoraFinal":"\/Date(1307566800000)\/","HoraInicio":"\/Date(1307563200000)\/","Jueves":"","Lunes":"","Martes":"","Miercoles":"ANALISIS DE ALGORITMOS ? PII-A10-3P","Sabado":"","Viernes":""},{"ExtensionData":{},"HoraFinal":"\/Date(1307572200000)\/","HoraInicio":"\/Date(1307566800000)\/","Jueves":"SISTEMAS OPERATIVOS ? PII-A02-1P","Lunes":"","Martes":"","Miercoles":"","Sabado":"","Viernes":""},{"ExtensionData":{},"HoraFinal":"\/Date(1307577600000)\/","HoraInicio":"\/Date(1307572200000)\/","Jueves":"","Lunes":"SISTEMAS OPERATIVOS ? PII-A02-1P","Martes":"","Miercoles":"","Sabado":"","Viernes":""},{"ExtensionData":{},"HoraFinal":"\/Date(1307584800000)\/","HoraInicio":"\/Date(1307577600000)\/","Jueves":"","Lunes":"","Martes":"","Miercoles":"","Sabado":"","Viernes":"SISTEMAS OPERATIVOS ? PII-A02-1P"}],"total":12}
    final response = await _sigaClient.http.post(
      '/Academico/ListarHorario',
      data: {'semestre': semesterId},
    );
    return (response.data['results'] as List)
        .map((json) => GetClassScheduleModel.fromJson(json))
        .toList();
  }
}
