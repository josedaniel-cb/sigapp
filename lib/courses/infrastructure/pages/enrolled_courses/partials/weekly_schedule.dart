import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sigapp/core/infrastructure/ui/utils/colors_utils.dart';
import 'package:sigapp/courses/infrastructure/pages/enrolled_courses/partials/weekly_schedule/body.dart';
import 'package:sigapp/courses/infrastructure/pages/enrolled_courses/partials/weekly_schedule/day_header.dart';
import 'package:sigapp/courses/infrastructure/pages/enrolled_courses/partials/weekly_schedule/text_info.dart';
import 'package:sigapp/student/domain/entities/weekly_schedule_event.dart';
import 'package:sigapp/student/domain/value_objects/enrolled_course.dart';

class WeeklyScheduleWidgetItem {
  final WeeklyScheduleEvent data;
  final Color color;

  WeeklyScheduleWidgetItem({required this.data, required this.color});
}

class WeeklyScheduleWidget extends StatefulWidget {
  late final List<WeeklyScheduleWidgetItem> events;
  final Widget? bottomRight;
  final Widget? bottomLeft;
  final Widget? topRight;
  final Widget? topLeft;
  final double hourWidth;
  final double rowHeight;
  final bool disableScroll;
  final double fontSize;

  WeeklyScheduleWidget({
    super.key,
    required List<EnrolledCourse> courses,
    this.fontSize = 12.0,
    this.disableScroll = false,
    this.bottomRight,
    this.bottomLeft,
    this.topRight,
    this.topLeft,
    this.hourWidth = 50.0,
    this.rowHeight = 75.0,
  }) {
    events = courses.indexed
        .map(
          (indexed) => indexed.$2.scheduleEvents.map(
            (event) => WeeklyScheduleWidgetItem(
              data: event,
              color: ColorsUtils.getColorByIndex(indexed.$1),
            ),
          ),
        )
        .expand((e) => e)
        .toList();
  }

  @override
  State<WeeklyScheduleWidget> createState() => _WeeklyScheduleWidgetState();
}

class _WeeklyScheduleWidgetState extends State<WeeklyScheduleWidget> {
  var startHour = 0;
  var endHour = 0;

  void _calculateHourRange() {
    if (widget.events.isEmpty) {
      startHour = 8;
      endHour = 18;
    } else {
      startHour = widget.events
          .map((event) => event.data.startHour)
          .reduce((a, b) => a < b ? a : b);
      endHour = widget.events
              .map((event) => event.data.endHour)
              .reduce((a, b) => a > b ? a : b) +
          1;
    }
    if (kDebugMode) {
      print('startHour: $startHour, endHour: $endHour');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.events.isEmpty) {
      return const Center(
        child: Text('No events to display'),
      );
    }

    _calculateHourRange();

    List<int> daysWithEvents = List.generate(7, (index) => index + 1)
        .where((day) => widget.events.any((event) => event.data.weekday == day))
        .toList();

    return DefaultTextStyle(
      style: GoogleFonts.lato(
        color: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.color
            ?.withValues(alpha: 0.5),
      ),
      child: LayoutBuilder(builder: (context, constraints) {
        return Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.topRight != null || widget.topLeft != null)
                TextInfoWidget(
                  leftText: widget.topLeft,
                  rightText: widget.topRight,
                ),
              Row(
                children: [
                  Container(
                    width: widget.hourWidth,
                    padding: const EdgeInsets.all(8),
                  ),
                  for (var day in daysWithEvents) DayHeaderWidget(day: day),
                ],
              ),
              widget.disableScroll
                  ? BodyWidget(
                      events: widget.events,
                      daysWithEvents: daysWithEvents,
                      startHour: startHour,
                      endHour: endHour,
                      constraints: constraints,
                      fontSize: widget.fontSize,
                      hourWidth: widget.hourWidth,
                      rowHeight: widget.rowHeight,
                    )
                  : Expanded(
                      child: SingleChildScrollView(
                        child: BodyWidget(
                          events: widget.events,
                          daysWithEvents: daysWithEvents,
                          startHour: startHour,
                          endHour: endHour,
                          constraints: constraints,
                          fontSize: widget.fontSize,
                          hourWidth: widget.hourWidth,
                          rowHeight: widget.rowHeight,
                        ),
                      ),
                    ),
              if (widget.bottomRight != null || widget.bottomLeft != null)
                TextInfoWidget(
                  leftText: widget.bottomRight,
                  rightText: widget.bottomLeft,
                ),
            ],
          ),
        );
      }),
    );
  }
}
