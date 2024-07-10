import 'package:flutter/foundation.dart';
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

  static const hourWidth = 50.0;
  static const rowHeight = 75.0;
  static const littleRay = rowHeight * 0.1;

  @override
  void initState() {
    super.initState();
    _calculateHourRange();
  }

  void _calculateHourRange() {
    if (widget.events.isEmpty) {
      startHour = 8;
      endHour = 18;
    } else {
      startHour = widget.events
          .map((event) => event.startHour)
          .reduce((a, b) => a < b ? a : b);
      endHour = widget.events
              .map((event) => event.endHour)
              .reduce((a, b) => a > b ? a : b) +
          1;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.events.isEmpty) {
      return const Center(
        child: Text('No events to display'),
      );
    }

    List<int> daysWithEvents = List.generate(7, (index) => index + 1)
        .where((day) => widget.events.any((event) => event.weekday == day))
        .toList();

    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.topRightText != null || widget.topLeftText != null)
              TopTextRow(
                topLeftText: widget.topLeftText,
                topRightText: widget.topRightText,
              ),
            Row(
              children: [
                Container(
                  width: hourWidth,
                  padding: const EdgeInsets.all(8),
                ),
                for (var day in daysWithEvents) DayHeader(day: day),
              ],
            ),
            widget.disableScroll
                ? Body(
                    events: widget.events,
                    daysWithEvents: daysWithEvents,
                    startHour: startHour,
                    endHour: endHour,
                    constraints: constraints,
                    fontSize: widget.fontSize,
                  )
                : Expanded(
                    child: SingleChildScrollView(
                      child: Body(
                        events: widget.events,
                        daysWithEvents: daysWithEvents,
                        startHour: startHour,
                        endHour: endHour,
                        constraints: constraints,
                        fontSize: widget.fontSize,
                      ),
                    ),
                  ),
          ],
        ),
      );
    });
  }
}

class TopTextRow extends StatelessWidget {
  final String? topLeftText;
  final String? topRightText;

  const TopTextRow({Key? key, this.topLeftText, this.topRightText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: topLeftText != null
          ? MainAxisAlignment.spaceBetween
          : MainAxisAlignment.end,
      children: [
        if (topLeftText != null)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Text(topLeftText!),
          ),
        if (topRightText != null)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Text(topRightText!),
          ),
      ],
    );
  }
}

class DayHeader extends StatelessWidget {
  final int day;

  const DayHeader({Key? key, required this.day}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Center(child: Text(dayLabel)),
      ),
    );
  }
}

class Body extends StatelessWidget {
  final List<WeeklyScheduleEvent> events;
  final List<int> daysWithEvents;
  final int startHour;
  final int endHour;
  final BoxConstraints constraints;
  final double fontSize;

  const Body({
    Key? key,
    required this.events,
    required this.daysWithEvents,
    required this.startHour,
    required this.endHour,
    required this.constraints,
    required this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Grid(
          daysWithEvents: daysWithEvents,
          startHour: startHour,
          endHour: endHour,
          constraints: constraints,
        ),
        ...events
            .where((event) =>
                event.startHour >= startHour && event.endHour <= endHour)
            .map((event) => EventWidget(
                  event: event,
                  constraints: constraints,
                  daysWithEvents: daysWithEvents,
                  startHour: startHour,
                  fontSize: fontSize,
                )),
      ],
    );
  }
}

class Grid extends StatelessWidget {
  final List<int> daysWithEvents;
  final int startHour;
  final int endHour;
  final BoxConstraints constraints;

