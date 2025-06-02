// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_scheduled_courses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GetScheduledCourseModel _$GetScheduledCourseModelFromJson(
  Map<String, dynamic> json,
) => _GetScheduledCourseModel(
  Capacidad: (json['Capacidad'] as num).toInt(),
  Ciclo: json['Ciclo'] as String,
  ClaveCurso: json['ClaveCurso'] as String,
  CodAula: json['CodAula'] as String,
  CodCurso: json['CodCurso'] as String,
  CodDocentePractica: json['CodDocentePractica'] as String,
  CodDocenteTeoria: json['CodDocenteTeoria'] as String,
  CodGrupo: json['CodGrupo'] as String,
  Cupos: (json['Cupos'] as num).toInt(),
  DescripcionAula: json['DescripcionAula'] as String,
  DescripcionCurso: json['DescripcionCurso'] as String,
  DocentePractica: json['DocentePractica'] as String,
  DocenteTeoria: json['DocenteTeoria'] as String,
  Inscritos: (json['Inscritos'] as num).toInt(),
  Item: (json['Item'] as num).toInt(),
  ItemProg: json['ItemProg'] as String,
  Seccion: json['Seccion'] as String,
);

Map<String, dynamic> _$GetScheduledCourseModelToJson(
  _GetScheduledCourseModel instance,
) => <String, dynamic>{
  'Capacidad': instance.Capacidad,
  'Ciclo': instance.Ciclo,
  'ClaveCurso': instance.ClaveCurso,
  'CodAula': instance.CodAula,
  'CodCurso': instance.CodCurso,
  'CodDocentePractica': instance.CodDocentePractica,
  'CodDocenteTeoria': instance.CodDocenteTeoria,
  'CodGrupo': instance.CodGrupo,
  'Cupos': instance.Cupos,
  'DescripcionAula': instance.DescripcionAula,
  'DescripcionCurso': instance.DescripcionCurso,
  'DocentePractica': instance.DocentePractica,
  'DocenteTeoria': instance.DocenteTeoria,
  'Inscritos': instance.Inscritos,
  'Item': instance.Item,
  'ItemProg': instance.ItemProg,
  'Seccion': instance.Seccion,
};
