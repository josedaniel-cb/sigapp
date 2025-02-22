import 'package:intl/intl.dart';

class TimeUtils {
  TimeUtils._();

  /// Converts a date in 'yyyy/MM/dd' format to a DateTime object.
  /// Example: '2021/11/18' -> DateTime(2021, 11, 18)
  static DateTime parseFormattedDate(String date) {
    final DateFormat formatter = DateFormat('yyyy/MM/dd');
    return formatter.parse(date);
  }

  /// Formats the duration of an event in 12-hour format with AM/PM.
  /// Example: 14:30 - 16:00 -> '2:30pm - 4pm'
  static String formatEventDuration(EventDuration duration) {
    final DateTime startTime =
        DateTime(0, 1, 1, duration.startHour, duration.startMinute);
    final DateTime endTime =
        DateTime(0, 1, 1, duration.endHour, duration.endMinute);

    final DateFormat timeFormatter = DateFormat('h:mm a');
    final String start = timeFormatter.format(startTime).toLowerCase();
    String end = timeFormatter.format(endTime).toLowerCase();

    // Remove ':00' from the end time if minutes are zero
    if (duration.endMinute == 0) {
      end = end.replaceFirst(':00', '');
    }

    return '$start - $end';
  }

  /// Converts a day of the week number (1 = Monday, 7 = Sunday) to its name in Spanish.
  static String weekdayToString(int day) {
    final List<String> daysInSpanish = [
      'lunes',
      'martes',
      'miércoles',
      'jueves',
      'viernes',
      'sábado',
      'domingo'
    ];

    if (day < 1 || day > 7) {
      throw ArgumentError('El número del día debe estar entre 1 y 7');
    }

    return daysInSpanish[day - 1];
  }

  // Duration eventDurationToNativeString(EventDuration duration) {
  //   return Duration(
  //     hours: duration.endHour - duration.startHour,
  //     minutes: duration.endMinute - duration.startMinute,
  //   );
  // }
}

class EventDuration {
  final int startHour;
  final int startMinute;
  final int endHour;
  final int endMinute;

  EventDuration({
    required this.startHour,
    required this.startMinute,
    required this.endHour,
    required this.endMinute,
  });
}
