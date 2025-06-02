// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_academic_history_term.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GetAcademicHistoryTermModel _$GetAcademicHistoryTermModelFromJson(
  Map<String, dynamic> json,
) => _GetAcademicHistoryTermModel(
  termLabel: json['termLabel'] as String,
  statistics:
      json['statistics'] == null
          ? null
          : GetAcademicHistoryTermStatisticsModel.fromJson(
            json['statistics'] as Map<String, dynamic>,
          ),
  courses:
      (json['courses'] as List<dynamic>)
          .map(
            (e) => GetAcademicHistoryCourseModel.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList(),
);

Map<String, dynamic> _$GetAcademicHistoryTermModelToJson(
  _GetAcademicHistoryTermModel instance,
) => <String, dynamic>{
  'termLabel': instance.termLabel,
  'statistics': instance.statistics,
  'courses': instance.courses,
};

_GetAcademicHistoryTermStatisticsModel
_$GetAcademicHistoryTermStatisticsModelFromJson(Map<String, dynamic> json) =>
    _GetAcademicHistoryTermStatisticsModel(
      PPS: (json['PPS'] as num).toDouble(),
      PPSAprob: (json['PPSAprob'] as num).toDouble(),
      PPA: (json['PPA'] as num).toDouble(),
      PPAApr: (json['PPAApr'] as num).toDouble(),
      CreOblLlev: (json['CreOblLlev'] as num).toDouble(),
      CreElLlev: (json['CreElLlev'] as num).toDouble(),
      CreOblApr: (json['CreOblApr'] as num).toDouble(),
      CreEleApr: (json['CreEleApr'] as num).toDouble(),
      CreOblConv: (json['CreOblConv'] as num).toDouble(),
      CredEleConv: (json['CredEleConv'] as num).toDouble(),
      TotalCredOblLlev: (json['TotalCredOblLlev'] as num).toDouble(),
      TotalCredElLlev: (json['TotalCredElLlev'] as num).toDouble(),
      TotalCredOblAprob: (json['TotalCredOblAprob'] as num).toDouble(),
      TotalCredElAprob: (json['TotalCredElAprob'] as num).toDouble(),
      TotalCredOblConv: (json['TotalCredOblConv'] as num).toDouble(),
    );

Map<String, dynamic> _$GetAcademicHistoryTermStatisticsModelToJson(
  _GetAcademicHistoryTermStatisticsModel instance,
) => <String, dynamic>{
  'PPS': instance.PPS,
  'PPSAprob': instance.PPSAprob,
  'PPA': instance.PPA,
  'PPAApr': instance.PPAApr,
  'CreOblLlev': instance.CreOblLlev,
  'CreElLlev': instance.CreElLlev,
  'CreOblApr': instance.CreOblApr,
  'CreEleApr': instance.CreEleApr,
  'CreOblConv': instance.CreOblConv,
  'CredEleConv': instance.CredEleConv,
  'TotalCredOblLlev': instance.TotalCredOblLlev,
  'TotalCredElLlev': instance.TotalCredElLlev,
  'TotalCredOblAprob': instance.TotalCredOblAprob,
  'TotalCredElAprob': instance.TotalCredElAprob,
  'TotalCredOblConv': instance.TotalCredOblConv,
};

_GetAcademicHistoryCourseModel _$GetAcademicHistoryCourseModelFromJson(
  Map<String, dynamic> json,
) => _GetAcademicHistoryCourseModel(
  courseCode: json['courseCode'] as String,
  courseName: json['courseName'] as String,
  courseType: json['courseType'] as String,
  credits: (json['credits'] as num).toInt(),
  grade: (json['grade'] as num).toDouble(),
);

Map<String, dynamic> _$GetAcademicHistoryCourseModelToJson(
  _GetAcademicHistoryCourseModel instance,
) => <String, dynamic>{
  'courseCode': instance.courseCode,
  'courseName': instance.courseName,
  'courseType': instance.courseType,
  'credits': instance.credits,
  'grade': instance.grade,
};
