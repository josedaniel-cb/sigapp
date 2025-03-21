import 'package:sigapp/courses/domain/entities/academic_history_term.dart';
import 'package:sigapp/courses/domain/entities/program_curriculum_course_term.dart';

class ProgramCurriculumProgress {
  final List<ProgramCurriculumTerm> programCurriculum;
  final List<AcademicHistoryTerm> academicHistory;

  ProgramCurriculumProgress({
    required this.academicHistory,
    required this.programCurriculum,
  });
}
