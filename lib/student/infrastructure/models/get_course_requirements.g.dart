// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_course_requirements.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GetCourseRequirementsModel _$GetCourseRequirementsModelFromJson(
  Map<String, dynamic> json,
) => _GetCourseRequirementsModel(
  CodCursoPlan: json['CodCursoPlan'] as String,
  CodCursoRequisito: json['CodCursoRequisito'] as String,
  DescCursoRequisito: json['DescCursoRequisito'] as String,
  Nota: json['Nota'] as String,
  Semestre: json['Semestre'] as String,
);

Map<String, dynamic> _$GetCourseRequirementsModelToJson(
  _GetCourseRequirementsModel instance,
) => <String, dynamic>{
  'CodCursoPlan': instance.CodCursoPlan,
  'CodCursoRequisito': instance.CodCursoRequisito,
  'DescCursoRequisito': instance.DescCursoRequisito,
  'Nota': instance.Nota,
  'Semestre': instance.Semestre,
};
