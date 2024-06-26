import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sigapp/student/entities/weekly_schedule_event.dart';

part 'student_semester_schedule.freezed.dart';

@freezed
class StudentSemesterSchedule with _$StudentSemesterSchedule {
  factory StudentSemesterSchedule({
    required String semester, // YYYYX where X is 1 or 2
    // required List<GetClassScheduleModel> rawSchedule,
    required List<WeeklyScheduleEvent> weeklyEvents,
  }) = _StudentSemesterSchedule;
}
