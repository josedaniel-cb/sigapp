import 'package:injectable/injectable.dart';
import 'package:sigapp/courses/domain/entities/scheduled_term_identifier.dart';
import 'package:sigapp/semester/domain/value-objects/semester_context.dart';
import 'package:sigapp/student/domain/entities/student_academic_report.dart';

@lazySingleton
class GetSemesterContextUsecase {
  GetSemesterContextUsecase();

  Future<SemesterContext> execute(AcademicReport academicReport) async {
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
      rangeLastSemesterId = academicReport.currentSemesterId;
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
