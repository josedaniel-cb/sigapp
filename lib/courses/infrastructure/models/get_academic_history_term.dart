import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'get_academic_history_term.freezed.dart';
part 'get_academic_history_term.g.dart';

@freezed
class GetAcademicHistoryTermModel with _$GetAcademicHistoryTermModel {
  const factory GetAcademicHistoryTermModel({
    required String termLabel,
    required String PPS,
    required String PPSAprob,
    required String PPA,
    required String PPAApr,
    required String CreOblLlev,
    required String CreElLlev,
    required String CreOblApr,
    required String CreEleApr,
    required String CreOblConv,
    required String CredEleConv,
    required String TotalCredOblLlev,
    required String TotalCredElLlev,
    required String TotalCredOblAprob,
    required String TotalCredElAprob,
    required String TotalCredOblConv,
    required List<GetAcademicHistoryCourseModel> courses,
  }) = _GetAcademicHistoryTermModel;

  factory GetAcademicHistoryTermModel.fromJson(Map<String, Object?> json) =>
      _$GetAcademicHistoryTermModelFromJson(json);
}

@freezed
class GetAcademicHistoryCourseModel with _$GetAcademicHistoryCourseModel {
  const factory GetAcademicHistoryCourseModel({
    required String courseCode,
    required String courseName,
    required String courseType,
    required String credits,
    required String grade,
  }) = _GetAcademicHistoryCourseModel;

  factory GetAcademicHistoryCourseModel.fromJson(Map<String, Object?> json) =>
      _$GetAcademicHistoryCourseModelFromJson(json);
}
