import 'package:flutter/material.dart';
import 'package:sigapp/core/infrastructure/ui/utils/colors_utils.dart';
import 'package:sigapp/core/infrastructure/utils/time_utils.dart';
import 'package:sigapp/courses/infrastructure/pages/enrolled_courses/partials/weekly_schedule.dart';

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
    // Obtener el ancho de la pantalla para adaptar el tamaño del texto
    // final screenSize = MediaQuery.of(context).size;
    // final screenWidth = screenSize.width;

    // Factor de escala basado en el ancho de la pantalla
    // Se usa 600.0 como ancho de referencia para una tablet pequeña
    // final scaleFactor = screenWidth / 600.0;

    // Limitar el factor de escala para evitar textos muy grandes o muy pequeños
    // final adaptiveScaleFactor = scaleFactor.clamp(0.7, 1.3);
    final adaptiveScaleFactor = MediaQuery.of(context).size.width * 0.0013;

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

    // Ajustar el tamaño de la fuente según el tamaño de la pantalla y especificaciones del usuario
    // Multiplicamos x2 el tamaño de la fuente del título (nombre del curso)
    final titleFontSize = fontSize * adaptiveScaleFactor * 1.9;
    const titleLineHeight = 1.1;
    final titleOneLineHeight = titleFontSize * titleLineHeight;

    // Para el texto de la ubicación, aumentamos un poco más que el tamaño normal
    final locationFontSize = fontSize * adaptiveScaleFactor * 1.4;

    // Para la duración del evento, mantenemos el tamaño original que ya estaba bien
    final durationFontSize = fontSize * adaptiveScaleFactor * 1.4;

    const double captionLineHeight = 1.2;
    final locationOneLineHeight = locationFontSize * captionLineHeight;
    final durationOneLineHeight = durationFontSize * captionLineHeight;
    final captionsHeight = locationOneLineHeight + durationOneLineHeight;

    final separatorSpace = locationOneLineHeight * 0.5;

    final verticalPadding = titleFontSize / 2;
    final horizontalPadding = titleFontSize / 3;

    // Ajustar el resto de cálculos basados en el nuevo tamaño de fuente
    final availableHeight = height - (verticalPadding * 2);
    var availableHeightForTitle = availableHeight;
    final captionsCanBeShown = availableHeight >
        (titleOneLineHeight + separatorSpace + captionsHeight);
    if (captionsCanBeShown) {
      availableHeightForTitle -= separatorSpace + captionsHeight;
    }

    // Corregido: Añadir un pequeño margen de seguridad para el ellipsis
    // Restar un pequeño porcentaje para evitar el desbordamiento
    final safetyMargin =
        titleOneLineHeight * 0.15; // 15% de la altura de una línea
    final titleMaxLines =
        ((availableHeightForTitle - safetyMargin) / titleOneLineHeight).floor();

    // Asegurar que siempre haya al menos una línea para mostrar
    final finalTitleMaxLines = titleMaxLines > 0 ? titleMaxLines : 1;

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
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: finalTitleMaxLines,
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
                          fontSize: locationFontSize,
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
                          fontSize: durationFontSize,
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
