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
    final courseInfos =
        await _programCurriculumRepository.getProgramCurriculum();
    final courses = courseInfos
        .map((info) => ProgramCurriculumCourse(info: info, prerequisites: []))
        .toList();
    final courseCodeMap = {for (var e in courses) e.info.courseCode: e};
    for (var course in courses) {
      course.prerequisites.addAll(course.info.requirementCourseCodes
          .map((code) => courseCodeMap[code]!));
    }
    final termNumberMap = <int, List<ProgramCurriculumCourse>>{};
    for (var course in courses) {
      final termNumber = course.info.termNumber;
      if (!termNumberMap.containsKey(termNumber)) {
        termNumberMap[termNumber] = [];
      }
      termNumberMap[termNumber]!.add(course);
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
