import 'package:injectable/injectable.dart';
import 'package:sigapp/core/http/siga_client.dart';
import 'package:sigapp/core/utils/date_utils.dart';
import 'package:sigapp/courses/domain/repositories/courses_repository.dart';
import 'package:sigapp/student/domain/entities/enrolled_course.dart';
import 'package:sigapp/student/infrastructure/models/get_enrolled_courses.dart';

@LazySingleton(as: CoursesRepository)
class CoursesRepositoryImpl implements CoursesRepository {
  final SigaClient _sigaClient;

  CoursesRepositoryImpl(this._sigaClient);

  // Node.js request equivalent:
  // fetch("https://academico.unp.edu.pe/Academico/ListarCursosInscritos", {
  //   "headers": {
  //     "accept": "application/json, text/javascript, */*; q=0.01",
  //     "accept-language": "en-PE,en;q=0.9",
  //     "content-type": "application/x-www-form-urlencoded; charset=UTF-8",
  //     "priority": "u=1, i",
  //     "sec-ch-ua": "\"Not A(Brand\";v=\"8\", \"Chromium\";v=\"132\", \"Brave\";v=\"132\"",
  //     "sec-ch-ua-mobile": "?0",
  //     "sec-ch-ua-platform": "\"Windows\"",
  //     "sec-fetch-dest": "empty",
  //     "sec-fetch-mode": "cors",
  //     "sec-fetch-site": "same-origin",
  //     "sec-gpc": "1",
  //     "x-requested-with": "XMLHttpRequest",
  //     "cookie": "ASP.NET_SessionId=zuvxljzuq1j2sfvcorogg5hi; .ASPXAUTH=7E691C82628FAB33D5DDBD4E5D326B430C70BE42B0F1454D3A9FC9C791D6DB55BF671B30774871DADA1BD0483AAD91FDF64118B3F45399496B62F7A86B9BC36116DDFB43D6D2F096BDE1286B64F47CAC27849587AD1B2FEDF10AB472E67C8EEA5C17C70EB125E23293AFFBBE5335368E7E8B61D4DC19C8A6CC7856B5947FB335D2BDE9C7EA6842E7D4B01E70CE44FF06D2015379E3A12F5B5E456366A2F3366558FDBA16DDD4563B033B69B1779B6887EA9C65330634EEF60AAA6107DC9C65C7A30020C87BFFC86A38ABA5079B2461A7",
  //     "Referer": "https://academico.unp.edu.pe/Academico/Boletin",
  //     "Referrer-Policy": "strict-origin-when-cross-origin"
  //   },
  //   "body": "semestre=20212",
  //   "method": "POST"
  // });
  // Payload (form data):
  // semestre=20212
  @override
  Future<List<EnrolledCourse>> getEnrolledCourses(String semesterId) async {
    final response = await _sigaClient.http.post(
      '/Academico/ListarCursosInscritos',
      data: {'semestre': semesterId},
    );
    final models = (response.data['results'] as List).map(
      (json) => GetEnrolledCoursesModel.fromJson(json),
    );
    return models
        .map((model) => EnrolledCourse(
              courseCode: model.CodCurso,
              courseName: model.Curso,
              courseType: CourseType.fromValue(model.TipoCurso),
              credits: model.Creditos,
              date: DateUtils.parseFormattedDate(model.Fecha),
              group: model.Grupo,
              professor: model.Docente,
              section: model.Seccion,
              url: model.Aula,
            ))
        .toList();
  }
}
