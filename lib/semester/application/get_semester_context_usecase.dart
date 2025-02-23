import 'package:injectable/injectable.dart';
import 'package:sigapp/semester/domain/value-objects/semester_context.dart';
import 'package:sigapp/student/domain/entities/student_academic_report.dart';
import 'package:sigapp/student/domain/entities/student_semester_schedule.dart';

@lazySingleton
class GetSemesterContextUsecase {
  GetSemesterContextUsecase();

  Future<SemesterContext> execute(AcademicReport academicReport) async {
    // Fetch
    final firstSemester = SemesterScheduleSemesterMetadata.buildFromId(
        academicReport.enrollmentSemesterId);
    var lastSemester = academicReport.lastSemesterId != null
        ? SemesterScheduleSemesterMetadata.buildFromId(
            academicReport.lastSemesterId!)
        : null;

    // Calculate default semester and available semesters
    final isLastSemesterIdKnown = lastSemester != null;
    SemesterScheduleSemesterMetadata defaultSemester;
    var rangeLastSemesterId = '';
    if (isLastSemesterIdKnown) {
      defaultSemester = lastSemester;
      rangeLastSemesterId = lastSemester.id;
    } else {
      defaultSemester = firstSemester;
      rangeLastSemesterId = academicReport.currentSemesterId;
    }

    return SemesterContext(
      isLast: isLastSemesterIdKnown,
      defaultSemester: defaultSemester,
      availableSemesters:
          _buildSemesterRange(firstSemester.id, rangeLastSemesterId),
    );
  }

  List<SemesterScheduleSemesterMetadata> _buildSemesterRange(
      String firstSemesterId, String lastSemesterId) {
    List<SemesterScheduleSemesterMetadata> semesters = [];
    final firstSemester =
        SemesterScheduleSemesterMetadata.buildFromId(firstSemesterId);
    final lastSemester =
        SemesterScheduleSemesterMetadata.buildFromId(lastSemesterId);
    for (var year = firstSemester.year; year <= lastSemester.year; year++) {
      var startPeriod = (year == firstSemester.year) ? firstSemester.period : 0;
      var endPeriod = (year == lastSemester.year) ? lastSemester.period : 2;
      for (var yearPeriod = startPeriod;
          yearPeriod <= endPeriod;
          yearPeriod++) {
        semesters.add(
            SemesterScheduleSemesterMetadata.buildFromId('$year$yearPeriod'));
      }
    }
    return semesters;
  }
}
