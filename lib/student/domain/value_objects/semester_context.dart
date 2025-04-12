import 'package:sigapp/courses/domain/entities/scheduled_term_identifier.dart';

enum SemesterContextType {
  currentlyEnrolled,
  completedLastEnrolled,
  unknownLastEnrolled,
}

class SemesterContext {
  final List<ScheduledTermIdentifier> availableSemesters;
  final ScheduledTermIdentifier defaultSemester;
  final SemesterContextType contextType;

  SemesterContext({
    required this.availableSemesters,
    required this.defaultSemester,
    required this.contextType,
  });

  bool get isDefaultSemesterLast =>
      contextType == SemesterContextType.currentlyEnrolled ||
      contextType == SemesterContextType.completedLastEnrolled;
}
