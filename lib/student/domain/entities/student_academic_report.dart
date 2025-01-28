import 'package:freezed_annotation/freezed_annotation.dart';

part 'student_academic_report.freezed.dart';

@freezed
class StudentAcademicReport with _$StudentAcademicReport {
  factory StudentAcademicReport({
    required String faculty,
    required String school,
    required String firstName,
    required String lastName,
    required String code,
    required String cohort,
    required String enrollmentSemesterId,
    required String curriculumSemesterId,
    required String? lastSemesterId,
    required double cumulativeWeightedAverage,
    required double cumulativeWeightedAverageOfPassedCourses,
    required double lastCumulativeWeightedAverage,
    required int totalCreditsOfPassedCourses,
    required int curriculumMandatoryCredits,
    required int curriculumElectiveCredits,
    required int mandatoryCreditsOfPassedCourses,
    required int electiveCreditsOfPassedCourses,

    // General
    required String currentSemesterId,
  }) = _StudentAcademicReport;
}
