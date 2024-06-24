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
            _buildDayHeader('Mon'),
            _buildDayHeader('Tue'),
            _buildDayHeader('Wed'),
            _buildDayHeader('Thu'),
            _buildDayHeader('Fri'),
            _buildDayHeader('Sat'),
            _buildDayHeader('Sun'),
          ],
        ),
        // Hourly grid
        Expanded(
          child: Row(
            children: [
              // Hourly labels
              Column(
                children: List.generate(24, (index) => _buildHourLabel(index)),
              ),
              // Events grid
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2,
                  ),
                  itemBuilder: (context, index) {
                    int dayIndex = index % 7;
                    int hourIndex = index ~/ 7;
                    return _buildEventCell(dayIndex, hourIndex);
                  },
                  itemCount: 24 * 7,
                ),
              ),
            ],
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

  Widget _buildHourLabel(int hour) {
    return Container(
      height: 60,
      padding: EdgeInsets.all(8),
      child: Center(child: Text('$hour:00')),
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
