import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sigapp/courses/domain/entities/course_type.dart';
import 'package:sigapp/courses/domain/entities/program_curriculum_course_term.dart';
import 'package:sigapp/courses/infrastructure/pages/career/widgets/course_subtitle.dart';

class FlatCourseChain extends StatelessWidget {
  const FlatCourseChain({
    super.key,
    required this.root,
    required this.showMandatory,
    required this.showElective,
    required this.approvalFilter,
    required this.highlightCriticalPath,
    required this.criticalPathIds,
  });

  final CourseTreeNode? root;
  final bool showMandatory;
  final bool showElective;
  final String approvalFilter;
  final bool highlightCriticalPath;
  final Set<String> criticalPathIds;

  @override
  Widget build(BuildContext context) {
    List<CourseTreeNode> flatList = [];
    void flatten(CourseTreeNode? node) {
      if (node == null) return;
      flatList.add(node);
      for (final child in node.children) {
        flatten(child);
      }
    }

    if (root != null) {
      flatten(root);
      // Aplicar filtros
      flatList =
          flatList.where((node) {
            final typeOk =
                (node.course.info.courseType == CourseType.mandatory &&
                    showMandatory) ||
                (node.course.info.courseType == CourseType.elective &&
                    showElective);
            final approvalOk =
                approvalFilter == 'todos' ||
                (approvalFilter == 'aprobado' &&
                    node.course.isApproved == true) ||
                (approvalFilter == 'no_aprobado' &&
                    node.course.isApproved == false);
            return typeOk && approvalOk;
          }).toList();
    }
    if (root == null) {
      return Center(child: Text('No hay cursos relacionados'));
    }
    if (flatList.isEmpty) {
      return Center(child: Text('No hay cursos que coincidan con los filtros'));
    }
    // Agrupar por ciclo
    Map<String, List<CourseTreeNode>> grouped = {};
    for (final node in flatList) {
      final ciclo = node.course.info.termRomanNumeral;
      grouped.putIfAbsent(ciclo, () => []).add(node);
    }
    final sortedKeys = grouped.keys.toList()..sort((a, b) => a.compareTo(b));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: sortedKeys.length,
            itemBuilder: (context, idx) {
              final ciclo = sortedKeys[idx];
              final nodes = grouped[ciclo]!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _CycleHeader(ciclo: ciclo, count: nodes.length),
                  ...nodes.map(
                    (node) => _FlatCourseTile(
                      node: node,
                      highlightCriticalPath: highlightCriticalPath,
                      criticalPathIds: criticalPathIds,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

// Widget para el encabezado de ciclo en la lista plana
class _CycleHeader extends StatelessWidget {
  final String ciclo;
  final int count;
  const _CycleHeader({required this.ciclo, required this.count});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      color: theme.colorScheme.surfaceVariant,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Icon(Icons.book, size: 18, color: theme.colorScheme.primary),
          const SizedBox(width: 8),
          Text(
            'Ciclo $ciclo',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '($count ${count == 1 ? 'curso' : 'cursos'})',
            style: TextStyle(
              fontSize: 12,
              color: theme.colorScheme.onSurfaceVariant.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }
}

// Widget para un curso en la lista plana
class _FlatCourseTile extends StatelessWidget {
  final CourseTreeNode node;
  final bool highlightCriticalPath;
  final Set<String> criticalPathIds;
  const _FlatCourseTile({
    required this.node,
    required this.highlightCriticalPath,
    required this.criticalPathIds,
  });
  @override
  Widget build(BuildContext context) {
    final course = node.course;
    final theme = Theme.of(context);
    final isCritical =
        highlightCriticalPath &&
        criticalPathIds.contains(course.info.courseCode);
    return ListTile(
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      leading:
          (() {
            if (course.isApproved == true) {
              return Icon(
                Icons.check,
                color: isCritical ? Colors.orange : Colors.green,
              );
            }
            if (course.isApproved == false) {
              return Icon(
                Icons.close,
                color: isCritical ? Colors.orange : Colors.red,
              );
            }
            if (course.hasPrerequisitesApproved == true) {
              return Icon(
                Icons.lock_open_outlined,
                color: isCritical ? Colors.orange : theme.colorScheme.primary,
              );
            }
            return Icon(
              Icons.lock_outlined,
              color: isCritical ? Colors.orange : null,
            );
          })(),
      title: Text(
        course.info.courseName,
        style:
            isCritical
                ? theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                )
                : theme.textTheme.bodyLarge,
      ),
      subtitle: CourseSubtitleWidget(
        children: [
          course.info.courseType == CourseType.mandatory
              ? CourseSubtitleWidgetItem(
                text: 'Obligatorio',
                icon: Icons.school,
              )
              : CourseSubtitleWidgetItem(text: 'Electivo', icon: MdiIcons.leaf),
          CourseSubtitleWidgetItem(
            text:
                course.info.credits == 1
                    ? '1 crédito'
                    : '${course.info.credits} créditos',
          ),
        ],
      ),
      trailing:
          isCritical
              ? Tooltip(
                message: 'En ruta crítica',
                child: Icon(Icons.alt_route, color: Colors.orange, size: 20),
              )
              : null,
    );
  }
}
