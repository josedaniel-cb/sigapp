class WeeklyScheduleEvent {
  final String id;
  final String courseName;

  /// 1 = Monday, 2 = Tuesday, ..., 7 = Sunday
  final int weekday;

  /// 0-23 representing the hour of the day
  final int startHour;

  /// 0-59 representing the minute of the hour
  final int startMinute;

  /// 0-23 representing the hour of the day
  final int endHour;

  /// 0-59 representing the minute of the hour
  final int endMinute;

  // final int color;
  final String location;

  WeeklyScheduleEvent({
    required this.id,
    required this.courseName,
    required this.weekday,
    required this.startHour,
    required this.startMinute,
    required this.endHour,
    required this.endMinute,
    // required this.color,
    required this.location,
  });
}
