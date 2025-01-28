import 'package:injectable/injectable.dart';
import 'package:sigapp/student/application/usecases/get_academic_report_usecase.dart';
import 'package:sigapp/courses/application/usecases/get_class_schedule_usecase.dart';
import 'package:sigapp/student/domain/entities/student_semester_schedule.dart';

@lazySingleton
class GetDefaultClassScheduleUsecase {
  final GetAcademicReportUsecase _getAcademicReportUsecase;
  final GetClassScheduleUsecase _getClassScheduleUsecase;

  GetDefaultClassScheduleUsecase(
      this._getAcademicReportUsecase, this._getClassScheduleUsecase);

  Future<SemesterSchedule> execute() async {
    final academicReport = await _getAcademicReportUsecase.execute();
    final firstSemesterId = academicReport.enrollmentSemesterId;
    final lastSemesterId = academicReport.lastSemesterId;
    final semesterId = lastSemesterId ?? firstSemesterId;
    final semestersIdsList = _buildSemesterRange(
        firstSemesterId, lastSemesterId ?? academicReport.currentSemesterId);

    final weeklyEvents = await _getClassScheduleUsecase.execute(semesterId);

    return SemesterSchedule(
      studentAcademicReport: academicReport,
      semester: SemesterScheduleSemesterMetadata.buildFromId(semesterId),
      weeklyEvents: weeklyEvents,
      semesterList: semestersIdsList
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
