import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:sigapp/courses/domain/entities/course_type.dart';

part 'program_curriculum_course.freezed.dart';

@unfreezed
class ProgramCurriculumCourse with _$ProgramCurriculumCourse {
  factory ProgramCurriculumCourse({
    // required String ciclo,
    // required String codCurso,
    required String courseCode,
    // required int creditos,
    required int credits,
    // required String descripCurso,
    required String courseName,
    // required String flagTipoCurso,
    required CourseType courseType,
    // required int horasPractica,
    required int practiceHours,
    // required int horasTeoria,
    required int theoryHours,
    // required int nroCiclo,
    required int termNumber,
    // required String resumenRequisitos,
    required List<String> requirementCourseCodes,
  }) = _ProgramCurriculumCourse;
}
