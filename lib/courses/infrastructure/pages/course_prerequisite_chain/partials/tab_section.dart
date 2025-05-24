import 'package:flutter/material.dart';
import 'package:sigapp/courses/domain/entities/course_type.dart';
import 'package:sigapp/courses/domain/entities/program_curriculum_course_term.dart';
import 'package:sigapp/courses/infrastructure/pages/course_prerequisite_chain/partials/flat.dart';
import 'package:sigapp/courses/infrastructure/pages/course_prerequisite_chain/partials/tree.dart';
import 'package:sigapp/courses/infrastructure/pages/course_prerequisite_chain/partials/filter_chips.dart';
import 'package:sigapp/courses/infrastructure/pages/course_prerequisite_chain/partials/approval_chips.dart';
import 'package:sigapp/courses/infrastructure/pages/course_prerequisite_chain/partials/filter_results_counter.dart';
import 'package:sigapp/courses/infrastructure/pages/course_prerequisite_chain/partials/filter_reset_button.dart';

class TabSectionWidget extends StatelessWidget {
  final CourseTreeNode? tree;
  final bool showMandatory;
  final bool showElective;
  final String approvalFilter;
  final ValueChanged<bool> onMandatoryChanged;
  final ValueChanged<bool> onElectiveChanged;
  final ValueChanged<String> onApprovalChanged;
  final VoidCallback onResetFilters;
  final bool isTreeView;
  final bool highlightCriticalPath;
  final Set<String> criticalPathIds;

  const TabSectionWidget({
    super.key,
    required this.tree,
    required this.showMandatory,
    required this.showElective,
    required this.approvalFilter,
    required this.onMandatoryChanged,
    required this.onElectiveChanged,
    required this.onApprovalChanged,
    required this.onResetFilters,
    required this.isTreeView,
    required this.highlightCriticalPath,
    required this.criticalPathIds,
  });

  CourseTreeNode? _filterTree(
    CourseTreeNode node,
    bool showMandatory,
    bool showElective,
    String approvalFilter,
  ) {
    // Filtra recursivamente los nodos según los filtros activos
    bool matchesType =
        (node.course.info.courseType == CourseType.mandatory &&
            showMandatory) ||
        (node.course.info.courseType == CourseType.elective && showElective);
    bool matchesApproval =
        approvalFilter == 'todos' ||
        (approvalFilter == 'aprobado' && node.course.isApproved == true) ||
        (approvalFilter == 'no_aprobado' && node.course.isApproved == false);
    final filteredChildren =
        node.children
            .map(
              (child) => _filterTree(
                child,
                showMandatory,
                showElective,
                approvalFilter,
              ),
            )
            .whereType<CourseTreeNode>()
            .toList();
    if (matchesType && matchesApproval) {
      return CourseTreeNode(course: node.course, children: filteredChildren);
    } else if (filteredChildren.isNotEmpty) {
      // Si el nodo no cumple pero tiene hijos que sí, lo mostramos como rama
      return CourseTreeNode(course: node.course, children: filteredChildren);
    } else {
      // Si ni el nodo ni los hijos cumplen, lo excluimos
      return null;
    }
  }

  Widget _buildContent() {
    if (tree == null) {
      return const Center(
        child: Text('No hay cursos relacionados', textAlign: TextAlign.center),
      );
    }

    if (!showMandatory && !showElective) {
      return const Center(
        child: Text(
          'Activa al menos un tipo de curso para ver resultados',
          textAlign: TextAlign.center,
        ),
      );
    }

    final noFilters =
        showMandatory && showElective && approvalFilter == 'todos';
    final filtered =
        noFilters
            ? tree
            : _filterTree(tree!, showMandatory, showElective, approvalFilter);

    if (filtered == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.filter_alt_off, size: 48, color: Colors.orange.shade400),
            const SizedBox(height: 16),
            const Text(
              'No hay cursos que coincidan con los filtros',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            const Text(
              'Intenta activar más tipos de curso o cambiar el filtro de aprobación.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            FilterResetButton(
              showMandatory: showMandatory,
              showElective: showElective,
              approvalFilter: approvalFilter,
              onReset: onResetFilters,
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        FilterResultsCounter(
          originalTree: tree,
          filteredTree: filtered,
          showMandatory: showMandatory,
          showElective: showElective,
          approvalFilter: approvalFilter,
        ),
        Expanded(
          child:
              isTreeView
                  ? TreeCourseChainWidget(
                    node: filtered,
                    highlightCriticalPath: highlightCriticalPath,
                    criticalPathIds: criticalPathIds,
                  )
                  : FlatCourseChainWidget(
                    root: filtered,
                    highlightCriticalPath: highlightCriticalPath,
                    criticalPathIds: criticalPathIds,
                  ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool showFilters = tree != null && tree!.children.isNotEmpty;
    return Column(
      children: [
        if (showFilters)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FilterChipsWidget(
                  showMandatory: showMandatory,
                  showElective: showElective,
                  onMandatoryChanged: onMandatoryChanged,
                  onElectiveChanged: onElectiveChanged,
                  tree: tree,
                ),
                const SizedBox(height: 8),
                ApprovalChipsWidget(
                  approvalFilter: approvalFilter,
                  onApprovalChanged: onApprovalChanged,
                  tree: tree,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FilterResetButton(
                      showMandatory: showMandatory,
                      showElective: showElective,
                      approvalFilter: approvalFilter,
                      onReset: onResetFilters,
                    ),
                  ],
                ),
              ],
            ),
          ),
        Expanded(child: _buildContent()),
      ],
    );
  }
}
