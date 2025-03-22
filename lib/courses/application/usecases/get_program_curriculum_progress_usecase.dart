import 'package:injectable/injectable.dart';
import 'package:sigapp/courses/domain/repositories/program_curriculum_repository.dart';
import 'package:sigapp/courses/domain/entities/program_curriculum_course_term.dart';
import 'package:sigapp/courses/domain/value-objects/program_curriculum_progress.dart';

@lazySingleton
class GetProgramCurriculumProgressUsecase {
  final ProgramCurriculumRepository _programCurriculumRepository;

  GetProgramCurriculumProgressUsecase(this._programCurriculumRepository);

  Future<ProgramCurriculumProgress> execute() async {
    // Get program curriculum
    final programCurriculum = await _getTermCoursesMap();

    // Get academic history
    final academicHistoryTerms =
        await _programCurriculumRepository.getAcademicHistory();

    // Set last grades for program curriculum courses
    final academicHistoryCourses =
        academicHistoryTerms.expand((term) => term.courses).toList();
    for (var term in programCurriculum) {
      for (var course in term.courses) {
        final courseInfo = course.info;
        final history = academicHistoryCourses.where((courseHistory) =>
            courseHistory.courseCode == courseInfo.courseCode);
        if (history.isNotEmpty) {
          course.lastGrade = history.last.grade;
        }
      }
    }

    return ProgramCurriculumProgress(
      programCurriculum: programCurriculum,
      academicHistory: academicHistoryTerms,
    );
  }

  Future<List<ProgramCurriculumTerm>> _getTermCoursesMap() async {
    final courses = await _programCurriculumRepository.getProgramCurriculum();
    final courseCodeMap = {for (var e in courses) e.courseCode: e};
    final coursesWithPrerequisites = courses
        .map(
          (course) => ProgramCurriculumCourse(
            info: course,
            requirements: course.requirementCourseCodes
                .map((code) => courseCodeMap[code])
                .whereType<ProgramCurriculumCourseInfo>()
                .toList(),
          ),
        )
        .toList();
    final termNumberMap = <int, List<ProgramCurriculumCourse>>{};
    for (var courseWithPrerequisites in coursesWithPrerequisites) {
      final termNumber = courseWithPrerequisites.info.termNumber;
      if (!termNumberMap.containsKey(termNumber)) {
        termNumberMap[termNumber] = [];
      }
      termNumberMap[termNumber]!.add(courseWithPrerequisites);
    }
    final terms = termNumberMap.entries
        .map(
          (entry) => ProgramCurriculumTerm(
            termNumber: entry.key,
            courses: entry.value,
          ),
        )
        .toList();
    return terms;
  }
}
