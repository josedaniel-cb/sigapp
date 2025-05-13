import 'package:flutter/material.dart';
import 'package:sigapp/courses/infrastructure/pages/enrolled_courses/partials/weekly_schedule.dart';
import 'package:sigapp/core/infrastructure/utils/time_utils.dart';

class CourseDetailsDialog extends StatelessWidget {
  final WeeklyScheduleWidgetItem event;

  const CourseDetailsDialog({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        event.data.courseName,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoRow(
            Icons.location_on,
            'Ubicación:',
            event.data.location,
          ),
          const SizedBox(height: 12),
          _buildInfoRow(
            Icons.access_time,
            'Horario:',
            _getDayAndTime(),
          ),
          const SizedBox(height: 12),
          // _buildInfoRow(
          //   Icons.person,
          //   'Profesor:',
          //   event.data.professor ?? 'No disponible',
          // ),
          // if (event.data.courseCode != null) ...[
          //   const SizedBox(height: 12),
          //   _buildInfoRow(
          //     Icons.numbers,
          //     'Código:',
          //     event.data.courseCode!,
          //   ),
          // ],
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cerrar'),
        ),
      ],
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(value),
            ],
          ),
        ),
      ],
    );
  }

  String _getDayAndTime() {
    String day;
    switch (event.data.weekday) {
      case 1:
        day = 'Lunes';
        break;
      case 2:
        day = 'Martes';
        break;
      case 3:
        day = 'Miércoles';
        break;
      case 4:
        day = 'Jueves';
        break;
      case 5:
        day = 'Viernes';
        break;
      case 6:
        day = 'Sábado';
        break;
      case 7:
        day = 'Domingo';
        break;
      default:
        day = '';
    }

    String time = TimeUtils.formatEventDuration(EventDuration(
      startHour: event.data.startHour,
      startMinute: event.data.startMinutes,
      endHour: event.data.endHour,
      endMinute: event.data.endMinutes,
    ));

    return '$day, $time';
  }
}