  const Grid({
    Key? key,
    required this.daysWithEvents,
    required this.startHour,
    required this.endHour,
    required this.constraints,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final numOfRows = endHour - startHour - 1;
    return Column(
      children: List.generate(numOfRows, (hour) {
        return Row(
          children: [
            HourLabel(hour: startHour + hour),
            Expanded(
              child: Row(
                children: List.generate(daysWithEvents.length, (dayIndex) {
                  return Expanded(
                    child: Container(
                      height: 75.0,
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
          Row(
            children: [
              const SizedBox(
                width: 50.0,
                height: 7.5,
              ),
              for (var dayIndex
                  in List.generate(daysWithEvents.length, (index) => index))
                Container(
                  width: (constraints.maxWidth - 50.0) / daysWithEvents.length,
                  height: 7.5,
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
        ]),
    );
  }
}

class HourLabel extends StatelessWidget {
  final int hour;

  const HourLabel({Key? key, required this.hour}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String period = hour >= 12 ? 'pm' : 'am';
    int displayHour = hour > 12 ? hour - 12 : hour;
    displayHour = displayHour == 0 ? 12 : displayHour;
    String formattedHour = '$displayHour$period';

    return Container(
      width: 50.0,
      height: 75.0,
      child: Stack(
        children: [
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: 7.5,
              height: 1,
              color: Colors.grey.withOpacity(0.5),
            ),
          ),
          Container(
            alignment: Alignment.topCenter,
            child: Text(formattedHour),
          ),
        ],
      ),
    );
  }
}

class EventWidget extends StatelessWidget {
  final WeeklyScheduleEvent event;
  final BoxConstraints constraints;
  final List<int> daysWithEvents;
  final int startHour;
  final double fontSize;

  const EventWidget({
    Key? key,
    required this.event,
    required this.constraints,
    required this.daysWithEvents,
    required this.startHour,
    required this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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

    final top =
        (event.startHour - startHour) * 75.0 + (event.startMinute / 60) * 75.0;
    final gridWidth = (constraints.maxWidth - 50.0) / daysWithEvents.length;
    final littleMarginForSides = gridWidth * 0.05;
    final width = gridWidth - littleMarginForSides;
    final dayIndex = daysWithEvents.indexOf(event.weekday);
    final left = 50.0 + dayIndex * gridWidth;
    final height = ((event.endHour - event.startHour) * 75.0 +
            ((event.endMinute - event.startMinute) / 60) * 75.0) -
        littleMarginForSides;

    final titleFontSize = fontSize;
    const titleLineHeight = 1.1;
    final titleOneLineHeight = titleFontSize * titleLineHeight;

    final captionFontSize = titleFontSize * 0.75;
    const double captionLineHeight = 1.2;
    final captionOneLineHeight = captionFontSize * captionLineHeight;
    final captionsHeight = captionOneLineHeight * 2;

    final separatorSpace = captionOneLineHeight;

    final verticalPadding = titleFontSize / 2;
    final horizontalPadding = titleFontSize / 3;

    final availableHeight = height - (verticalPadding * 2);
    var availableHeightForTitle = availableHeight;
    final captionsCanBeShown = availableHeight >
        (titleOneLineHeight + separatorSpace + captionsHeight);
    if (captionsCanBeShown) {
      availableHeightForTitle -= separatorSpace + captionsHeight;
    }
    final titleMaxLines =
        (availableHeightForTitle / titleOneLineHeight).floor();

    final availableWidth = width - (horizontalPadding * 2);

    final textColor = chooseTextColor(event.color);

    return Positioned(
      top: top,
      left: left,
      width: width,
      height: height,
      child: Container(
        decoration: BoxDecoration(
          color: event.color,
          borderRadius: BorderRadius.circular(verticalPadding),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: verticalPadding,
            horizontal: horizontalPadding,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: availableHeightForTitle,
                width: availableWidth,
                child: Text(
                  event.title,
                  style: TextStyle(
                    color: textColor,
                    fontSize: titleFontSize,
                    height: titleLineHeight,
                  ),
                  maxLines: titleMaxLines,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (captionsCanBeShown)
                Container(
                  width: availableWidth,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event.location,
                        style: TextStyle(
                          color: textColor,
                          fontSize: captionFontSize,
                          height: captionLineHeight,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        _formatEventDuration(event),
                        style: TextStyle(
                          color: textColor,
                          fontSize: captionFontSize,
                          height: captionLineHeight,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatEventDuration(WeeklyScheduleEvent event) {
    String startHour =
        (event.startHour > 12 ? event.startHour - 12 : event.startHour)
            .toString();
    String endHour =
        (event.endHour > 12 ? event.endHour - 12 : event.endHour).toString();

    String startPeriod = event.startHour >= 12 ? 'pm' : 'am';
    String endPeriod = event.endHour >= 12 ? 'pm' : 'am';

    String startMinute = event.startMinute == 0
        ? ''
        : ':${event.startMinute.toString().padLeft(2, '0')}';
    String endMinute = event.endMinute == 0
        ? ''
        : ':${event.endMinute.toString().padLeft(2, '0')}';

    String startAmPm = startPeriod == endPeriod ? '' : startPeriod;
    String endAmPm = endPeriod;

    if (startMinute.isEmpty && endMinute.isEmpty) {
      return '$startHour$startAmPm - $endHour$endAmPm';
    } else {
      return '$startHour$startMinute$startAmPm - $endHour$endMinute$endAmPm';
    }
  }
}
