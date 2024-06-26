import 'package:flutter/material.dart';
import 'package:sigapp/student/entities/weekly_schedule_event.dart';

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
            Container(
              // color: Colors.red,
              width: 50,
              padding: const EdgeInsets.all(8),
              // child: const Center(
              //   child: Text('Hora'),
              // ),
            ),
            for (var day in daysWithEvents) _buildDayHeader(day),
          ],
        ),
        // Combined hourly labels and events grid
        Expanded(
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Column(
                  // children: List.generate(endHour - startHour, (hour) {
                  children: List.generate(endHour - startHour - 1, (hour) {
                    return Row(
                      children: [
                        // +1 because the alignment
                        // _buildHourLabel(_formatHour(startHour + hour])),
                        _buildHourLabel(_formatHour(startHour + hour)),
                        Expanded(
                          child: Row(
                            children: List.generate(daysWithEvents.length,
                                (dayIndex) {
                              return Expanded(
                                child: Container(
                                  height: 60,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      left: dayIndex == 0
                                          ? BorderSide(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                            )
                                          : BorderSide.none,
                                      right: dayIndex !=
                                              daysWithEvents.length - 1
                                          ? BorderSide(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                            )
                                          : BorderSide.none,
                                      bottom: BorderSide(
                                        color: Colors.grey.withOpacity(0.5),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                      ],
                    );
                  })
                    ..add(
                      // an aux row just to print right borders of 10 height
                      Row(
                        children: [
                          const SizedBox(
                            width: 50,
                            height: 10,
                          ),
                          for (var dayIndex in List.generate(
                              daysWithEvents.length, (index) => index))
                            Container(
                              width: (MediaQuery.of(context).size.width - 50) /
                                  daysWithEvents.length,
                              height: 10,
                              decoration: BoxDecoration(
                                border: Border(
                                  left: dayIndex == 0
                                      ? BorderSide(
                                          color: Colors.grey.withOpacity(0.5),
                                        )
                                      : BorderSide.none,
                                  right: dayIndex != daysWithEvents.length - 1
                                      ? BorderSide(
                                          color: Colors.grey.withOpacity(0.5),
                                        )
                                      : BorderSide.none,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
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
        dayLabel = 'Lun';
        break;
      case 2:
        dayLabel = 'Mar';
        break;
      case 3:
        dayLabel = 'Mie';
        break;
      case 4:
        dayLabel = 'Jue';
        break;
      case 5:
        dayLabel = 'Vie';
        break;
      case 6:
        dayLabel = 'Sab';
        break;
      case 7:
        dayLabel = 'Dom';
        break;
      default:
        dayLabel = '';
    }
    return _buildHeader(dayLabel);
  }

  Widget _buildHeader(String text) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Center(child: Text(text)),
      ),
    );
  }

  Widget _buildHourLabel(String hour) {
    return Container(
      width: 50,
      height: 60,
      // color: Colors.green,
      child: Stack(
        children: [
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: 10, // Width of the right side border
              height: 1, // Height to simulate the bottom border
              color: Colors.grey.withOpacity(0.5),
            ),
          ),
          Container(
            child: Text(hour),
            alignment: Alignment.topCenter,
          ),
        ],
      ),
    );
  }

  Widget _buildEvent(WeeklyScheduleEvent event, BuildContext context,
      List<int> daysWithEvents) {
    double top = (event.start.hour - startHour) * 60.0 + event.start.minute;
    double height = (event.end.difference(event.start).inMinutes).toDouble();
    int dayIndex = daysWithEvents.indexOf(event.start.weekday);

    double gridWidth =
        (MediaQuery.of(context).size.width - 50) / daysWithEvents.length;

    // Explanation: duration of the event in half-hour increments
    int maxLines = (event.end.difference(event.start).inMinutes / 30).ceil();

    return Positioned(
      top: top,
      left: 50 + dayIndex * gridWidth,
      width: gridWidth - 4,
      height: height,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 2, vertical: 1),
        decoration: BoxDecoration(
          color: event.color,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                event.title,
                style: TextStyle(color: Colors.white, fontSize: 12),
                maxLines: maxLines, // Modificado para ajustar según la duración
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
