// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_program_curriculum_course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GetProgramCurriculumCourseModelImpl
    _$$GetProgramCurriculumCourseModelImplFromJson(Map<String, dynamic> json) =>
        _$GetProgramCurriculumCourseModelImpl(
          ciclo: json['ciclo'] as String,
          codCurso: json['codCurso'] as String,
          creditos: (json['creditos'] as num).toInt(),
          descripCurso: json['descripCurso'] as String,
          flagTipoCurso: json['flagTipoCurso'] as String,
          horasPractica: (json['horasPractica'] as num).toInt(),
          horasTeoria: (json['horasTeoria'] as num).toInt(),
          nroCiclo: (json['nroCiclo'] as num).toInt(),
          resumenRequisitos: json['resumenRequisitos'] as String,
        );

Map<String, dynamic> _$$GetProgramCurriculumCourseModelImplToJson(
        _$GetProgramCurriculumCourseModelImpl instance) =>
    <String, dynamic>{
      'ciclo': instance.ciclo,
      'codCurso': instance.codCurso,
      'creditos': instance.creditos,
      'descripCurso': instance.descripCurso,
      'flagTipoCurso': instance.flagTipoCurso,
      'horasPractica': instance.horasPractica,
      'horasTeoria': instance.horasTeoria,
      'nroCiclo': instance.nroCiclo,
      'resumenRequisitos': instance.resumenRequisitos,
    };
