import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sigapp/student/entities/weekly_schedule_event.dart';

part 'student_semester_schedule.freezed.dart';

@freezed
class SemesterSchedule with _$SemesterSchedule {
  factory SemesterSchedule({
    required List<SemesterScheduleSemesterMetadata> semesterList,
    required SemesterScheduleSemesterMetadata semester,
    required List<WeeklyScheduleEvent> weeklyEvents,
  }) = _SemesterSchedule;
}

@freezed
class SemesterScheduleSemesterMetadata with _$SemesterScheduleSemesterMetadata {
  factory SemesterScheduleSemesterMetadata({
    required String id, // YYYYX where X is from 0 to 2
    required String name,
    required String year,
    required String period, // 0, 1 or 2
  }) = _SemesterScheduleSemesterMetadata;

  factory SemesterScheduleSemesterMetadata.buildFromId(String id) {
    final year = id.substring(0, 4);
    final period = id.substring(4);
    final name = '$year-$period';
    return SemesterScheduleSemesterMetadata(
      id: id,
      name: name,
      year: year,
      period: period,
    );
  }
}
