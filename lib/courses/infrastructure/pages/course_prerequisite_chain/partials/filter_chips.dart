import 'package:flutter/material.dart';
import 'package:sigapp/courses/domain/entities/course_type.dart';
import 'package:sigapp/courses/domain/entities/program_curriculum_course_term.dart';

class FilterChipsWidget extends StatelessWidget {
  final bool showMandatory;
  final bool showElective;
  final ValueChanged<bool> onMandatoryChanged;
  final ValueChanged<bool> onElectiveChanged;
  final CourseTreeNode? tree;

  const FilterChipsWidget({
    super.key,
    required this.showMandatory,
    required this.showElective,
    required this.onMandatoryChanged,
    required this.onElectiveChanged,
    required this.tree,
  });

  Map<String, int> _countCoursesByType(CourseTreeNode? node) {
    if (node == null) return {'mandatory': 0, 'elective': 0};

    final counts = {'mandatory': 0, 'elective': 0};

    void countRecursive(CourseTreeNode currentNode) {
      if (currentNode.course.info.courseType == CourseType.mandatory) {
        counts['mandatory'] = counts['mandatory']! + 1;
      } else if (currentNode.course.info.courseType == CourseType.elective) {
        counts['elective'] = counts['elective']! + 1;
      }

      for (final child in currentNode.children) {
        countRecursive(child);
      }
    }

    countRecursive(node);
    return counts;
  }

  @override
  Widget build(BuildContext context) {
    final counts = _countCoursesByType(tree);
    final mandatoryCount = counts['mandatory'] ?? 0;
    final electiveCount = counts['elective'] ?? 0;

    return Wrap(
      spacing: 8,
      children: [
        FilterChip(
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Obligatorios'),
              if (mandatoryCount > 0) ...[
                const SizedBox(width: 4),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 1,
                  ),
                  decoration: BoxDecoration(
                    color:
                        showMandatory
                            ? Colors.white.withOpacity(0.8)
                            : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '$mandatoryCount',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color:
                          showMandatory
                              ? Colors.blue.shade700
                              : Colors.grey.shade600,
                    ),
                  ),
                ),
              ],
            ],
          ),
          selected: showMandatory,
          onSelected: mandatoryCount > 0 ? onMandatoryChanged : null,
          padding: const EdgeInsets.all(4),
          backgroundColor: mandatoryCount == 0 ? Colors.grey.shade100 : null,
        ),
        FilterChip(
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Electivos'),
              if (electiveCount > 0) ...[
                const SizedBox(width: 4),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 1,
                  ),
                  decoration: BoxDecoration(
                    color:
                        showElective
                            ? Colors.white.withOpacity(0.8)
                            : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '$electiveCount',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color:
                          showElective
                              ? Colors.blue.shade700
                              : Colors.grey.shade600,
                    ),
                  ),
                ),
              ],
            ],
          ),
          selected: showElective,
          onSelected: electiveCount > 0 ? onElectiveChanged : null,
          padding: const EdgeInsets.all(4),
          backgroundColor: electiveCount == 0 ? Colors.grey.shade100 : null,
        ),
      ],
    );
  }
}
