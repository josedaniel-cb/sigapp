import 'package:injectable/injectable.dart';
import 'package:sigapp/courses/application/services/student_session_service.dart';
import 'package:sigapp/courses/application/usecases/get_enrolled_courses_usecase.dart';
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
  final StudentSessionService _studentSessionService;
  final GetEnrolledCoursesUsecase _getEnrolledCoursesUsecase;

  AcademicInfoServiceImpl(this._getAcademicReportUsecase,
      this._getEnrolledCoursesUsecase, this._studentSessionService);

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
    final firstSemester = academicReport.enrollmentSemester;
    ScheduledTermIdentifier? lastSemester;

    //  First, try with current semester
    final studentSessionInfo = await _studentSessionService.getInfo();
    final currentSemesterEnrolledCourses = await _getEnrolledCoursesUsecase
        .execute(studentSessionInfo.currentSemester.id);
    if (currentSemesterEnrolledCourses.isNotEmpty) {
      lastSemester = studentSessionInfo.currentSemester;
      return SemesterContext(
        isLast: academicReport.lastSemester != null,
        defaultSemester: lastSemester,
        availableSemesters: _buildSemesterRange(firstSemester, lastSemester),
      );
    }

    // If current semester is empty, try with last semester
    lastSemester = academicReport.lastSemester;
    final isLastSemesterIdKnown = lastSemester != null;
    ScheduledTermIdentifier defaultSemester;
    if (isLastSemesterIdKnown) {
      defaultSemester = lastSemester;
    } else {
      // If last semester is not known, use the current semester
      defaultSemester = firstSemester;
      lastSemester = studentSessionInfo.currentSemester;
    }

    return SemesterContext(
      isLast: isLastSemesterIdKnown,
      defaultSemester: defaultSemester,
      availableSemesters: _buildSemesterRange(firstSemester, lastSemester),
    );
  }

  List<ScheduledTermIdentifier> _buildSemesterRange(
      ScheduledTermIdentifier firstSemester,
      ScheduledTermIdentifier lastSemester) {
    List<ScheduledTermIdentifier> semesters = [];
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
