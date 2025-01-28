import 'package:flutter/material.dart';
import 'package:sigapp/student/domain/entities/student_semester_schedule.dart';

class ScheduleSemesterSelect extends StatelessWidget {
  const ScheduleSemesterSelect({
    super.key,
    required this.schedule,
    required this.onSemesterSelected,
  });

  final SemesterSchedule schedule;
  final void Function(SemesterScheduleSemesterMetadata semester)
      onSemesterSelected;

  @override
  Widget build(BuildContext context) {
    final semesterList = [...schedule.semesterList]
      ..sort((a, b) => b.id.compareTo(a.id));

    if (semesterList.isEmpty) {
      return const Center(
        child: Text('No hay semestres disponibles'),
      );
    }

    // Group semesters by year
    final Map<String, List<SemesterScheduleSemesterMetadata>> groupedByYear =
        {};
    for (var semester in semesterList) {
      groupedByYear.putIfAbsent(semester.year, () => []).add(semester);
    }

    // Convert map to list of widgets
    List<Widget> groupedWidgets = [];
    groupedByYear.forEach((year, semesters) {
      if (groupedWidgets.isNotEmpty) {
        groupedWidgets.add(
          const Divider(),
        );
      }
      groupedWidgets.addAll(semesters.map((semester) {
        final enabled = schedule.semester.id != semester.id;
        return Center(
          child: ListTile(
            title: Text(
              semester.name,
              textAlign: TextAlign.center,
            ),
            onTap: () {
              onSemesterSelected(semester);
            },
            enabled: enabled,
          ),
        );
      }).toList());
    });

    return ListView(
      children: groupedWidgets,
    );
  }
}
