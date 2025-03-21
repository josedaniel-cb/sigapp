import 'package:sigapp/courses/domain/entities/academic_history_term.dart';
import 'package:sigapp/courses/domain/entities/program_curriculum_course_term.dart';

abstract class ProgramCurriculumRepository {
  Future<List<ProgramCurriculumCourseInfo>> getProgramCurriculum();

  Future<List<AcademicHistoryTerm>> getAcademicHistory();
}
