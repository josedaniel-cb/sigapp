import 'package:flutter/material.dart';
import 'package:sigapp/courses/domain/entities/program_curriculum_course_term.dart';

class FilterResultsCounter extends StatelessWidget {
  final CourseTreeNode? originalTree;
  final CourseTreeNode? filteredTree;
  final bool showMandatory;
  final bool showElective;
  final String approvalFilter;

  const FilterResultsCounter({
    super.key,
    required this.originalTree,
    required this.filteredTree,
    required this.showMandatory,
    required this.showElective,
    required this.approvalFilter,
  });

  int _countNodesInTree(CourseTreeNode? node) {
    if (node == null) return 0;
    int count = 1; // El nodo actual
    for (final child in node.children) {
      count += _countNodesInTree(child);
    }
    return count;
  }

  bool _hasActiveFilters() {
    return !showMandatory || !showElective || approvalFilter != 'todos';
  }

  @override
  Widget build(BuildContext context) {
    if (originalTree == null) return const SizedBox.shrink();

    final totalCount = _countNodesInTree(originalTree);
    final filteredCount = _countNodesInTree(filteredTree);
    final hasFilters = _hasActiveFilters();

    if (!hasFilters) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: filteredCount == 0 ? Colors.orange.shade50 : Colors.blue.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color:
              filteredCount == 0
                  ? Colors.orange.shade200
                  : Colors.blue.shade200,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            filteredCount == 0 ? Icons.filter_alt_off : Icons.filter_alt,
            size: 16,
            color:
                filteredCount == 0
                    ? Colors.orange.shade700
                    : Colors.blue.shade700,
          ),
          const SizedBox(width: 6),
          Text(
            filteredCount == 0
                ? 'Sin resultados de $totalCount cursos'
                : 'Mostrando $filteredCount de $totalCount cursos',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color:
                  filteredCount == 0
                      ? Colors.orange.shade700
                      : Colors.blue.shade700,
            ),
          ),
        ],
      ),
    );
  }
}
