import 'package:injectable/injectable.dart';
import 'package:sigapp/courses/application/usecases/get_enrolled_courses_usecase.dart';
import 'package:sigapp/courses/domain/entities/academic_history_term.dart';
import 'package:sigapp/courses/domain/repositories/program_curriculum_repository.dart';
import 'package:sigapp/courses/domain/entities/program_curriculum_course_term.dart';
import 'package:sigapp/courses/domain/value-objects/program_curriculum_progress.dart';
import 'package:sigapp/student/domain/services/academic_info_service.dart';
import 'package:sigapp/student/domain/value_objects/semester_context.dart';
import 'dart:developer' as developer;

@lazySingleton
class GetProgramCurriculumProgressUsecase {
  final ProgramCurriculumRepository _programCurriculumRepository;
  final AcademicInfoService _academicInfoService;
  final GetEnrolledCoursesUsecase _getEnrolledCoursesUsecase;

  GetProgramCurriculumProgressUsecase(this._programCurriculumRepository,
      this._academicInfoService, this._getEnrolledCoursesUsecase);

  Future<ProgramCurriculumProgress> execute() async {
    final programCurriculum = await _getTermCoursesMap();
    List<AcademicHistoryTerm> academicHistoryTerms = [];
    try {
      academicHistoryTerms =
          await _programCurriculumRepository.getAcademicHistory();
    } catch (e, s) {
      developer.log(
        'Error obteniendo el historial académico: $e',
        name: 'GetProgramCurriculumProgressUsecase',
        error: e,
        stackTrace: s,
      );
    }

    await _setLastGradesForCourses(programCurriculum, academicHistoryTerms);
    await _setEnrolledCourses(programCurriculum);

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

  Future<void> _setLastGradesForCourses(
    List<ProgramCurriculumTerm> programCurriculum,
    List<AcademicHistoryTerm> academicHistoryTerms,
  ) async {
    final academicHistoryCourses =
        academicHistoryTerms.expand((term) => term.courses).toList();

    for (var term in programCurriculum) {
      for (var course in term.courses) {
        final matchingHistory = academicHistoryCourses.where(
          (courseHistory) => courseHistory.courseCode == course.info.courseCode,
        );

        for (final courseHistory in matchingHistory) {
          courseHistory.programCurriculumCourse = course;
        }

        if (matchingHistory.isNotEmpty) {
          course.lastGrade = matchingHistory.last.grade;
        }
      }
    }
  }

  Future<void> _setEnrolledCourses(
      List<ProgramCurriculumTerm> programCurriculum) async {
    final semesterContext = await _academicInfoService
        .getSessionInfo()
        .then((v) => v.semesterContext);

    if (semesterContext.contextType != SemesterContextType.currentlyEnrolled) {
      return;
    }

    final enrolledCourses = await _getEnrolledCoursesUsecase
        .execute(semesterContext.defaultSemester.id);

    final coursesWithoutGrades = programCurriculum
        .expand((term) => term.courses)
        .where((course) => course.lastGrade == null);

    for (var course in coursesWithoutGrades) {
      course.isEnrolled = enrolledCourses.any((enrolledCourse) =>
          enrolledCourse.data.courseCode == course.info.courseCode);
    }
  }
}
