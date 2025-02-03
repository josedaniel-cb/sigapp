import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sigapp/student/domain/entities/student_semester_schedule.dart';

part 'semester_context.freezed.dart';

@freezed
class SemesterContext with _$SemesterContext {
  factory SemesterContext({
    required bool isLast,
    required List<SemesterScheduleSemesterMetadata> availableSemesters,
    required SemesterScheduleSemesterMetadata defaultSemester,
  }) = _SemesterContext;
}
