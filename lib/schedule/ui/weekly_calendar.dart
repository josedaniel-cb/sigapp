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

class WeeklySchedule extends StatelessWidget {
  final List<WeeklyScheduleEvent> events;

  const WeeklySchedule({super.key, required this.events});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header for days of the week
        Row(
          children: [
            _buildHourLabel(''),
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
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 8,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
            ),
            itemBuilder: (context, index) {
              int dayIndex = (index % 8) - 1;
              int hourIndex = index ~/ 8;
              if (dayIndex == -1) {
                return _buildHourLabel('$hourIndex:00');
              } else {
                return _buildEventCell(dayIndex, hourIndex);
              }
            },
            itemCount: 24 * 8,
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
      height: 60,
      padding: EdgeInsets.all(8),
      child: Center(child: Text(hour)),
    );
  }

  Widget _buildEventCell(int dayIndex, int hourIndex) {
    // Find events for this cell
    List<WeeklyScheduleEvent> cellEvents = events.where((event) {
      return event.start.weekday == dayIndex + 1 &&
          event.start.hour <= hourIndex &&
          event.end.hour > hourIndex;
    }).toList();

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
      ),
      child: Stack(
        children: cellEvents.map((event) => _buildEvent(event)).toList(),
      ),
    );
  }

  Widget _buildEvent(WeeklyScheduleEvent event) {
    return Positioned.fill(
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
