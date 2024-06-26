import 'package:flutter/material.dart';

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

class WeeklySchedule extends StatefulWidget {
  final List<WeeklyScheduleEvent> events;

  const WeeklySchedule({super.key, required this.events});

  @override
  State<WeeklySchedule> createState() => _WeeklyScheduleState();
}

class _WeeklyScheduleState extends State<WeeklySchedule> {
  late int startHour;
  late int endHour;

  @override
  void initState() {
    super.initState();
    _calculateHourRange();
  }

  void _calculateHourRange() {
    startHour = widget.events
        .map((event) => event.start.hour)
        .reduce((a, b) => a < b ? a : b);
    endHour = widget.events
            .map((event) => event.end.hour)
            .reduce((a, b) => a > b ? a : b) +
        1;
  }

  @override
  Widget build(BuildContext context) {
    List<int> daysWithEvents = List.generate(7, (index) => index + 1)
        .where(
            (day) => widget.events.any((event) => event.start.weekday == day))
        .toList();

    return Column(
      children: [
        // Header for days of the week
        Row(
          children: [
            _buildHourLabel('Hora'),
            for (var day in daysWithEvents) _buildDayHeader(day),
          ],
        ),
        // Combined hourly labels and events grid
        Expanded(
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Column(
                  children: List.generate(endHour - startHour, (hour) {
                    return Row(
                      children: [
                        _buildHourLabel(_formatHour(startHour + hour)),
                        Expanded(
                          child: Row(
                            children: List.generate(daysWithEvents.length,
                                (dayIndex) {
                              return Expanded(
                                child: Container(
                                  height: 60,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey.withOpacity(0.5),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                      ],
                    );
                  }),
                ),
                ...widget.events
                    .where((event) =>
                        event.start.hour >= startHour &&
                        event.end.hour <= endHour)
                    .map((event) => _buildEvent(event, context, daysWithEvents))
                    .toList(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _formatHour(int hour) {
    String period = hour >= 12 ? 'pm' : 'am';
    int displayHour = hour > 12 ? hour - 12 : hour;
    displayHour = displayHour == 0 ? 12 : displayHour;
    return '$displayHour$period';
  }

  Widget _buildDayHeader(int day) {
    String dayLabel;
    switch (day) {
      case 1:
        dayLabel = 'Mon';
        break;
      case 2:
        dayLabel = 'Tue';
        break;
      case 3:
        dayLabel = 'Wed';
        break;
      case 4:
        dayLabel = 'Thu';
        break;
      case 5:
        dayLabel = 'Fri';
        break;
      case 6:
        dayLabel = 'Sat';
        break;
      case 7:
        dayLabel = 'Sun';
        break;
      default:
        dayLabel = '';
    }
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(8),
        child: Center(child: Text(dayLabel)),
      ),
    );
  }

  Widget _buildHourLabel(String hour) {
    return Container(
      width: 50,
      height: 60,
      padding: EdgeInsets.all(8),
      child: Center(child: Text(hour)),
    );
  }

  Widget _buildEvent(WeeklyScheduleEvent event, BuildContext context,
      List<int> daysWithEvents) {
    double top = (event.start.hour - startHour) * 60.0 + event.start.minute;
    double height = (event.end.difference(event.start).inMinutes).toDouble();
    int dayIndex = daysWithEvents.indexOf(event.start.weekday);

    double gridWidth =
        (MediaQuery.of(context).size.width - 50) / daysWithEvents.length;

    return Positioned(
      top: top,
      left: 50 + dayIndex * gridWidth,
      width: gridWidth - 4,
      height: height,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 2, vertical: 1),
        decoration: BoxDecoration(
          color: event.color,
          borderRadius: BorderRadius.circular(4), // Menos redondeado
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                event.title,
                style: TextStyle(color: Colors.white, fontSize: 12),
                maxLines:
                    height > 30 ? 2 : 1, // Ajuste según el tamaño del evento
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
              if (height > 30)
                Text(
                  _formatEventDuration(event),
                  style: TextStyle(color: Colors.white, fontSize: 10),
                  textAlign: TextAlign.center,
                ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatEventDuration(WeeklyScheduleEvent event) {
    // Determine start and end hours, adjusting for 12-hour format without leading zeros
    String startHour =
        (event.start.hour > 12 ? event.start.hour - 12 : event.start.hour)
            .toString();
    String endHour =
        (event.end.hour > 12 ? event.end.hour - 12 : event.end.hour).toString();

    // Determine if start and end times are AM or PM
    String startPeriod = event.start.hour >= 12 ? 'pm' : 'am';
    String endPeriod = event.end.hour >= 12 ? 'pm' : 'am';

    // Format minutes to include leading zero if not on the hour, otherwise leave as empty string
    String startMinute = event.start.minute == 0
        ? ''
        : ':${event.start.minute.toString().padLeft(2, '0')}';
    String endMinute = event.end.minute == 0
        ? ''
        : ':${event.end.minute.toString().padLeft(2, '0')}';

    // Determine if the AM/PM indicator should be shown for the start time
    String startAmPm = startPeriod == endPeriod ? '' : startPeriod;
    String endAmPm = endPeriod;

    // Construct the formatted time string based on whether minutes are included
    if (startMinute.isEmpty && endMinute.isEmpty) {
      // If both times are on the hour, don't show minutes, and only show AM/PM once if they are the same
      return '$startHour$startAmPm - $endHour$endAmPm';
    } else {
      // If either time includes minutes, show minutes and AM/PM indicators as needed
      return '$startHour$startMinute$startAmPm - $endHour$endMinute$endAmPm';
    }
  }
}
