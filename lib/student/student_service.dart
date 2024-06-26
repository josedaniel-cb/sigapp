import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
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
        events.add(WeeklyScheduleEvent(
          title: item.Lunes,
          start: getDateTimeForDay(startTime, DateTime.monday),
          end: getDateTimeForDay(endTime, DateTime.monday),
          color: getCourseColor(item.Lunes),
        ));
      }
      if (item.Martes.isNotEmpty) {
        events.add(WeeklyScheduleEvent(
          title: item.Martes,
          start: getDateTimeForDay(startTime, DateTime.tuesday),
          end: getDateTimeForDay(endTime, DateTime.tuesday),
          color: getCourseColor(item.Martes),
        ));
      }
      if (item.Miercoles.isNotEmpty) {
        events.add(WeeklyScheduleEvent(
          title: item.Miercoles,
          start: getDateTimeForDay(startTime, DateTime.wednesday),
          end: getDateTimeForDay(endTime, DateTime.wednesday),
          color: getCourseColor(item.Miercoles),
        ));
      }
      if (item.Jueves.isNotEmpty) {
        events.add(WeeklyScheduleEvent(
          title: item.Jueves,
          start: getDateTimeForDay(startTime, DateTime.thursday),
          end: getDateTimeForDay(endTime, DateTime.thursday),
          color: getCourseColor(item.Jueves),
        ));
      }
      if (item.Viernes.isNotEmpty) {
        events.add(WeeklyScheduleEvent(
          title: item.Viernes,
          start: getDateTimeForDay(startTime, DateTime.friday),
          end: getDateTimeForDay(endTime, DateTime.friday),
          color: getCourseColor(item.Viernes),
        ));
      }
      if (item.Sabado.isNotEmpty) {
        events.add(WeeklyScheduleEvent(
          title: item.Sabado,
          start: getDateTimeForDay(startTime, DateTime.saturday),
          end: getDateTimeForDay(endTime, DateTime.saturday),
          color: getCourseColor(item.Sabado),
        ));
      }
    }
    return events;
  }
}
