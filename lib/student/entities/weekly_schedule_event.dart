import 'dart:ui';

class WeeklyScheduleEvent {
  final String title;
  final DateTime start;
  final DateTime end;
  final Color color;
  final String place;

  WeeklyScheduleEvent({
    required this.title,
    required this.start,
    required this.end,
    required this.color,
    required this.place,
  });
}
