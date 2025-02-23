import 'package:flutter/material.dart';
import 'package:sigapp/core/infrastructure/ui/utils/colors_utils.dart';
import 'package:sigapp/core/infrastructure/utils/time_utils.dart';
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

    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.topRight != null || widget.topLeft != null)
              TextInfo(
                leftText: widget.topLeft,
                rightText: widget.topRight,
              ),
            Row(
              children: [
                Container(
                  width: widget.hourWidth,
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
                    hourWidth: widget.hourWidth,
                    rowHeight: widget.rowHeight,
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
                        hourWidth: widget.hourWidth,
                        rowHeight: widget.rowHeight,
                      ),
                    ),
                  ),
            if (widget.bottomRight != null || widget.bottomLeft != null)
              TextInfo(
                leftText: widget.bottomRight,
                rightText: widget.bottomLeft,
              ),
          ],
        ),
      );
    });
  }
}

class TextInfo extends StatelessWidget {
  final Widget? leftText;
  final Widget? rightText;

  const TextInfo({super.key, this.leftText, this.rightText});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: leftText != null
          ? MainAxisAlignment.spaceBetween
          : MainAxisAlignment.end,
      children: [
        if (leftText != null)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: leftText!,
          ),
        if (rightText != null)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: rightText!,
          ),
      ],
    );
  }
}

class DayHeader extends StatelessWidget {
  final int day;

  const DayHeader({super.key, required this.day});

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
  final List<WeeklyScheduleWidgetItem> events;
  final List<int> daysWithEvents;
  final int startHour;
  final int endHour;
  final BoxConstraints constraints;
  final double fontSize;
  final double hourWidth;
  final double rowHeight;

  const Body({
    super.key,
    required this.events,
    required this.daysWithEvents,
    required this.startHour,
    required this.endHour,
    required this.constraints,
    required this.fontSize,
    required this.hourWidth,
    required this.rowHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Grid(
          daysWithEvents: daysWithEvents,
          startHour: startHour,
          endHour: endHour,
          constraints: constraints,
          hourWidth: hourWidth,
          rowHeight: rowHeight,
        ),
        ...events
            .where((event) =>
                event.data.startHour >= startHour &&
                event.data.endHour <= endHour)
            .map((event) => EventWidget(
                  event: event,
                  constraints: constraints,
                  daysWithEvents: daysWithEvents,
                  startHour: startHour,
                  fontSize: fontSize,
                  rowHeight: rowHeight,
                  hourWidth: hourWidth,
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
  final double hourWidth;
  final double rowHeight;
  final double littleRayLength;

  const Grid({
    super.key,
    required this.daysWithEvents,
    required this.startHour,
    required this.endHour,
    required this.constraints,
    required this.hourWidth,
    required this.rowHeight,
  }) : littleRayLength = hourWidth * 0.15;

  @override
  Widget build(BuildContext context) {
    final numOfRows = endHour - startHour - 1;
    return Column(
      children: List.generate(numOfRows, (hour) {
        return Row(
          children: [
            HourLabel(
              hour: startHour + hour,
              rowHeight: rowHeight,
              littleRayLength: littleRayLength,
              hourWidth: hourWidth,
            ),
            Expanded(
              child: Row(
                children: List.generate(daysWithEvents.length, (dayIndex) {
                  return Expanded(
                    child: Container(
                      height: rowHeight,
                      decoration: BoxDecoration(
                        border: Border(
                          left: dayIndex == 0
                              ? BorderSide(
                                  color: Colors.grey.withValues(alpha: 0.5),
                                )
                              : BorderSide.none,
                          right: dayIndex != daysWithEvents.length - 1
                              ? BorderSide(
                                  color: Colors.grey.withValues(alpha: 0.5),
                                )
                              : BorderSide.none,
                          bottom: BorderSide(
                            color: Colors.grey.withValues(alpha: 0.5),
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
              SizedBox(width: hourWidth, height: littleRayLength),
              for (var dayIndex
                  in List.generate(daysWithEvents.length, (index) => index))
                Container(
                  width: (constraints.maxWidth - hourWidth) /
                      daysWithEvents.length,
                  height: littleRayLength,
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
  final double rowHeight;
  final double littleRayLength;
  final double hourWidth;

  const HourLabel({
    super.key,
    required this.hour,
    required this.rowHeight,
    required this.littleRayLength,
    required this.hourWidth,
  });

  @override
  Widget build(BuildContext context) {
    String period = hour >= 12 ? 'pm' : 'am';
    int displayHour = hour > 12 ? hour - 12 : hour;
    displayHour = displayHour == 0 ? 12 : displayHour;
    String formattedHour = '$displayHour$period';

    return SizedBox(
      width: hourWidth,
      height: rowHeight,
      child: Stack(
        children: [
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: littleRayLength,
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
  final WeeklyScheduleWidgetItem event;
  final BoxConstraints constraints;
  final List<int> daysWithEvents;
  final int startHour;
  final double fontSize;
  final double rowHeight;
  final double hourWidth;

  const EventWidget({
    super.key,
    required this.event,
    required this.constraints,
    required this.daysWithEvents,
    required this.startHour,
    required this.fontSize,
    required this.rowHeight,
    required this.hourWidth,
  });

  @override
  Widget build(BuildContext context) {
    final top = (event.data.startHour - startHour) * rowHeight +
        (event.data.startMinute / 60) * rowHeight;
    final gridWidth =
        (constraints.maxWidth - hourWidth) / daysWithEvents.length;
    final littleMarginForSides = gridWidth * 0.05;
    final width = gridWidth - littleMarginForSides;
    final dayIndex = daysWithEvents.indexOf(event.data.weekday);
    final left = hourWidth + dayIndex * gridWidth;
    final height = ((event.data.endHour - event.data.startHour) * rowHeight +
            ((event.data.endMinute - event.data.startMinute) / 60) *
                rowHeight) -
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

    final textColor = ColorsUtils.getTextColor(event.color);

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
              SizedBox(
                height: availableHeightForTitle,
                width: availableWidth,
                child: Text(
                  event.data.courseName,
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
                SizedBox(
                  width: availableWidth,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event.data.location,
                        style: TextStyle(
                          color: textColor,
                          fontSize: captionFontSize,
                          height: captionLineHeight,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        TimeUtils.formatEventDuration(EventDuration(
                          startHour: event.data.startHour,
                          startMinute: event.data.startMinute,
                          endHour: event.data.endHour,
                          endMinute: event.data.endMinute,
                        )),
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
}
