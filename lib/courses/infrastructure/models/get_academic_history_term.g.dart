// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_academic_history_term.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GetAcademicHistoryTermModelImpl _$$GetAcademicHistoryTermModelImplFromJson(
        Map<String, dynamic> json) =>
    _$GetAcademicHistoryTermModelImpl(
      termLabel: json['termLabel'] as String,
      PPS: json['PPS'] as String,
      PPSAprob: json['PPSAprob'] as String,
      PPA: json['PPA'] as String,
      PPAApr: json['PPAApr'] as String,
      CreOblLlev: json['CreOblLlev'] as String,
      CreElLlev: json['CreElLlev'] as String,
      CreOblApr: json['CreOblApr'] as String,
      CreEleApr: json['CreEleApr'] as String,
      CreOblConv: json['CreOblConv'] as String,
      CredEleConv: json['CredEleConv'] as String,
      TotalCredOblLlev: json['TotalCredOblLlev'] as String,
      TotalCredElLlev: json['TotalCredElLlev'] as String,
      TotalCredOblAprob: json['TotalCredOblAprob'] as String,
      TotalCredElAprob: json['TotalCredElAprob'] as String,
      TotalCredOblConv: json['TotalCredOblConv'] as String,
      courses: (json['courses'] as List<dynamic>)
          .map((e) =>
              GetAcademicHistoryCourseModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$GetAcademicHistoryTermModelImplToJson(
        _$GetAcademicHistoryTermModelImpl instance) =>
    <String, dynamic>{
      'termLabel': instance.termLabel,
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
      'courses': instance.courses,
    };

_$GetAcademicHistoryCourseModelImpl
    _$$GetAcademicHistoryCourseModelImplFromJson(Map<String, dynamic> json) =>
        _$GetAcademicHistoryCourseModelImpl(
          courseCode: json['courseCode'] as String,
          courseName: json['courseName'] as String,
          courseType: json['courseType'] as String,
          credits: json['credits'] as String,
          grade: json['grade'] as String,
        );

Map<String, dynamic> _$$GetAcademicHistoryCourseModelImplToJson(
        _$GetAcademicHistoryCourseModelImpl instance) =>
    <String, dynamic>{
      'courseCode': instance.courseCode,
      'courseName': instance.courseName,
      'courseType': instance.courseType,
      'credits': instance.credits,
      'grade': instance.grade,
    };
