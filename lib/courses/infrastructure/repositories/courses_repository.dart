import 'package:injectable/injectable.dart';
import 'package:sigapp/core/http/siga_client.dart';
import 'package:sigapp/core/utils/time_utils.dart';
import 'package:sigapp/courses/domain/repositories/courses_repository.dart';
import 'package:sigapp/student/domain/entities/raw_course_requirement.dart';
import 'package:sigapp/student/domain/entities/enrolled_course_data.dart';
import 'package:sigapp/student/infrastructure/models/get_course_requirements.dart';
import 'package:sigapp/student/infrastructure/models/get_enrolled_courses.dart';
import 'package:html/parser.dart' as htmlParser;

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
  Future<List<EnrolledCourseData>> getEnrolledCourses(String semesterId) async {
    final response = await _sigaClient.http.post(
      '/Academico/ListarCursosInscritos',
      data: {'semestre': semesterId},
    );
    final models = (response.data['results'] as List).map(
      (json) => GetEnrolledCoursesModel.fromJson(json),
    );
    return models
        .map(
          (model) => EnrolledCourseData(
            courseCode: model.CodCurso,
            courseName: model.Curso,
            courseType: CourseType.fromValue(model.TipoCurso),
            credits: model.Creditos,
            date: TimeUtils.parseFormattedDate(model.Fecha),
            group: model.Grupo.trim(),
            professor: model.Docente,
            section: model.Seccion,
            url: model.Aula,
            regevaScheduledCourseId: model.ItemProg,
          ),
        )
        .toList();
  }

  // fetch("https://academico.unp.edu.pe/Academico/ListarRequisitosAlumno", {
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
  //     "cookie": "ASP.NET_SessionId=zuvxljzuq1j2sfvcorogg5hi; .ASPXAUTH=3F8529D681651C4D30F81078E1DF4A6099445F66245748FA353A42D9CD224E6048C41EDF95745D978E75FB92A639FED3B95C4C859E8F4FC0F4A97FE6108E76FD5C76C0FD834D53CF098CA4B98E7E852C630D261FBC6C6155BBF690E833920953FC76281E7FCB80D75AF6AD2F3F57EE9240D5AA8F1743C752CBFE2B343AE9F26A6C07F253DA10C6E6DD507DC525C7487192372CB42F25C8CAF8698F44C8B1B539CB1880A55CA3866EC1B285AEF869EC48A6B9CE4D03FC0A727E1B23F5D9A813407408E49A74E33688F7D4982E454B42A5",
  //     "Referer": "https://academico.unp.edu.pe/Academico/VerificaCursos",
  //     "Referrer-Policy": "strict-origin-when-cross-origin"
  //   },
  //   "body": "CodCurso=SI1435",
  //   "method": "POST"
  // });
  @override
  Future<List<RawCourseRequirement>> getCourseRequirements(
      String courseCode) async {
    final response = await _sigaClient.http.post(
      '/Academico/ListarRequisitosAlumno',
      data: {'CodCurso': courseCode},
    );
    final models = (response.data['results'] as List)
        .map((json) => GetCourseRequirementsModel.fromJson(json))
        .toList();
    return models
        .map(
          (model) => RawCourseRequirement(
            courseCode: model.CodCursoPlan,
            requiredCourseCode: model.CodCursoRequisito,
            requiredCourseDescription: model.DescCursoRequisito,
            score: model.Nota,
            semesterId: model.Semestre,
          ),
        )
        .toList();
  }

  @override
  Future<List<String>> getStudentCodeAndRegevaTokens() async {
    final response1 = await _sigaClient.http.get('/Academico/Boletin');
    final pageSource = response1.data as String;

    // Get tokens
    final regex = RegExp(r'token1=(.*?)&amp;token2=(.*?)&amp;ip=');
    final match = regex.firstMatch(pageSource);

    if (match == null) {
      throw Exception('Regeva tokens not found');
    }
    final token1 = match.group(1);
    if (token1 == null) throw Exception('Token1 not found');
    final token2 = match.group(2);
    if (token2 == null) throw Exception('Token2 not found');

    // Get student code
    final html = htmlParser.parse(pageSource);
    final parts =
        html.querySelectorAll('dd').map((e) => e.text.trim()).toList();
    final studentCode = parts[0].split(' - ')[0];
    if (studentCode.isEmpty) throw Exception('Student code not found');

    return [studentCode, token1, token2];
  }
}
