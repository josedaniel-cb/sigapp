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
      startHour =
          8; // Cambiado para un valor más común para un horario académico
      endHour =
          18; // Cambiado para un valor más común para un horario académico
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
        // height: constraints.maxHeight, // Asegurando tamaño fijo
        // width: constraints.maxWidth, // Asegurando tamaño fijo
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
    final numOfRows =
        endHour - startHour - 1; // -1 required to avoid an empty row
    return Column(
      children: List.generate(numOfRows, (hour) {
        return Row(
          children: [
            _buildHourLabel(_formatHour(startHour + hour)),
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
      height: rowHeight,
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

    // Position and size
    final top = (event.start.hour - startHour) * rowHeight +
        (event.start.minute / 60) * rowHeight;
    final gridWidth =
        (constraints.maxWidth - hourWidth) / daysWithEvents.length;
    final littleMarginForSides = gridWidth * 0.05;
    final width = gridWidth - littleMarginForSides; // some margin to right
    final dayIndex = daysWithEvents.indexOf(event.start.weekday);
    final left = hourWidth + dayIndex * gridWidth;
    final height = ((event.end.hour - event.start.hour) * rowHeight +
            ((event.end.minute - event.start.minute) / 60) * rowHeight) -
        littleMarginForSides; // some margin to bottom

    // Texts: title and captions (place and duration)
    final titleFontSize = widget.fontSize; // for title
    const titleLineHeight = 1.1;
    final titleOneLineHeight = titleFontSize *
        titleLineHeight; // this is not calculating the actual rendered height

    final separatorSpace = titleOneLineHeight * 0.5;

    final captionFontSize = titleFontSize * 0.75; // for place and duration
    const double captionLineHeight = 1.2;
    final captionOneLineHeight = captionFontSize *
        captionLineHeight; // this is not calculating the actual rendered height
    final captionsHeight = captionOneLineHeight * 2 +
        4; // place + duration / adding 4 for auxiliar padding

    // Padding for all sides of the event
    final verticalPadding = titleFontSize / 2;
    final horizontalPadding = titleFontSize / 3;

    final availableHeight = height - (verticalPadding * 2);
    var availableHeightForTitle = availableHeight;
    final captionsCanBeShown = // if there is enough space for title captions
        availableHeight >
            (titleOneLineHeight + separatorSpace + captionsHeight);
    if (captionsCanBeShown) {
      availableHeightForTitle -= separatorSpace + captionsHeight;
    }
    final titleMaxLines =
        (availableHeightForTitle / titleOneLineHeight).floor();

    final textColor = chooseTextColor(event.color);

    if (kDebugMode) {
      // cat emoji: 🐱
      // debugging:
      var acumulativeHeight = verticalPadding;
      acumulativeHeight += titleMaxLines * titleOneLineHeight;
      if (captionsCanBeShown) {
        acumulativeHeight += captionsHeight;
      }
      acumulativeHeight += verticalPadding;
      print('🐱 ${event.title} (${_formatEventDuration(event)})');
      print('height: $height');
      print('acumulativeHeight: $acumulativeHeight');

      if (acumulativeHeight > height) {
        print('🐱 WARNING: Not enough space for text');
      }
    }

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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: captionsCanBeShown
                    ? EdgeInsets.only(bottom: separatorSpace)
                    : null,
                // color: Colors.white30,
                height: availableHeightForTitle,
                child: Text(
                  event.title,
                  style: TextStyle(
                    color: textColor,
                    fontSize: titleFontSize,
                    height: titleLineHeight,
                  ),
                  maxLines: titleMaxLines,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
              if (captionsCanBeShown)
                Container(
                  height: captionsHeight,
                  child: Column(
                    children: [
                      Text(
                        event.place,
                        style: TextStyle(
                          color: textColor,
                          fontSize: captionFontSize,
                          height: captionLineHeight,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
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
                        textAlign: TextAlign.center,
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
        (event.start.hour > 12 ? event.start.hour - 12 : event.start.hour)
            .toString();
    String endHour =
        (event.end.hour > 12 ? event.end.hour - 12 : event.end.hour).toString();

    String startPeriod = event.start.hour >= 12 ? 'pm' : 'am';
    String endPeriod = event.end.hour >= 12 ? 'pm' : 'am';

    String startMinute = event.start.minute == 0
        ? ''
        : ':${event.start.minute.toString().padLeft(2, '0')}';
    String endMinute = event.end.minute == 0
        ? ''
        : ':${event.end.minute.toString().padLeft(2, '0')}';

    String startAmPm = startPeriod == endPeriod ? '' : startPeriod;
    String endAmPm = endPeriod;

    if (startMinute.isEmpty && endMinute.isEmpty) {
      return '$startHour$startAmPm - $endHour$endAmPm';
    } else {
      return '$startHour$startMinute$startAmPm - $endHour$endMinute$endAmPm';
    }
  }
}
