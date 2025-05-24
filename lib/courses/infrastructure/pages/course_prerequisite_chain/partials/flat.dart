import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sigapp/courses/domain/entities/course_type.dart';
import 'package:sigapp/courses/domain/entities/program_curriculum_course_term.dart';
import 'package:sigapp/courses/infrastructure/pages/career/widgets/course_subtitle.dart';
import 'package:sigapp/courses/infrastructure/pages/course_prerequisite_chain/utils/shared_utils.dart';
import 'package:sigapp/courses/infrastructure/pages/course_prerequisite_chain/utils/flat_utils.dart';

class FlatCourseChainWidget extends StatelessWidget {
  const FlatCourseChainWidget({
    super.key,
    required this.root,
    required this.highlightCriticalPath,
    required this.criticalPathIds,
  });
  final CourseTreeNode? root;
  final bool highlightCriticalPath;
  final Set<String> criticalPathIds;

  @override
  Widget build(BuildContext context) {
    List<CourseTreeNode> flatList = flattenCourseTree(root);

    if (root == null) {
      return Center(child: Text('No hay cursos relacionados'));
    }
    if (flatList.isEmpty) {
      return Center(child: Text('No hay cursos que coincidan con los filtros'));
    }
    final grouped = groupNodesByCycle(flatList);
    final sortedKeys = grouped.keys.toList()..sort((a, b) => b.compareTo(a));

    return ListView.builder(
      itemCount: sortedKeys.length + 1,
      itemBuilder: (context, idx) {
        if (idx == 0) {
          final stats = calculateFlatStudentStats(flatList);
          final theme = Theme.of(context);
          return buildStudentSummaryWidget(
            stats: stats,
            theme: theme,
            margin: const EdgeInsets.all(16),
          );
        }
        final ciclo = sortedKeys[idx - 1];
        final nodes = grouped[ciclo]!;
        final sortedNodes = sortNodesByStudentPriority(nodes);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _CycleHeader(ciclo: ciclo, count: nodes.length, nodes: nodes),
            ...sortedNodes.map(
              (node) => _FlatCourseTile(
                node: node,
                highlightCriticalPath: highlightCriticalPath,
                criticalPathIds: criticalPathIds,
                isRoot:
                    root != null &&
                    node.course.info.courseCode == root!.course.info.courseCode,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _CycleHeader extends StatelessWidget {
  final String ciclo;
  final int count;
  final List<CourseTreeNode> nodes;

  const _CycleHeader({
    required this.ciclo,
    required this.count,
    required this.nodes,
  });
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final stats = calculateCycleStats(nodes);

    return Container(
      color: theme.colorScheme.surfaceContainerHighest,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Icon(Icons.book, size: 18, color: theme.colorScheme.primary),
          const SizedBox(width: 8),
          Text(
            'Ciclo $ciclo',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurfaceVariant,
              fontSize: 16,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '($count ${count == 1 ? 'curso' : 'cursos'})',
            style: TextStyle(
              fontSize: 12,
              color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
            ),
          ),
          const Spacer(),
          _buildCycleStatsChips(stats, theme),
        ],
      ),
    );
  }
}

class _FlatCourseTile extends StatelessWidget {
  final CourseTreeNode node;
  final bool highlightCriticalPath;
  final Set<String> criticalPathIds;
  final bool isRoot;
  const _FlatCourseTile({
    required this.node,
    required this.highlightCriticalPath,
    required this.criticalPathIds,
    this.isRoot = false,
  });
  @override
  Widget build(BuildContext context) {
    final course = node.course;
    final theme = Theme.of(context);
    final isCritical =
        highlightCriticalPath &&
        criticalPathIds.contains(course.info.courseCode);

    final studentInfo = getStudentCourseInfo(course, theme: theme);

    return ListTile(
      dense: true,
      tileColor: calculateCourseTileBackgroundColor(
        Theme.of(context),
        studentInfo,
        isRoot: isRoot,
      ),
      leading: _buildLeadingCourseIcon(course, studentInfo, isCritical, theme),
      title: Row(
        children: [
          Expanded(
            child: Text(
              course.info.courseName,
              style:
                  isCritical
                      ? theme.textTheme.titleMedium?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      )
                      : theme.textTheme.bodyLarge,
            ),
          ),
          _buildStudentStatusBadge(studentInfo, context),
        ],
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
              : (shouldShowActionableBorder(studentInfo) &&
                  !studentInfo.isAvailableNow)
              ? Icon(studentInfo.icon, color: studentInfo.statusColor, size: 20)
              : null,
    );
  }
}

Widget _buildStatChip(String count, String label, Color color, IconData icon) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withValues(alpha: 0.3), width: 1),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 12),
        const SizedBox(width: 3),
        Text(
          count,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 11,
          ),
        ),
        const SizedBox(width: 2),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 10,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}

Widget _buildCycleStatsChips(StudentStats stats, ThemeData theme) {
  final chips = <Widget>[];

  if (stats.needsRetake > 0) {
    chips.add(
      _buildStatChip(
        "${stats.needsRetake}",
        "para repetir",
        Colors.orange,
        Icons.refresh,
      ),
    );
  }

  if (stats.completed > 0) {
    chips.add(
      _buildStatChip(
        "${stats.completed}",
        "completados",
        const Color(0xFF2E7D32),
        Icons.check_circle,
      ),
    );
  }

  if (stats.blocked > 0 && stats.availableNow == 0) {
    chips.add(
      _buildStatChip(
        "${stats.blocked}",
        "bloqueados",
        const Color(0xFFE65100),
        Icons.lock,
      ),
    );
  }

  return Row(
    mainAxisSize: MainAxisSize.min,
    children:
        chips
            .map(
              (chip) =>
                  Padding(padding: const EdgeInsets.only(left: 4), child: chip),
            )
            .toList(),
  );
}

Widget _buildStudentStatusBadge(
  StudentCourseInfo studentInfo,
  BuildContext context,
) {
  return const SizedBox.shrink();
}

Widget _buildLeadingCourseIcon(
  ProgramCurriculumCourse course,
  StudentCourseInfo studentInfo,
  bool isCritical,
  ThemeData theme,
) {
  Color iconColor = isCritical ? Colors.orange : studentInfo.statusColor;
  IconData iconData;
  if (studentInfo.isAvailableNow) {
    iconData = Icons.lock_open;
  } else {
    iconData = studentInfo.icon;
  }
  return Icon(iconData, color: iconColor, size: 24);
}
