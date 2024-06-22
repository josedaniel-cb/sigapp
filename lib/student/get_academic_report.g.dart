// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_academic_report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GetAcademicReportInformImpl _$$GetAcademicReportInformImplFromJson(
        Map<String, dynamic> json) =>
    _$GetAcademicReportInformImpl(
      Facultad: json['Facultad'] as String,
      NomAlumno: json['NomAlumno'] as String,
      Promocion: json['Promocion'] as String,
      SemestreIngreso: json['SemestreIngreso'] as String,
      SemestrePlan: json['SemestrePlan'] as String,
      UltSemestre: json['UltSemestre'] as String?,
      PPA: (json['PPA'] as num).toDouble(),
      PPAAprob: (json['PPAAprob'] as num).toDouble(),
      UPPS: (json['UPPS'] as num).toDouble(),
      TotalCredAprob: (json['TotalCredAprob'] as num).toInt(),
      CredObligPlan: (json['CredObligPlan'] as num).toInt(),
      CredElectPlan: (json['CredElectPlan'] as num).toInt(),
      CredObligAprob: (json['CredObligAprob'] as num).toInt(),
      CredElectAprob: (json['CredElectAprob'] as num).toInt(),
    );

Map<String, dynamic> _$$GetAcademicReportInformImplToJson(
        _$GetAcademicReportInformImpl instance) =>
    <String, dynamic>{
      'Facultad': instance.Facultad,
      'NomAlumno': instance.NomAlumno,
      'Promocion': instance.Promocion,
      'SemestreIngreso': instance.SemestreIngreso,
      'SemestrePlan': instance.SemestrePlan,
      'UltSemestre': instance.UltSemestre,
      'PPA': instance.PPA,
      'PPAAprob': instance.PPAAprob,
      'UPPS': instance.UPPS,
      'TotalCredAprob': instance.TotalCredAprob,
      'CredObligPlan': instance.CredObligPlan,
      'CredElectPlan': instance.CredElectPlan,
      'CredObligAprob': instance.CredObligAprob,
      'CredElectAprob': instance.CredElectAprob,
    };
