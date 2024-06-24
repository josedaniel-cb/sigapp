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
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header for days of the week
        Row(
          children: [
            _buildHourLabel('Hora'),
            _buildDayHeader('Mon'),
            _buildDayHeader('Tue'),
            _buildDayHeader('Wed'),
            _buildDayHeader('Thu'),
            _buildDayHeader('Fri'),
            _buildDayHeader('Sat'),
            _buildDayHeader('Sun'),
          ],
        ),
        // Combined hourly labels and events grid
        Expanded(
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Column(
                  children: List.generate(24, (hour) {
                    return Row(
                      children: [
                        _buildHourLabel('$hour:00'),
                        Expanded(
                          child: Row(
                            children: List.generate(7, (day) {
                              return Expanded(
                                child: Container(
                                  height: 60,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
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
                    .map((event) => _buildEvent(event, context))
                    .toList(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDayHeader(String day) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(8),
        child: Center(child: Text(day)),
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

  Widget _buildEvent(WeeklyScheduleEvent event, BuildContext context) {
    double top = event.start.hour * 60.0 + event.start.minute;
    double height = (event.end.difference(event.start).inMinutes).toDouble();
    int dayIndex = event.start.weekday - 1;

    double gridWidth = (MediaQuery.of(context).size.width - 50) / 7;

    return Positioned(
      top: top,
      left: 50 + dayIndex * gridWidth,
      width: gridWidth - 4,
      height: height,
      child: Container(
        margin: EdgeInsets.all(2),
        color: event.color,
        child: Center(
          child: Text(
            event.title,
            style: TextStyle(color: Colors.white, fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
