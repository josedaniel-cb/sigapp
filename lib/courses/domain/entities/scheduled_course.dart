import 'package:freezed_annotation/freezed_annotation.dart';

part 'scheduled_course.freezed.dart';

/// From:
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
@freezed
class ScheduledCourse with _$ScheduledCourse {
  factory ScheduledCourse({
    required int? enrollmentCapacity,
    required String period,
    required String courseKey,
    required String classroomCode,
    required String courseCode,
    required String practiceTeacherCode,
    required String theoryTeacherCode,
    required String groupCode,
    required int availableSlots,
    required String classroomDescription,
    required String courseDescription,
    required String practiceTeacher,
    required String theoryTeacher,
    required int enrolledStudents,
    required String regevaCourseId,
    required String section,
  }) = _ScheduledCourse;
}
