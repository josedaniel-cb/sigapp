import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sigapp/core/infrastructure/ui/utils/colors_utils.dart';
import 'package:sigapp/core/infrastructure/utils/time_utils.dart';
import 'package:sigapp/courses/infrastructure/pages/courses/partials/weekly_schedule.dart';

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
        (event.data.startMinutes / 60) * rowHeight;
    final gridWidth =
        (constraints.maxWidth - hourWidth) / daysWithEvents.length;
    final littleMarginForSides = gridWidth * 0.05;
    final width = gridWidth - littleMarginForSides;
    final dayIndex = daysWithEvents.indexOf(event.data.weekday);
    final left = hourWidth + dayIndex * gridWidth;
    final height = ((event.data.endHour - event.data.startHour) * rowHeight +
            ((event.data.endMinutes - event.data.startMinutes) / 60) *
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

    return DefaultTextStyle(
      style: GoogleFonts.lato(),
      child: Positioned(
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
                            startMinute: event.data.startMinutes,
                            endHour: event.data.endHour,
                            endMinute: event.data.endMinutes,
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
      ),
    );
  }
}
