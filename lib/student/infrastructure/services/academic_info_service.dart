import 'package:injectable/injectable.dart';
import 'package:sigapp/courses/domain/entities/scheduled_term_identifier.dart';
import 'package:sigapp/semester/domain/value-objects/semester_context.dart';
import 'package:sigapp/student/application/usecases/get_academic_report_usecase.dart';
import 'package:sigapp/student/domain/entities/student_academic_report.dart';
import 'package:sigapp/student/domain/services/academic_info_service.dart';

class AcademicInfoData {
  final AcademicReport academicReport;
  final SemesterContext semesterContext;

  AcademicInfoData({
    required this.academicReport,
    required this.semesterContext,
  });
}

@Singleton(as: AcademicInfoService)
class AcademicInfoServiceImpl extends AcademicInfoService {
  AcademicInfoData? _data;

  final GetAcademicReportUsecase _getAcademicReportUsecase;

  AcademicInfoServiceImpl(this._getAcademicReportUsecase);

  @override
  Future<AcademicInfoData> getSessionInfo() async {
    if (_data != null) {
      return _data!;
    }

    final academicReport = await _getAcademicReportUsecase.execute();
    final semesterContext = await _calculateSemesterContext(academicReport);

    _data = AcademicInfoData(
      academicReport: academicReport,
      semesterContext: semesterContext,
    );

    return _data!;
  }

  @override
  void clearSessionInfo() {
    _data = null;
  }

  Future<SemesterContext> _calculateSemesterContext(
      AcademicReport academicReport) async {
    // Fetch
    final firstSemester = ScheduledTermIdentifier.buildFromId(
        academicReport.enrollmentSemesterId);
    var lastSemester = academicReport.lastSemesterId != null
        ? ScheduledTermIdentifier.buildFromId(academicReport.lastSemesterId!)
        : null;

    // Calculate default semester and available semesters
    final isLastSemesterIdKnown = lastSemester != null;
    ScheduledTermIdentifier defaultSemester;
    var rangeLastSemesterId = '';
    if (isLastSemesterIdKnown) {
      defaultSemester = lastSemester;
      rangeLastSemesterId = lastSemester.id;
    } else {
      defaultSemester = firstSemester;
      rangeLastSemesterId = academicReport.currentSemester.id;
    }

    return SemesterContext(
      isLast: isLastSemesterIdKnown,
      defaultSemester: defaultSemester,
      availableSemesters:
          _buildSemesterRange(firstSemester.id, rangeLastSemesterId),
    );
  }

  List<ScheduledTermIdentifier> _buildSemesterRange(
      String firstSemesterId, String lastSemesterId) {
    List<ScheduledTermIdentifier> semesters = [];
    final firstSemester = ScheduledTermIdentifier.buildFromId(firstSemesterId);
    final lastSemester = ScheduledTermIdentifier.buildFromId(lastSemesterId);
    for (var year = firstSemester.year; year <= lastSemester.year; year++) {
      var startPeriod = (year == firstSemester.year) ? firstSemester.period : 0;
      var endPeriod = (year == lastSemester.year) ? lastSemester.period : 2;
      for (var yearPeriod = startPeriod;
          yearPeriod <= endPeriod;
          yearPeriod++) {
        semesters.add(ScheduledTermIdentifier.buildFromId('$year$yearPeriod'));
      }
    }
    return semesters;
  }
}
