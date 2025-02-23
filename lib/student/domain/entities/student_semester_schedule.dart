import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sigapp/student/domain/entities/student_academic_report.dart';
import 'package:sigapp/student/domain/entities/weekly_schedule_event.dart';

part 'student_semester_schedule.freezed.dart';

@freezed
class SemesterSchedule with _$SemesterSchedule {
  factory SemesterSchedule({
    required AcademicReport studentAcademicReport,
    required List<SemesterScheduleSemesterMetadata> semesterList,
    required SemesterScheduleSemesterMetadata semester,
    required List<WeeklyScheduleEvent> weeklyEvents,
  }) = _SemesterSchedule;
}

// @freezed
// class SemesterScheduleSemesterMetadata with _$SemesterScheduleSemesterMetadata {
//   factory SemesterScheduleSemesterMetadata({
//     required String id, // YYYYX where X is from 0 to 2
//     required String name,
//     required int year,
//     required int period, // 0, 1 or 2
//   }) = _SemesterScheduleSemesterMetadata;
class SemesterScheduleSemesterMetadata {
  final String id; // YYYYX where X is from 0 to 2
  final String name;
  final int year;
  final int period; // 0, 1 or 2

  SemesterScheduleSemesterMetadata({
    required this.id,
    required this.name,
    required this.year,
    required this.period,
  });

  factory SemesterScheduleSemesterMetadata.buildFromId(String id) {
    final year = int.parse(id.substring(0, 4));
    final period = int.parse(id.substring(4));
    final name = '$year-$period';
    return SemesterScheduleSemesterMetadata(
      id: id,
      name: name,
      year: year,
      period: period,
    );
  }

  static String getIdFromName(String name) {
    final parts = name.split('-');
    return '${parts[0]}${parts[1]}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SemesterScheduleSemesterMetadata && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  bool operator <(SemesterScheduleSemesterMetadata other) =>
      id.compareTo(other.id) < 0;
  bool operator <=(SemesterScheduleSemesterMetadata other) =>
      id.compareTo(other.id) <= 0;
  bool operator >(SemesterScheduleSemesterMetadata other) =>
      id.compareTo(other.id) > 0;
  bool operator >=(SemesterScheduleSemesterMetadata other) =>
      id.compareTo(other.id) >= 0;
}
