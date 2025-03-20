import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:sigapp/courses/domain/entities/course_type.dart';
import 'package:sigapp/courses/domain/entities/scheduled_term_identifier.dart';

part 'academic_history_term.freezed.dart';

@freezed
class AcademicHistoryTerm with _$AcademicHistoryTerm {
  const factory AcademicHistoryTerm({
    // required String termLabel,
    required ScheduledTermIdentifier term,
    // required String PPS,
    required int termWeightedAverage,
    // required String PPSAprob,
    required int termWeightedAveragePassed,
    // required String PPA,
    required int cumulativeWeightedAverage,
    // required String PPAApr,
    required int cumulativeWeightedAveragePassed,
    // required String CreOblLlev,
    required int mandatoryCreditsTaken,
    // required String CreElLlev,
    required int electiveCreditsTaken,
    // required String CreOblApr,
    required int mandatoryCreditsPassed,
    // required String CreEleApr,
    required int electiveCreditsPassed,
    // required String CreOblConv,
    required int mandatoryCreditsValidated,
    // required String CredEleConv,
    required int electiveCreditsValidated,
    // required String TotalCredOblLlev,
    required int totalMandatoryCreditsTaken,
    // required String TotalCredElLlev,
    required int totalElectiveCreditsTaken,
    // required String TotalCredOblAprob,
    required int totalMandatoryCreditsPassed,
    // required String TotalCredElAprob,
    required int totalElectiveCreditsPassed,
    // required String TotalCredOblConv,
    required int totalMandatoryCreditsValidated,
    required List<AcademicHistoryCourse> courses,
  }) = _AcademicHistoryTerm;
}

@freezed
class AcademicHistoryCourse with _$AcademicHistoryCourse {
  const factory AcademicHistoryCourse({
    required String courseCode,
    required String courseName,
    required CourseType courseType,
    required int credits,
    required int grade,
  }) = _AcademicHistoryCourse;
}
