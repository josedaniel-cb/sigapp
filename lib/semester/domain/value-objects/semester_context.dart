import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sigapp/courses/domain/entities/scheduled_term_identifier.dart';

part 'semester_context.freezed.dart';

@freezed
class SemesterContext with _$SemesterContext {
  factory SemesterContext({
    required bool isLast,
    required List<ScheduledTermIdentifier> availableSemesters,
    required ScheduledTermIdentifier defaultSemester,
  }) = _SemesterContext;
}
