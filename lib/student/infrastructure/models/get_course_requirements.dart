import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_course_requirements.freezed.dart';
part 'get_course_requirements.g.dart';

@freezed
abstract class GetCourseRequirementsModel with _$GetCourseRequirementsModel {
  // {
  //     "results": [
  //         {
  //             "ExtensionData": {},
  //             "CodCursoPlan": "SI1435",
  //             "CodCursoRequisito": "SI1356",
  //             "CreditosRequeridos": null,
  //             "DescCursoRequisito": "INTRODUCCION A LA  INGENIERIA INFORMATICA",
  //             "Nota": "11.00",
  //             "Semestre": "20171 ",
  //             "TieneEquivalencia": "SI",
  //             "TipoCurso": null
  //         },
  //         {
  //             "ExtensionData": {},
  //             "CodCursoPlan": "SI1435",
  //             "CodCursoRequisito": "SI1412",
  //             "CreditosRequeridos": null,
  //             "DescCursoRequisito": "INTRODUCCION A LOS ALGORITMOS",
  //             "Nota": "16.00",
  //             "Semestre": "20171 ",
  //             "TieneEquivalencia": "SI",
  //             "TipoCurso": null
  //         },
  //         {
  //             "ExtensionData": {},
  //             "CodCursoPlan": "SI1435",
  //             "CodCursoRequisito": "SI1435",
  //             "CreditosRequeridos": null,
  //             "DescCursoRequisito": "PROGRAMACION I",
  //             "Nota": "18.00",
  //             "Semestre": "20172 ",
  //             "TieneEquivalencia": "NO",
  //             "TipoCurso": null
  //         }
  //     ],
  //     "total": 3
  // }
  factory GetCourseRequirementsModel({
    required String CodCursoPlan,
    required String CodCursoRequisito,
    required String DescCursoRequisito,
    required String Nota,
    required String Semestre,
  }) = _GetCourseRequirementsModel;

  factory GetCourseRequirementsModel.fromJson(Map<String, dynamic> json) =>
      _$GetCourseRequirementsModelFromJson(json);
}
