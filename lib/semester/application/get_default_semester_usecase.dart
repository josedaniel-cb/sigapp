import 'package:injectable/injectable.dart';
import 'package:sigapp/semester/domain/value-objects/default_semester_id.dart';
import 'package:sigapp/student/application/usecases/get_academic_report_usecase.dart';
import 'package:sigapp/student/domain/entities/student_semester_schedule.dart';

@lazySingleton
class GetDefaultSemesterUsecase {
  final GetAcademicReportUsecase _getAcademicReportUsecase;

  GetDefaultSemesterUsecase(this._getAcademicReportUsecase);

  Future<DefaultSemester> execute() async {
    final academicReport = await _getAcademicReportUsecase.execute();
    final firstSemesterId = academicReport.enrollmentSemesterId;
    final lastSemesterId = academicReport.lastSemesterId;

    final isLastSemesterIdKnown = lastSemesterId != null;

    var defaultSemesterId = '';
    var rangeLastSemesterId = '';
    if (isLastSemesterIdKnown) {
      defaultSemesterId = lastSemesterId;
      rangeLastSemesterId = lastSemesterId;
    } else {
      defaultSemesterId = firstSemesterId;
      rangeLastSemesterId = academicReport.currentSemesterId;
    }

    return DefaultSemester(
      isLast: isLastSemesterIdKnown,
      semester: SemesterScheduleSemesterMetadata.buildFromId(defaultSemesterId),
      availableSemesters:
          _buildSemesterRange(firstSemesterId, rangeLastSemesterId)
              .map((id) => SemesterScheduleSemesterMetadata.buildFromId(id))
              .toList(),
    );
  }

  List<String> _buildSemesterRange(
      String firstSemesterId, String lastSemesterId) {
    List<String> semesters = [];
    int firstYear = int.parse(firstSemesterId.substring(0, 4));
    int lastYear = int.parse(lastSemesterId.substring(0, 4));
    int firstSemesterNumber = int.parse(firstSemesterId.substring(4)); // 0 to 2
    int lastSemesterNumber = int.parse(lastSemesterId.substring(4)); // 0 to 2
    for (int year = firstYear; year <= lastYear; year++) {
      int start = (year == firstYear) ? firstSemesterNumber : 0;
      int end = (year == lastYear) ? lastSemesterNumber : 2;
      for (int semester = start; semester <= end; semester++) {
        semesters.add('$year$semester');
      }
    }
    return semesters;
  }
}
