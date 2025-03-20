import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'get_enrolled_courses.freezed.dart';
part 'get_enrolled_courses.g.dart';

/// Model for
/// ```json
/// {
///     "results": [
///         {
///             "ExtensionData": {},
///             "Acta": null,
///             "Activo": null,
///             "Aula": "",
///             "CeroEnActa": 0,
///             "ClaveCurso": "5279 ",
///             "CodCurso": "CO5397",
///             "Creditos": 3,
///             "Cupos": 0,
///             "Curso": "CONTABILIDAD DE COSTOS Y PRESUPUESTOS",
///             "Desaprobados": 0,
///             "Docente": "C.ANCAJIMA P.",
///             "EstadoInscripcion": null,
///             "Fecha": "2021/11/18",
///             "FechaInscripcion": "\/Date(-62135578800000)\/",
///             "Grupo": "09 ",
///             "Item": 0,
///             "ItemProg": "P212050094",
///             "Observacion": "INSCRITO",
///             "Seccion": "01",
///             "Sylabus": {
///                 "ExtensionData": {},
///                 "IdArchivo": null,
///                 "NombreArchivo": null
///             },
///             "TipoCurso": "O"
///         },
///         {
///             "ExtensionData": {},
///             "Acta": "gzd4cy2   ",
///             "Activo": null,
///             "Aula": "https:///classroom.google.com/u/1/c/NDMzMzM5NjQ1OTE0",
///             "CeroEnActa": 0,
///             "ClaveCurso": "5264 ",
///             "CodCurso": "SI5367",
///             "Creditos": 3,
///             "Cupos": 0,
///             "Curso": "DESARROLLO DE LA INVESTIGACION INFORMATICA",
///             "Desaprobados": 0,
///             "Docente": "M.SAAVEDRA A",
///             "EstadoInscripcion": null,
///             "Fecha": "2021/11/27",
///             "FechaInscripcion": "\/Date(-62135578800000)\/",
///             "Grupo": "10 ",
///             "Item": 0,
///             "ItemProg": "P212050089",
///             "Observacion": "INSCRITO",
///             "Seccion": "02",
///             "Sylabus": {
///                 "ExtensionData": {},
///                 "IdArchivo": null,
///                 "NombreArchivo": null
///             },
///             "TipoCurso": "O"
///         },
///         {
///             "ExtensionData": {},
///             "Acta": "zamdwjm   ",
///             "Activo": null,
///             "Aula": "https:///classroom.google.com/c/NDM5MTgxNjM2MDIw?cjc=zamdwjm",
///             "CeroEnActa": 0,
///             "ClaveCurso": "5276 ",
///             "CodCurso": "SI5411",
///             "Creditos": 4,
///             "Cupos": 0,
///             "Curso": "GESTION EN INFORMATICA",
///             "Desaprobados": 0,
///             "Docente": "Y.LIZANA P.",
///             "EstadoInscripcion": null,
///             "Fecha": "2021/11/18",
///             "FechaInscripcion": "\/Date(-62135578800000)\/",
///             "Grupo": "14 ",
///             "Item": 0,
///             "ItemProg": "P212050093",
///             "Observacion": "INSCRITO",
///             "Seccion": "01",
///             "Sylabus": {
///                 "ExtensionData": {},
///                 "IdArchivo": null,
///                 "NombreArchivo": null
///             },
///             "TipoCurso": "O"
///         },
///         {
///             "ExtensionData": {},
///             "Acta": null,
///             "Activo": null,
///             "Aula": "",
///             "CeroEnActa": 0,
///             "ClaveCurso": "5588 ",
///             "CodCurso": "SI5496",
///             "Creditos": 4,
///             "Cupos": 0,
///             "Curso": "SEGURIDAD DE LA INFORMACION",
///             "Desaprobados": 0,
///             "Docente": "W.CRUZ Y.",
///             "EstadoInscripcion": null,
///             "Fecha": "2021/11/18",
///             "FechaInscripcion": "\/Date(-62135578800000)\/",
///             "Grupo": "13 ",
///             "Item": 0,
///             "ItemProg": "P212050197",
///             "Observacion": "INSCRITO",
///             "Seccion": "02",
///             "Sylabus": {
///                 "ExtensionData": {},
///                 "IdArchivo": null,
///                 "NombreArchivo": null
///             },
///             "TipoCurso": "O"
///         },
///         {
///             "ExtensionData": {},
///             "Acta": null,
///             "Activo": null,
///             "Aula": "",
///             "CeroEnActa": 0,
///             "ClaveCurso": "5270 ",
///             "CodCurso": "SI5498",
///             "Creditos": 4,
///             "Cupos": 0,
///             "Curso": "SISTEMAS ORIENTADOS A SERVICIOS",
///             "Desaprobados": 0,
///             "Docente": "V.ANCAJIMA M.",
///             "EstadoInscripcion": null,
///             "Fecha": "2021/11/18",
///             "FechaInscripcion": "\/Date(-62135578800000)\/",
///             "Grupo": "12 ",
///             "Item": 0,
///             "ItemProg": "P212050091",
///             "Observacion": "INSCRITO",
///             "Seccion": "01",
///             "Sylabus": {
///                 "ExtensionData": {},
///                 "IdArchivo": null,
///                 "NombreArchivo": null
///             },
///             "TipoCurso": "O"
///         },
///         {
///             "ExtensionData": {},
///             "Acta": null,
///             "Activo": null,
///             "Aula": "",
///             "CeroEnActa": 0,
///             "ClaveCurso": "5267 ",
///             "CodCurso": "SI5368",
///             "Creditos": 3,
///             "Cupos": 0,
///             "Curso": "TECNOLOGIA Y DESARROLLO MOVIL",
///             "Desaprobados": 0,
///             "Docente": "A.SANDOVAL R.",
///             "EstadoInscripcion": null,
///             "Fecha": "2021/11/18",
///             "FechaInscripcion": "\/Date(-62135578800000)\/",
///             "Grupo": "11 ",
///             "Item": 0,
///             "ItemProg": "P212050090",
///             "Observacion": "INSCRITO",
///             "Seccion": "01",
///             "Sylabus": {
///                 "ExtensionData": {},
///                 "IdArchivo": null,
///                 "NombreArchivo": null
///             },
///             "TipoCurso": "O"
///         }
///     ],
///     "total": 6
/// }
/// ```
@freezed
class GetEnrolledCoursesModel with _$GetEnrolledCoursesModel {
  const factory GetEnrolledCoursesModel({
    required String? Acta,
    required String? Activo,
    required String Aula,
    required int CeroEnActa,
    required String ClaveCurso,
    required String CodCurso,
    required int Creditos,
    required int Cupos,
    required String Curso,
    required int Desaprobados,
    required String Docente,
    required String? EstadoInscripcion,
    required String Fecha,
    required String FechaInscripcion,
    required String Grupo,
    required int Item,
    required String ItemProg,
    required String Observacion,
    required String Seccion,
    required dynamic Sylabus,
    required String TipoCurso,
  }) = _GetEnrolledCoursesModel;

  factory GetEnrolledCoursesModel.fromJson(Map<String, Object?> json) =>
      _$GetEnrolledCoursesModelFromJson(json);
}
