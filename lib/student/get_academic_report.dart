import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'get_academic_report.freezed.dart';
part 'get_academic_report.g.dart';

/// Model for
/// ```json
/// {
///     "results": {
///         "Facultad": "INGENIERIA INDUSTRIAL",
///         "NomAlumno": "0512017039 - CALLE BRICEÑO, JOSE DANIEL",
///         "Promocion": "2017",
///         "SemestreIngreso": "20171 ",
///         "SemestrePlan": "20181 ",
///         "UltSemestre": "20212 ",
///         "PPA": 14.47,
///         "PPAAprob": 14.47,
///         "UPPS": 15.48,
///         "TotalCredAprob": 243,
///         "CredObligPlan": 220,
///         "CredElectPlan": 15,
///         "CredObligAprob": 220,
///         "CredElectAprob": 16
///     }
/// }
/// ```
@freezed
class GetAcademicReportInform with _$GetAcademicReportInform {
  const factory GetAcademicReportInform({
    required String Facultad,
    required String NomAlumno,
    required String Promocion,
    required String SemestreIngreso,
    required String SemestrePlan,
    required String UltSemestre,
    required double PPA,
    required double PPAAprob,
    required double UPPS,
    required int TotalCredAprob,
    required int CredObligPlan,
    required int CredElectPlan,
    required int CredObligAprob,
    required int CredElectAprob,
  }) = _GetAcademicReportInform;

  factory GetAcademicReportInform.fromJson(Map<String, Object?> json) =>
      _$GetAcademicReportInformFromJson(json);
}
