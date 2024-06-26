import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sigapp/student/models/get_class_schedule.dart';

part 'student_semester_schedule.freezed.dart';

@freezed
class StudentSemesterSchedule with _$StudentSemesterSchedule {
  factory StudentSemesterSchedule({
    required String semester, // YYYYX where X is 1 or 2
    required List<GetClassScheduleModel> rawSchedule,
  }) = _StudentSemesterSchedule;
}
