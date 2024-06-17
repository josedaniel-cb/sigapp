// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_academic_report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GetAcademicReportInformImpl _$$GetAcademicReportInformImplFromJson(
        Map<String, dynamic> json) =>
    _$GetAcademicReportInformImpl(
      facultad: json['facultad'] as String,
      nomAlumno: json['nomAlumno'] as String,
      promocion: json['promocion'] as String,
      semestreIngreso: json['semestreIngreso'] as String,
      semestrePlan: json['semestrePlan'] as String,
      ultSemestre: json['ultSemestre'] as String,
      pPA: (json['pPA'] as num).toDouble(),
      pPAAprob: (json['pPAAprob'] as num).toDouble(),
      uPPS: (json['uPPS'] as num).toDouble(),
      totalCredAprob: (json['totalCredAprob'] as num).toInt(),
      credObligPlan: (json['credObligPlan'] as num).toInt(),
      credElectPlan: (json['credElectPlan'] as num).toInt(),
      credObligAprob: (json['credObligAprob'] as num).toInt(),
      credElectAprob: (json['credElectAprob'] as num).toInt(),
    );

Map<String, dynamic> _$$GetAcademicReportInformImplToJson(
        _$GetAcademicReportInformImpl instance) =>
    <String, dynamic>{
      'facultad': instance.facultad,
      'nomAlumno': instance.nomAlumno,
      'promocion': instance.promocion,
      'semestreIngreso': instance.semestreIngreso,
      'semestrePlan': instance.semestrePlan,
      'ultSemestre': instance.ultSemestre,
      'pPA': instance.pPA,
      'pPAAprob': instance.pPAAprob,
      'uPPS': instance.uPPS,
      'totalCredAprob': instance.totalCredAprob,
      'credObligPlan': instance.credObligPlan,
      'credElectPlan': instance.credElectPlan,
      'credObligAprob': instance.credObligAprob,
      'credElectAprob': instance.credElectAprob,
    };
