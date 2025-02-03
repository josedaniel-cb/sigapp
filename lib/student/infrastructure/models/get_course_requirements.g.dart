// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_course_requirements.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GetCourseRequirementsModelImpl _$$GetCourseRequirementsModelImplFromJson(
        Map<String, dynamic> json) =>
    _$GetCourseRequirementsModelImpl(
      CodCursoPlan: json['CodCursoPlan'] as String,
      CodCursoRequisito: json['CodCursoRequisito'] as String,
      DescCursoRequisito: json['DescCursoRequisito'] as String,
      Nota: json['Nota'] as String,
      Semestre: json['Semestre'] as String,
    );

Map<String, dynamic> _$$GetCourseRequirementsModelImplToJson(
        _$GetCourseRequirementsModelImpl instance) =>
    <String, dynamic>{
      'CodCursoPlan': instance.CodCursoPlan,
      'CodCursoRequisito': instance.CodCursoRequisito,
      'DescCursoRequisito': instance.DescCursoRequisito,
      'Nota': instance.Nota,
      'Semestre': instance.Semestre,
    };
