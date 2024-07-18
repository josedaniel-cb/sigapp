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

  static const String _eventsIdsPrefix = 'SIGAPP';

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
    Map<String, Color> courseColorMap = {};
    List<WeeklyScheduleEvent> weeklyScheduleEvents = [];
    List<Color> colorPalette = [
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

    Color _assignColorToCourse(String courseName) {
      if (!courseColorMap.containsKey(courseName)) {
        courseColorMap[courseName] =
            colorPalette[courseColorMap.length % colorPalette.length];
      }
      return courseColorMap[courseName]!;
    }

    DateTime _calculateEventDateTime(DateTime baseTime, int targetWeekday) {
      DateTime currentDate = DateTime.now();
      int currentWeekday = currentDate.weekday;
      int daysDifference = (targetWeekday - currentWeekday) % 7;
      if (daysDifference < 0) daysDifference += 7;
      return DateTime(
        currentDate.year,
        currentDate.month,
        currentDate.day + daysDifference,
        baseTime.hour,
        baseTime.minute,
      );
    }

    DateTime _parseTimestamp(String timestamp) {
      final timestampPattern = RegExp(r'\/Date\((\d+)\)\/');
      final match = timestampPattern.firstMatch(timestamp);
      if (match != null) {
        final milliseconds = int.parse(match.group(1)!);
        return DateTime.fromMillisecondsSinceEpoch(milliseconds);
      }
      throw const FormatException("Invalid timestamp format");
    }

    for (var classSchedule in schedule) {
      final classStartTime = _parseTimestamp(classSchedule.HoraInicio);
      final classEndTime = _parseTimestamp(classSchedule.HoraFinal);
      // print(classSchedule);

      List<List<dynamic>> classDaysAndNames = [];

      if (classSchedule.Lunes.isNotEmpty) {
        classDaysAndNames.add([classSchedule.Lunes, DateTime.monday]);
      }
      if (classSchedule.Martes.isNotEmpty) {
        classDaysAndNames.add([classSchedule.Martes, DateTime.tuesday]);
      }
      if (classSchedule.Miercoles.isNotEmpty) {
        classDaysAndNames.add([classSchedule.Miercoles, DateTime.wednesday]);
      }
      if (classSchedule.Jueves.isNotEmpty) {
        classDaysAndNames.add([classSchedule.Jueves, DateTime.thursday]);
      }
      if (classSchedule.Viernes.isNotEmpty) {
        classDaysAndNames.add([classSchedule.Viernes, DateTime.friday]);
      }
      if (classSchedule.Sabado.isNotEmpty) {
        classDaysAndNames.add([classSchedule.Sabado, DateTime.saturday]);
      }

      for (var dayAndName in classDaysAndNames) {
        // print(dayAndName);
        final classInfo = dayAndName[0];
        final weekday = dayAndName[1];

        final parts = classInfo.split(' ? ');
        final className = parts[0];
        final classLocation = parts[1];

        final eventStart = _calculateEventDateTime(classStartTime, weekday);
        final eventEnd = _calculateEventDateTime(classEndTime, weekday);

        final id =
            '$_eventsIdsPrefix-[$className]-${eventStart.toString().substring(0, 16)}-${eventEnd.toString().substring(0, 16)}';
        weeklyScheduleEvents.add(WeeklyScheduleEvent(
          id: id,
          title: className,
          weekday: weekday,
          startHour: eventStart.hour,
          startMinute: eventStart.minute,
          endHour: eventEnd.hour,
          endMinute: eventEnd.minute,
          color: _assignColorToCourse(classInfo),
          location: classLocation,
        ));
      }
    }
    return weeklyScheduleEvents;
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

  bool calculateIfEventIsOwnedByThisApp(String eventId) {
    return eventId.startsWith(_eventsIdsPrefix);
  }
}
