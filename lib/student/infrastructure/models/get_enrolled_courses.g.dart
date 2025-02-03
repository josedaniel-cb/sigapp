// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_enrolled_courses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GetEnrolledCoursesModelImpl _$$GetEnrolledCoursesModelImplFromJson(
        Map<String, dynamic> json) =>
    _$GetEnrolledCoursesModelImpl(
      Acta: json['Acta'] as String?,
      Activo: json['Activo'] as String?,
      Aula: json['Aula'] as String,
      CeroEnActa: (json['CeroEnActa'] as num).toInt(),
      ClaveCurso: json['ClaveCurso'] as String,
      CodCurso: json['CodCurso'] as String,
      Creditos: (json['Creditos'] as num).toInt(),
      Cupos: (json['Cupos'] as num).toInt(),
      Curso: json['Curso'] as String,
      Desaprobados: (json['Desaprobados'] as num).toInt(),
      Docente: json['Docente'] as String,
      EstadoInscripcion: json['EstadoInscripcion'] as String?,
      Fecha: json['Fecha'] as String,
      FechaInscripcion: json['FechaInscripcion'] as String,
      Grupo: json['Grupo'] as String,
      Item: (json['Item'] as num).toInt(),
      ItemProg: json['ItemProg'] as String,
      Observacion: json['Observacion'] as String,
      Seccion: json['Seccion'] as String,
      Sylabus: json['Sylabus'],
      TipoCurso: json['TipoCurso'] as String,
    );

Map<String, dynamic> _$$GetEnrolledCoursesModelImplToJson(
        _$GetEnrolledCoursesModelImpl instance) =>
    <String, dynamic>{
      'Acta': instance.Acta,
      'Activo': instance.Activo,
      'Aula': instance.Aula,
      'CeroEnActa': instance.CeroEnActa,
      'ClaveCurso': instance.ClaveCurso,
      'CodCurso': instance.CodCurso,
      'Creditos': instance.Creditos,
      'Cupos': instance.Cupos,
      'Curso': instance.Curso,
      'Desaprobados': instance.Desaprobados,
      'Docente': instance.Docente,
      'EstadoInscripcion': instance.EstadoInscripcion,
      'Fecha': instance.Fecha,
      'FechaInscripcion': instance.FechaInscripcion,
      'Grupo': instance.Grupo,
      'Item': instance.Item,
      'ItemProg': instance.ItemProg,
      'Observacion': instance.Observacion,
      'Seccion': instance.Seccion,
      'Sylabus': instance.Sylabus,
      'TipoCurso': instance.TipoCurso,
    };
