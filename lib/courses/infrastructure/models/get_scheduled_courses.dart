import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_scheduled_courses.freezed.dart';
part 'get_scheduled_courses.g.dart';

@freezed
class GetScheduledCourseModel with _$GetScheduledCourseModel {
  /// TS equivalent:
  /// ```ts
  /// export type Root = {
  ///   results: Array<{
  ///     ExtensionData: {}
  ///     Capacidad: number
  ///     Ciclo: string
  ///     ClaveCurso: string
  ///     CodAula: string
  ///     CodCurso: string
  ///     CodDocentePractica: string
  ///     CodDocenteTeoria: string
  ///     CodGrupo: string
  ///     CodTipoProg: any
  ///     Cupos: number
  ///     DescripcionAula: string
  ///     DescripcionCurso: string
  ///     DocentePractica: string
  ///     DocenteTeoria: string
  ///     Escuela: any
  ///     Inscritos: number
  ///     Item: number
  ///     ItemProg: string
  ///     Origen: any
  ///     Seccion: string
  ///     Tipo: any
  ///   }>
  ///   total: number
  /// }
  /// ```
  ///
  /// Example:
  /// ```json
  /// {
  ///     "ExtensionData": {},
  ///     "Capacidad": 40,
  ///     "Ciclo": "01",
  ///     "ClaveCurso": "4000 ",
  ///     "CodAula": "040124",
  ///     "CodCurso": "EC1452",
  ///     "CodDocentePractica": "07890",
  ///     "CodDocenteTeoria": "07890",
  ///     "CodGrupo": "01 ",
  ///     "CodTipoProg": null,
  ///     "Cupos": 0,
  ///     "DescripcionAula": "A-50",
  ///     "DescripcionCurso": "FUNDAMENTOS DE ECONOMIA I",
  ///     "DocentePractica": "E.ZAPATA R.",
  ///     "DocenteTeoria": "E.ZAPATA R.",
  ///     "Escuela": null,
  ///     "Inscritos": 0,
  ///     "Item": 1,
  ///     "ItemProg": "P251040001",
  ///     "Origen": null,
  ///     "Seccion": "01",
  ///     "Tipo": null
  /// }
  /// ```
  factory GetScheduledCourseModel({
    // required dynamic ExtensionData,
    required int Capacidad,
    required String Ciclo,
    required String ClaveCurso,
    required String CodAula,
    required String CodCurso,
    required String CodDocentePractica,
    required String CodDocenteTeoria,
    required String CodGrupo,
    // required String? CodTipoProg,
    required int Cupos,
    required String DescripcionAula,
    required String DescripcionCurso,
    required String DocentePractica,
    required String DocenteTeoria,
    // required String? Escuela,
    required int Inscritos,
    required int Item,
    required String ItemProg,
    // required String? Origen,
    required String Seccion,
    // required String? Tipo,
  }) = _GetScheduledCourseModel;

  factory GetScheduledCourseModel.fromJson(Map<String, dynamic> json) =>
      _$GetScheduledCourseModelFromJson(json);
}
