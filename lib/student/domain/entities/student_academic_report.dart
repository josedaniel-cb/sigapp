import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sigapp/courses/domain/entities/scheduled_term_identifier.dart';

part 'student_academic_report.freezed.dart';

@freezed
abstract class AcademicReport with _$AcademicReport {
  factory AcademicReport({
    required String faculty,
    required String school,
    required String firstName,
    required String lastName,
    required String code,
    required String cohort,
    // required String enrollmentSemesterId,
    // required String curriculumSemesterId,
    // required String? lastSemesterId,
    required ScheduledTermIdentifier enrollmentSemester,
    // required ScheduledTermIdentifier curriculumSemester,
    required String curriculumSemester,
    required ScheduledTermIdentifier? lastSemester,
    required double cumulativeWeightedAverage,
    required double cumulativeWeightedAverageOfPassedCourses,
    required double lastCumulativeWeightedAverage,
    required int totalCreditsOfPassedCourses,
    required int curriculumMandatoryCredits,
    required int curriculumElectiveCredits,
    required int mandatoryCreditsOfPassedCourses,
    required int electiveCreditsOfPassedCourses,

    // General
    required ScheduledTermIdentifier currentSemester,
  }) = _AcademicReport;
}
