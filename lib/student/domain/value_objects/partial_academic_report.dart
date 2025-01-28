import 'package:freezed_annotation/freezed_annotation.dart';

part 'partial_academic_report.freezed.dart';

@freezed
class PartialAcademicReport with _$PartialAcademicReport {
  factory PartialAcademicReport({
    required String faculty,
    required String studentName,
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
  }) = _PartialAcademicReport;
}
