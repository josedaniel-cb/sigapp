import 'package:flutter/material.dart';
import 'package:sigapp/courses/domain/entities/program_curriculum_course_term.dart';

class ApprovalChipsWidget extends StatelessWidget {
  final String approvalFilter;
  final ValueChanged<String> onApprovalChanged;
  final CourseTreeNode? tree;

  const ApprovalChipsWidget({
    super.key,
    required this.approvalFilter,
    required this.onApprovalChanged,
    required this.tree,
  });

  Map<String, int> _countCoursesByApproval(CourseTreeNode? node) {
    if (node == null) return {'todos': 0, 'aprobado': 0, 'no_aprobado': 0};

    final counts = {'todos': 0, 'aprobado': 0, 'no_aprobado': 0};

    void countRecursive(CourseTreeNode currentNode) {
      counts['todos'] = counts['todos']! + 1;

      if (currentNode.course.isApproved == true) {
        counts['aprobado'] = counts['aprobado']! + 1;
      } else if (currentNode.course.isApproved == false) {
        counts['no_aprobado'] = counts['no_aprobado']! + 1;
      }

      for (final child in currentNode.children) {
        countRecursive(child);
      }
    }

    countRecursive(node);
    return counts;
  }

  Widget _buildChoiceChip({
    required String label,
    required String value,
    required int count,
    required bool isSelected,
  }) {
    return ChoiceChip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label),
          const SizedBox(width: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
            decoration: BoxDecoration(
              color:
                  isSelected
                      ? Colors.white.withValues(alpha: 0.8)
                      : Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              '$count',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.blue.shade700 : Colors.grey.shade600,
              ),
            ),
          ),
        ],
      ),
      selected: isSelected,
      onSelected:
          count > 0 || value == 'todos'
              ? (v) => onApprovalChanged(value)
              : null,
      padding: const EdgeInsets.all(4),
      backgroundColor:
          count == 0 && value != 'todos' ? Colors.grey.shade100 : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    final counts = _countCoursesByApproval(tree);
    final totalCount = counts['todos'] ?? 0;
    final approvedCount = counts['aprobado'] ?? 0;
    final notApprovedCount = counts['no_aprobado'] ?? 0;

    return Wrap(
      spacing: 8,
      children: [
        _buildChoiceChip(
          label: 'Todos',
          value: 'todos',
          count: totalCount,
          isSelected: approvalFilter == 'todos',
        ),
        _buildChoiceChip(
          label: 'Aprobados',
          value: 'aprobado',
          count: approvedCount,
          isSelected: approvalFilter == 'aprobado',
        ),
        _buildChoiceChip(
          label: 'No aprobados',
          value: 'no_aprobado',
          count: notApprovedCount,
          isSelected: approvalFilter == 'no_aprobado',
        ),
      ],
    );
  }
}
