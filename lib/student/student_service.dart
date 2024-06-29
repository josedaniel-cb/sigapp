import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:sigapp/student/entities/student_academic_report.dart';
import 'package:sigapp/student/entities/student_semester_schedule.dart';
import 'package:sigapp/student/entities/weekly_schedule_event.dart';
import 'package:sigapp/student/models/get_class_schedule.dart';
import 'package:sigapp/student/student_repository.dart';

@lazySingleton
class StudentService {
  final StudentRepository _studentRepository;

  StudentAcademicReport? _studentAcademicReport;

  StudentService(this._studentRepository);

  Future<StudentAcademicReport> getAcademicReport() async {
    if (_studentAcademicReport != null) {
      return _studentAcademicReport!;
    }

    final academicReportModel =
        await _studentRepository.getAcademicReport().then(
              (value) => value.copyWith(
                UltSemestre: value.UltSemestre?.trim(),
                SemestrePlan: value.SemestrePlan.trim(),
                SemestreIngreso: value.SemestreIngreso.trim(),
              ),
            );
    final sessionStudentInfoModel =
        await _studentRepository.getSessionStudentInfo();

    final studentInfoParts = academicReportModel.NomAlumno.split(' - ');
    studentInfoParts.replaceRange(1, 2, studentInfoParts[1].split(', '));
    _studentAcademicReport = StudentAcademicReport(
      faculty: academicReportModel.Facultad,
      school: sessionStudentInfoModel.schoolName,
      firstName: studentInfoParts[2],
      lastName: studentInfoParts[1],
      code: studentInfoParts[0],
      cohort: academicReportModel.Promocion,
      enrollmentSemesterId: academicReportModel.SemestreIngreso,
      curriculumSemesterId: academicReportModel.SemestrePlan,
      lastSemesterId: academicReportModel.UltSemestre,
      cumulativeWeightedAverage: academicReportModel.PPA,
      cumulativeWeightedAverageOfPassedCourses: academicReportModel.PPAAprob,
      lastCumulativeWeightedAverage: academicReportModel.UPPS,
      curriculumMandatoryCredits: academicReportModel.CredObligPlan,
      curriculumElectiveCredits: academicReportModel.CredElectPlan,
      totalCreditsOfPassedCourses: academicReportModel.TotalCredAprob,
      mandatoryCreditsOfPassedCourses: academicReportModel.CredObligAprob,
      electiveCreditsOfPassedCourses: academicReportModel.CredElectAprob,
      currentSemesterId: sessionStudentInfoModel.currentSemesterId,
    );

    return _studentAcademicReport!;
  }

  Future<List<WeeklyScheduleEvent>> getClassSchedule(String semesterId) async {
    final rawResult = await _studentRepository.getClassSchedule(semesterId);
    final result = _processClassSchedule(rawResult);
    return result;
  }

  Future<SemesterSchedule> getDefaultClassSchedule() async {
    final academicReport = await getAcademicReport();
    final firstSemesterId = academicReport.enrollmentSemesterId;
    final lastSemesterId = academicReport.lastSemesterId;
    final semesterId = lastSemesterId ?? firstSemesterId;
    final semestersIdsList = _buildSemesterRange(
        firstSemesterId, lastSemesterId ?? academicReport.currentSemesterId);

    final weeklyEvents = await getClassSchedule(semesterId);

    return SemesterSchedule(
      studentAcademicReport: academicReport,
      semester: SemesterScheduleSemesterMetadata.buildFromId(semesterId),
      weeklyEvents: weeklyEvents,
      semesterList: semestersIdsList
          .map((id) => SemesterScheduleSemesterMetadata.buildFromId(id))
          .toList(),
    );
  }

  List<WeeklyScheduleEvent> _processClassSchedule(
      List<GetClassScheduleModel> schedule) {
    Map<String, Color> courseColors = {};
    List<WeeklyScheduleEvent> events = [];
    List<Color> availableColors = [
      Colors.purple,
      Colors.green,
      Colors.orange,
      Colors.blue,
      Colors.yellow,
      Colors.red,
      Colors.cyan,
      Colors.teal,
      Colors.indigo,
      Colors.pink,
    ];

    Color getCourseColor(String course) {
      if (!courseColors.containsKey(course)) {
        courseColors[course] =
            availableColors[courseColors.length % availableColors.length];
      }
      return courseColors[course]!;
    }

    DateTime getDateTimeForDay(DateTime time, int weekday) {
      DateTime now = DateTime.now();
      int currentWeekday = now.weekday;
      int daysToAdd = (weekday - currentWeekday) % 7;
      if (daysToAdd < 0) daysToAdd += 7;
      return DateTime(
        now.year,
        now.month,
        now.day + daysToAdd,
        time.hour,
        time.minute,
      );
    }

    DateTime convertToDateTime(String timestamp) {
      final regex = RegExp(r'\/Date\((\d+)\)\/');
      final match = regex.firstMatch(timestamp);
      if (match != null) {
        final milliseconds = int.parse(match.group(1)!);
        return DateTime.fromMillisecondsSinceEpoch(milliseconds);
      }
      throw const FormatException("Invalid timestamp format");
    }

    for (var item in schedule) {
      DateTime startTime = convertToDateTime(item.HoraInicio);
      DateTime endTime = convertToDateTime(item.HoraFinal);

      if (item.Lunes.isNotEmpty) {
        final parts = item.Lunes.split(' ? ');
        events.add(WeeklyScheduleEvent(
          title: parts[0],
          start: getDateTimeForDay(startTime, DateTime.monday),
          end: getDateTimeForDay(endTime, DateTime.monday),
          color: getCourseColor(item.Lunes),
          place: parts[1],
        ));
      }
      if (item.Martes.isNotEmpty) {
        final parts = item.Martes.split(' ? ');
        events.add(WeeklyScheduleEvent(
          title: parts[0],
          start: getDateTimeForDay(startTime, DateTime.tuesday),
          end: getDateTimeForDay(endTime, DateTime.tuesday),
          color: getCourseColor(item.Martes),
          place: parts[1],
        ));
      }
      if (item.Miercoles.isNotEmpty) {
        final parts = item.Miercoles.split(' ? ');
        events.add(WeeklyScheduleEvent(
          title: parts[0],
          start: getDateTimeForDay(startTime, DateTime.wednesday),
          end: getDateTimeForDay(endTime, DateTime.wednesday),
          color: getCourseColor(item.Miercoles),
          place: parts[1],
        ));
      }
      if (item.Jueves.isNotEmpty) {
        final parts = item.Jueves.split(' ? ');
        events.add(WeeklyScheduleEvent(
          title: parts[0],
          start: getDateTimeForDay(startTime, DateTime.thursday),
          end: getDateTimeForDay(endTime, DateTime.thursday),
          color: getCourseColor(item.Jueves),
          place: parts[1],
        ));
      }
      if (item.Viernes.isNotEmpty) {
        final parts = item.Viernes.split(' ? ');
        events.add(WeeklyScheduleEvent(
          title: parts[0],
          start: getDateTimeForDay(startTime, DateTime.friday),
          end: getDateTimeForDay(endTime, DateTime.friday),
          color: getCourseColor(item.Viernes),
          place: parts[1],
        ));
      }
      if (item.Sabado.isNotEmpty) {
        final parts = item.Sabado.split(' ? ');
        events.add(WeeklyScheduleEvent(
          title: parts[0],
          start: getDateTimeForDay(startTime, DateTime.saturday),
          end: getDateTimeForDay(endTime, DateTime.saturday),
          color: getCourseColor(item.Sabado),
          place: parts[1],
        ));
      }
    }
    return events;
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
