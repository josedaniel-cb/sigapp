import 'package:injectable/injectable.dart';
import 'package:sigapp/semester/application/get_semester_context_usecase.dart';
import 'package:sigapp/semester/domain/value-objects/semester_context.dart';
import 'package:sigapp/student/application/usecases/get_academic_report_usecase.dart';
import 'package:sigapp/student/domain/entities/student_academic_report.dart';
import 'package:sigapp/student/domain/services/student_info_service.dart';

class SessionInfoData {
  final AcademicReport academicReport;
  final SemesterContext semesterContext;

  SessionInfoData({
    required this.academicReport,
    required this.semesterContext,
  });
}

@Singleton(as: SessionInfoService)
class SessionInfoServiceImpl extends SessionInfoService {
  SessionInfoData? _data;

  final GetAcademicReportUsecase _getAcademicReportUsecase;
  final GetSemesterContextUsecase _getSemesterContextUsecase;

  SessionInfoServiceImpl(
      this._getAcademicReportUsecase, this._getSemesterContextUsecase);

  @override
  Future<SessionInfoData> getSessionInfo() async {
    if (_data != null) {
      return _data!;
    }

    final academicReport = await _getAcademicReportUsecase.execute();
    final semestersContext =
        await _getSemesterContextUsecase.execute(academicReport);

    _data = SessionInfoData(
      academicReport: academicReport,
      semesterContext: semestersContext,
    );

    return _data!;
  }

  @override
  void clearSessionInfo() {
    _data = null;
  }
}
