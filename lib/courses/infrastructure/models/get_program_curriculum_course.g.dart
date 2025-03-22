// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_program_curriculum_course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GetProgramCurriculumCourseModelImpl
    _$$GetProgramCurriculumCourseModelImplFromJson(Map<String, dynamic> json) =>
        _$GetProgramCurriculumCourseModelImpl(
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

Map<String, dynamic> _$$GetProgramCurriculumCourseModelImplToJson(
        _$GetProgramCurriculumCourseModelImpl instance) =>
    <String, dynamic>{
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
