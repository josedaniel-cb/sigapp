import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:sigapp/student/entities/student_semester_schedule.dart';
import 'package:sigapp/student/entities/weekly_schedule_event.dart';
import 'package:sigapp/student/models/get_academic_report.dart';
import 'package:sigapp/student/models/get_class_schedule.dart';
import 'package:sigapp/student/student_repository.dart';

@lazySingleton
class StudentService {
  final StudentRepository _studentRepository;

  GetAcademicReportModel? _academicReportModel;

  StudentService(this._studentRepository);

  Future<GetAcademicReportModel> getAcademicReport() async {
    if (_academicReportModel != null) {
      return _academicReportModel!;
    }

    _academicReportModel = await _studentRepository.getAcademicReport();

    return _academicReportModel!;
  }

  Future<List<WeeklyScheduleEvent>> getClassSchedule(String semester) async {
    final rawResult = await _studentRepository.getClassSchedule(semester);
    final result = _processClassSchedule(rawResult);
    return result;
  }

  Future<StudentSemesterSchedule> getDefaultClassSchedule() async {
    // Helper methods (assuming these need to be implemented or are provided)
    // String getLastPossibleSemester() {
    //   final DateTime now = DateTime.now();
    //   final int year = now.year;
    //   return '${year}2';
    // }

    // String getPreviousSemester(String semester) {
    //   // Implementation to calculate the previous semester based on the given semester
    //   // This is a simplified example and may need to be adjusted based on the actual semester naming convention
    //   int year = int.parse(semester.substring(0, 4));
    //   String period = semester.substring(4);
    //   if (period == '2') {
    //     return '${year}1';
    //   } else {
    //     year -= 1;
    //     return '${year}2';
    //   }
    // }

    final academicReport = await getAcademicReport();
    final lastSemester = academicReport.UltSemestre;
    final firstSemester = academicReport.SemestreIngreso;

    String? semester;
    List<WeeklyScheduleEvent>? schedule;

    if (lastSemester != null) {
      semester = lastSemester;
      schedule = await getClassSchedule(semester);
    } else {
      semester = firstSemester;
      schedule = await getClassSchedule(semester);
    }

    // if (schedule == null || schedule.isEmpty) {
    //   // Assume getCurrentSemester() and getPreviousSemester(semester) are available
    //   var currentSemester = getLastPossibleSemester();
    //   var attempts = 0;
    //   const maxAttempts = 10;
    //   while (schedule == null || schedule.isEmpty) {
    //     if (attempts >= maxAttempts || currentSemester == firstSemester) {
    //       semester = firstSemester;
    //       schedule = await getClassSchedule(semester);
    //       break;
    //     }
    //     currentSemester = getPreviousSemester(currentSemester);

    //     // Perform attempt
    //     semester = currentSemester;
    //     schedule = await getClassSchedule(semester);

    //     attempts++;
    //   }
    // }

    return StudentSemesterSchedule(
      // semester: semester!,
      semester: semester,
      weeklyEvents: schedule,
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
}
