import 'package:flutter/material.dart';
import 'package:sigapp/student/entities/weekly_schedule_event.dart';

class WeeklySchedule extends StatefulWidget {
  final List<WeeklyScheduleEvent> events;
  final String? bottomRightText;
  final String? bottomLeftText;
  final String? topRightText;
  final String? topLeftText;
  final bool disableScroll;
  final double fontSize;

  const WeeklySchedule({
    super.key,
    required this.events,
    this.fontSize = 12.0,
    this.disableScroll = false,
    this.bottomRightText,
    this.bottomLeftText,
    this.topRightText,
    this.topLeftText,
  });

  @override
  State<WeeklySchedule> createState() => _WeeklyScheduleState();
}

class _WeeklyScheduleState extends State<WeeklySchedule> {
  late int startHour;
  late int endHour;

  static const littleRay = 10.0;
  static const hourWidth = 50.0;
  static const hourHeight = 75.0;

  @override
  void initState() {
    super.initState();
    _calculateHourRange();
  }

  void _calculateHourRange() {
    if (widget.events.isEmpty) {
      // Set default values or handle the case when there are no events
      startHour = 0; // Default or a sensible value for your use case
      endHour = 24; // Default or a sensible value for your use case
    } else {
      startHour = widget.events
          .map((event) => event.start.hour)
          .reduce((a, b) => a < b ? a : b);
      endHour = widget.events
              .map((event) => event.end.hour)
              .reduce((a, b) => a > b ? a : b) +
          1;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.events.isEmpty) {
      // Display a message or alternative content when there are no events
      return const Center(
        child: Text('No events to display'),
      );
    }

    List<int> daysWithEvents = List.generate(7, (index) => index + 1)
        .where(
            (day) => widget.events.any((event) => event.start.weekday == day))
        .toList();

    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.topRightText != null || widget.topLeftText != null)
              Row(
                mainAxisAlignment: widget.topLeftText != null
                    ? MainAxisAlignment.spaceBetween
                    : MainAxisAlignment.end,
                children: [
                  if (widget.topLeftText != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      child: Text(
                        widget.topLeftText!,
                      ),
                    ),
                  if (widget.topRightText != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      child: Text(
                        widget.topRightText!,
                      ),
                    ),
                ],
              ),
            // Header for days of the week
            Row(
              children: [
                Container(
                  width: hourWidth,
                  padding: const EdgeInsets.all(8),
                ),
                for (var day in daysWithEvents) _buildDayHeader(day),
              ],
            ),
            // Combined hourly labels and events grid
            widget.disableScroll
                ? _buildBody(daysWithEvents, context, constraints)
                : Expanded(
                    child: SingleChildScrollView(
                      child: _buildBody(daysWithEvents, context, constraints),
                    ),
                  ),
          ],
        ),
      );
    });
  }

  Widget _buildBody(List<int> daysWithEvents, BuildContext context,
      BoxConstraints constraints) {
    return Stack(
      children: [
        _buildGrid(daysWithEvents, constraints),
        ...widget.events
            .where((event) =>
                event.start.hour >= startHour && event.end.hour <= endHour)
            .map((event) => _buildEvent(event, constraints, daysWithEvents)),
      ],
    );
  }

  Widget _buildGrid(List<int> daysWithEvents, BoxConstraints constraints) {
    return Column(
      children: List.generate(endHour - 1 - startHour, (hour) {
        return Row(
          children: [
            _buildHourLabel(_formatHour(startHour + hour)),
            Expanded(
              child: Row(
                children: List.generate(daysWithEvents.length, (dayIndex) {
                  return Expanded(
                    child: Container(
                      height: hourHeight,
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
        ..addAll([
          // an aux row just to print right borders of 10 height
          Row(
            children: [
              const SizedBox(
                width: hourWidth,
                height: littleRay,
              ),
              for (var dayIndex
                  in List.generate(daysWithEvents.length, (index) => index))
                Container(
                  width: (constraints.maxWidth - hourWidth) /
                      daysWithEvents.length,
                  height: littleRay,
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
          if (widget.bottomRightText != null || widget.bottomLeftText != null)
            Row(
              mainAxisAlignment: widget.bottomLeftText != null
                  ? MainAxisAlignment.spaceBetween
                  : MainAxisAlignment.end,
              children: [
                if (widget.bottomLeftText != null)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Text(
                      widget.bottomLeftText!,
                    ),
                  ),
                if (widget.bottomRightText != null)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Text(
                      widget.bottomRightText!,
                    ),
                  ),
              ],
            ),
        ]),
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
      width: hourWidth,
      height: hourHeight,
      // color: Colors.green,
      child: Stack(
        children: [
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: littleRay, // Width of the right side border
              height: 1, // Height to simulate the bottom border
              color: Colors.grey.withOpacity(0.5),
            ),
          ),
          Container(
            alignment: Alignment.topCenter,
            child: Text(hour),
          ),
        ],
      ),
    );
  }

  Widget _buildEvent(WeeklyScheduleEvent event, BoxConstraints constraints,
      List<int> daysWithEvents) {
    double calculateLuminance(Color color) {
      final double r = color.red / 255;
      final double g = color.green / 255;
      final double b = color.blue / 255;
      return 0.299 * r + 0.287 * g + 0.114 * b;
    }

    Color chooseTextColor(Color backgroundColor) {
      return calculateLuminance(backgroundColor) > 0.5
          ? Colors.black
          : Colors.white;
    }

    double top =
        (event.start.hour - startHour) * hourHeight + event.start.minute;
    double height = (event.end.hour - event.start.hour) * hourHeight +
        (event.end.minute - event.start.minute);
    int dayIndex = daysWithEvents.indexOf(event.start.weekday);

    final fontSize1 = widget.fontSize;
    const lineHeight1 = 1.1;
    final fontSize2 =
        fontSize1 * 0.75; // Unified font size for both place and duration
    const lineHeight2 = 1.2; // Unified line height for both place and duration
    final paddingFactor = widget.fontSize / 3;
    const secondTextThreshold = 30.0;

    // Adjusting the available height calculation to account for the place and duration information
    double availableHeight =
        height - paddingFactor; // Subtracting vertical padding
    if (height > secondTextThreshold) {
      double secondTextHeight = fontSize2 * lineHeight2 + paddingFactor / 2;
      availableHeight -=
          secondTextHeight; // Adjust for one line of text, since both will share style
      availableHeight -=
          secondTextHeight; // Adjust for the second line if place is available
    }

    // Recalculate maxLines for the first text considering the additional information
    int maxLines = (availableHeight / (fontSize1 * lineHeight1)).floor();

    final textColor = chooseTextColor(event.color);

    final gridWidth =
        (constraints.maxWidth - hourWidth) / daysWithEvents.length;
    return Positioned(
      top: top,
      left: hourWidth + dayIndex * gridWidth,
      width: gridWidth - paddingFactor,
      height: height,
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: paddingFactor / 2,
          vertical: paddingFactor / 4,
        ),
        decoration: BoxDecoration(
          color: event.color,
          borderRadius: BorderRadius.circular(paddingFactor),
        ),
        child: Padding(
          padding: EdgeInsets.all(paddingFactor),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                event.title,
                style: TextStyle(
                  color: textColor,
                  fontSize: fontSize1,
                  height: lineHeight1,
                ),
                maxLines: maxLines,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
              Text(
                event.place,
                style: TextStyle(
                    color: textColor, fontSize: fontSize2, height: lineHeight2),
                textAlign: TextAlign.center,
              ),
              if (height > secondTextThreshold)
                Text(
                  _formatEventDuration(event),
                  style: TextStyle(
                      color: textColor,
                      fontSize: fontSize2,
                      height: lineHeight2),
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
