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
    required String facultad,
    required String nomAlumno,
    required String promocion,
    required String semestreIngreso,
    required String semestrePlan,
    required String ultSemestre,
    required double pPA,
    required double pPAAprob,
    required double uPPS,
    required int totalCredAprob,
    required int credObligPlan,
    required int credElectPlan,
    required int credObligAprob,
    required int credElectAprob,
  }) = _GetAcademicReportInform;

  factory GetAcademicReportInform.fromJson(Map<String, Object?> json) =>
      _$GetAcademicReportInformFromJson(json);
}
