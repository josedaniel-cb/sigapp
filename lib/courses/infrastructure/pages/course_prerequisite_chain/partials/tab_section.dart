import 'package:flutter/material.dart';
import 'package:sigapp/courses/domain/entities/program_curriculum_course_term.dart';
import 'package:sigapp/courses/infrastructure/pages/course_prerequisite_chain/partials/flat.dart';
import 'package:sigapp/courses/infrastructure/pages/course_prerequisite_chain/partials/tree.dart';
import 'package:sigapp/courses/infrastructure/pages/course_prerequisite_chain/partials/filter_chips.dart';
import 'package:sigapp/courses/infrastructure/pages/course_prerequisite_chain/partials/approval_chips.dart';

class TabSectionWidget extends StatelessWidget {
  final CourseTreeNode? tree;
  final bool showMandatory;
  final bool showElective;
  final String approvalFilter;
  final ValueChanged<bool> onMandatoryChanged;
  final ValueChanged<bool> onElectiveChanged;
  final ValueChanged<String> onApprovalChanged;
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
    required this.isTreeView,
    required this.highlightCriticalPath,
    required this.criticalPathIds,
  });

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
                ),
                ApprovalChipsWidget(
                  approvalFilter: approvalFilter,
                  onApprovalChanged: onApprovalChanged,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Botón de ruta crítica eliminado, solo floating button
                  ],
                ),
              ],
            ),
          ),
        Expanded(
          child:
              isTreeView
                  ? TreeCourseChainWidget(
                    node: tree!,
                    highlightCriticalPath: highlightCriticalPath,
                    criticalPathIds: criticalPathIds,
                  )
                  : FlatCourseChainWidget(
                    root: tree,
                    showMandatory: showMandatory,
                    showElective: showElective,
                    approvalFilter: approvalFilter,
                    highlightCriticalPath: highlightCriticalPath,
                    criticalPathIds: criticalPathIds,
                  ),
        ),
      ],
    );
  }
}
