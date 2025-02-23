import 'package:flutter/material.dart';
import 'package:sigapp/student/domain/entities/student_semester_schedule.dart';

class ScheduleSemesterSelect extends StatefulWidget {
  const ScheduleSemesterSelect({
    super.key,
    required this.semesterList,
    required this.selectedSemester,
    required this.onSemesterSelected,
  });

  final List<SemesterScheduleSemesterMetadata> semesterList;
  final SemesterScheduleSemesterMetadata selectedSemester;
  final void Function(SemesterScheduleSemesterMetadata semester)
      onSemesterSelected;

  @override
  State<ScheduleSemesterSelect> createState() => _ScheduleSemesterSelectState();
}

class _ScheduleSemesterSelectState extends State<ScheduleSemesterSelect> {
  // Semesters GlobalKeys map
  final Map<String, GlobalKey> _keysById = {};

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // After rendering, scroll to the selected semester
      final key = _keysById[widget.selectedSemester.id];
      if (key != null && key.currentContext != null) {
        Scrollable.ensureVisible(
          key.currentContext!,
          alignment: 0.5, // 0.0 = top, 0.5 = center, 1.0 = bottom
          duration: const Duration(milliseconds: 200),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final semesterList = [...widget.semesterList]
      ..sort((a, b) => a.id.compareTo(b.id));

    if (semesterList.isEmpty) {
      return const Center(
        child: Text('No hay semestres disponibles'),
      );
    }

    // Group per year
    final Map<String, List<SemesterScheduleSemesterMetadata>> groupedByYear =
        {};
    for (var semester in semesterList) {
      groupedByYear.putIfAbsent('${semester.year}', () => []).add(semester);
    }

    List<Widget> groupedWidgets = [];
    groupedByYear.forEach((year, semesters) {
      if (groupedWidgets.isNotEmpty) {
        groupedWidgets.add(const Divider());
      }
      groupedWidgets.addAll(semesters.map((semester) {
        // Creates a GlobalKey for each semester
        final key = GlobalKey();
        _keysById[semester.id] = key;

        final isSelected = semester.id == widget.selectedSemester.id;
        return Center(
          child: ListTile(
            key: key, // Assign the GlobalKey to the ListTile
            title: Text(
              semester.name,
              textAlign: TextAlign.center,
              style: isSelected
                  ? TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    )
                  : null,
            ),
            onTap: isSelected
                ? null
                : () {
                    widget.onSemesterSelected(semester);
                  },
          ),
        );
      }));
    });

    return ListView(
      children: groupedWidgets,
    );
  }
}
