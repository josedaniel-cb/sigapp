import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sigapp/student/domain/entities/student_semester_schedule.dart';

part 'default_semester_id.freezed.dart';

@freezed
class DefaultSemester with _$DefaultSemester {
  factory DefaultSemester({
    required bool isLast,
    required List<SemesterScheduleSemesterMetadata> availableSemesters,
    required SemesterScheduleSemesterMetadata semester,
  }) = _DefaultSemester;
}
