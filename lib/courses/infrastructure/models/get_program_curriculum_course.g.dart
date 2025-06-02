// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_program_curriculum_course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GetProgramCurriculumCourseModel _$GetProgramCurriculumCourseModelFromJson(
  Map<String, dynamic> json,
) => _GetProgramCurriculumCourseModel(
  Ciclo: json['Ciclo'] as String,
  CodCurso: json['CodCurso'] as String,
  Creditos: (json['Creditos'] as num).toInt(),
  DescripCurso: json['DescripCurso'] as String,
  FlagTipoCurso: json['FlagTipoCurso'] as String,
  HorasPractica: (json['HorasPractica'] as num).toInt(),
  HorasTeoria: (json['HorasTeoria'] as num).toInt(),
  NroCiclo: (json['NroCiclo'] as num).toInt(),
  ResumenRequisitos: json['ResumenRequisitos'] as String,
);

Map<String, dynamic> _$GetProgramCurriculumCourseModelToJson(
  _GetProgramCurriculumCourseModel instance,
) => <String, dynamic>{
  'Ciclo': instance.Ciclo,
  'CodCurso': instance.CodCurso,
  'Creditos': instance.Creditos,
  'DescripCurso': instance.DescripCurso,
  'FlagTipoCurso': instance.FlagTipoCurso,
  'HorasPractica': instance.HorasPractica,
  'HorasTeoria': instance.HorasTeoria,
  'NroCiclo': instance.NroCiclo,
  'ResumenRequisitos': instance.ResumenRequisitos,
};
