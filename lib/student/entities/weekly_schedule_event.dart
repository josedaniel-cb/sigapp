import 'dart:ui';

class WeeklyScheduleEvent {
  final String title;
  final DateTime start;
  final DateTime end;
  final Color color;

  WeeklyScheduleEvent({
    required this.title,
    required this.start,
    required this.end,
    required this.color,
  });
}
