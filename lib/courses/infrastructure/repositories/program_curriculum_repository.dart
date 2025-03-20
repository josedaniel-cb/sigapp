import 'package:injectable/injectable.dart';
import 'package:sigapp/core/infrastructure/http/siga_client.dart';
import 'package:sigapp/core/infrastructure/utils/time_utils.dart';
import 'package:sigapp/courses/domain/repositories/courses_repository.dart';
import 'package:sigapp/student/application/usecases/get_academic_report_usecase.dart';
import 'package:sigapp/student/domain/entities/raw_course_requirement.dart';
import 'package:sigapp/courses/domain/entities/enrolled_course_data.dart';
import 'package:sigapp/student/infrastructure/models/get_course_requirements.dart';
import 'package:sigapp/courses/infrastructure/models/get_enrolled_courses.dart';
import 'package:html/parser.dart' as htmlParser;

// @LazySingleton(as: ProgramCurriculumRepository)
// class ProgramCurriculumRepositoryImpl implements ProgramCurriculumRepository {
class ProgramCurriculumRepositoryImpl {
  final SigaClient _sigaClient;

  ProgramCurriculumRepositoryImpl(this._sigaClient);

  /// Node.js request equivalent:
  ///
  /// ```js
  /// fetch("https://academico.unp.edu.pe/Academico/ListarPlanDeEstudios", {
  ///   "headers": {
  ///     "accept": "application/json, text/javascript, */*; q=0.01",
  ///     "accept-language": "en-PE,en;q=0.6",
  ///     "priority": "u=1, i",
  ///     "sec-ch-ua": "\"Chromium\";v=\"134\", \"Not:A-Brand\";v=\"24\", \"Brave\";v=\"134\"",
  ///     "sec-ch-ua-mobile": "?0",
  ///     "sec-ch-ua-platform": "\"Windows\"",
  ///     "sec-fetch-dest": "empty",
  ///     "sec-fetch-mode": "cors",
  ///     "sec-fetch-site": "same-origin",
  ///     "sec-gpc": "1",
  ///     "x-requested-with": "XMLHttpRequest",
  ///     "cookie": "ASP.NET_SessionId=kgw0t4ahbanj3q2bwpyauhzz; .ASPXAUTH=9299A2B6A1E3400FBC27DB2A761543A3F54EC61718EDA6EC66991AD62147A1937CF645125E5C2EC4644B0B03E5A1846234A0464F0043DA2D8DF4423AF964CA4C554F20779030B187B97137E4B47E874DA66FDCA033D9CA59C45E969BA7732063B28356794286BFE16B93A37B5BDC074B57F81D3F0836B179441DC7D89ACEA2012BB68BEEF84A0F62144B457C24D036F020AEAC8BFFEA3E7DBE8F5DAA633E2816524526669210199FFA37E15D19001A66E671ED429CFF30E6C873DECD4D5D1F675A15CBF7DBC5CE1ECD97947AA943C3EF",
  ///     "Referer": "https://academico.unp.edu.pe/Academico/PlanDeEstudios",
  ///     "Referrer-Policy": "strict-origin-when-cross-origin"
  ///   },
  ///   "body": null,
  ///   "method": "POST"
  /// });
  /// ```
  ///
  /// Response:
  /// ```ts
  /// export type Root = {
  ///   results: Array<{
  ///     ExtensionData: {}
  ///     Ciclo: string
  ///     CodCurso: string
  ///     Creditos: number
  ///     DescripCurso: string
  ///     FlagTipoCurso: string
  ///     HorasPractica: number
  ///     HorasTeoria: number
  ///     NroCiclo: number
  ///     ResumenRequisitos: string
  ///   }>
  ///   total: number
  /// }
  /// ```
  // @override
  // Future<List<EnrolledCourseData>> getProgramCurriculum() async {
  //   final response = await _sigaClient.http.post(
  //     '/Academico/ListarPlanDeEstudios',
  //     data: null,
  //   );
  //   final models = (response.data['results'] as List).map(
  //     (json) => GetEnrolledCoursesModel.fromJson(json),
  //   );
  //   return models
  //       .map(
  //         (model) => EnrolledCourseData(
  //           googleClassroomCode: model.Acta?.trim(),
  //           courseCode: model.CodCurso,
  //           courseName: model.Curso,
  //           courseType: CourseType.fromValue(model.TipoCurso),
  //           credits: model.Creditos,
  //           date: TimeUtils.parseFormattedDate(model.Fecha),
  //           group: model.Grupo.trim(),
  //           professor: model.Docente,
  //           section: model.Seccion,
  //           url: model.Aula,
  //           regevaScheduledCourseId: model.ItemProg,
  //         ),
  //       )
  //       .toList();
  // }

  // @override
  // Future<List<String>> getStudentCodeAndRegevaTokens() async {
  //   final response1 = await _sigaClient.http.get('/Academico/Boletin');
  //   final pageSource = response1.data as String;

  //   // Get tokens
  //   final regex = RegExp(r'token1=(.*?)&amp;token2=(.*?)&amp;ip=');
  //   final match = regex.firstMatch(pageSource);

  //   if (match == null) {
  //     throw Exception('Regeva tokens not found');
  //   }
  //   final token1 = match.group(1);
  //   if (token1 == null) throw Exception('Token1 not found');
  //   final token2 = match.group(2);
  //   if (token2 == null) throw Exception('Token2 not found');

  //   // Get student code
  //   final html = htmlParser.parse(pageSource);
  //   final parts =
  //       html.querySelectorAll('dd').map((e) => e.text.trim()).toList();
  //   final studentCode = parts[0].split(' - ')[0];
  //   if (studentCode.isEmpty) throw Exception('Student code not found');

  //   return [studentCode, token1, token2];
  // }
}
