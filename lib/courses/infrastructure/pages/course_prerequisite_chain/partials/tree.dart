import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sigapp/courses/domain/entities/course_type.dart';
import 'package:sigapp/courses/domain/entities/program_curriculum_course_term.dart';
import 'package:sigapp/courses/infrastructure/pages/career/widgets/course_subtitle.dart';

class TreeCourseChainWidget extends StatelessWidget {
  final CourseTreeNode node;
  final bool highlightCriticalPath;
  final Set<String> criticalPathIds;

  const TreeCourseChainWidget({
    super.key,
    required this.node,
    required this.highlightCriticalPath,
    required this.criticalPathIds,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 1.1,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16, left: 8, right: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _CourseTreeItem(
                  node: node,
                  showRoot: true,
                  highlightCriticalPath: highlightCriticalPath,
                  criticalPathIds: criticalPathIds,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CourseTreeItem extends StatelessWidget {
  final CourseTreeNode node;
  final bool showRoot;
  final bool highlightCriticalPath;
  final Set<String> criticalPathIds;
  final int depth;
  const _CourseTreeItem({
    required this.node,
    this.showRoot = true,
    required this.highlightCriticalPath,
    required this.criticalPathIds,
    this.depth = 0,
  });
  @override
  Widget build(BuildContext context) {
    final course = node.course;
    final theme = Theme.of(context);
    final isCritical =
        highlightCriticalPath &&
        criticalPathIds.contains(course.info.courseCode);

    // Calcular color de fondo según depth
    Color backgroundColor;
    if (depth == 0) {
      backgroundColor = Colors.transparent;
    } else {
      // Opacidad incremental, máximo 0.24
      final double opacity = (0.06 * depth).clamp(0.0, 0.24);
      backgroundColor = theme.colorScheme.primary.withValues(alpha: opacity);
    }

    Widget buildRoot() {
      return Container(
        margin: const EdgeInsets.only(top: 8),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: SizedBox(
          width: MediaQuery.of(context).size.width - 8 * 8,
          child: ListTile(
            title: Text(
              course.info.courseName,
              style:
                  isCritical
                      ? TextStyle(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      )
                      : null,
            ),
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
                      color:
                          isCritical
                              ? Colors.orange
                              : theme.colorScheme.primary,
                    );
                  }
                  return Icon(
                    Icons.lock_outlined,
                    color: isCritical ? Colors.orange : null,
                  );
                })(),
            subtitle: CourseSubtitleWidget(
              children: [
                CourseSubtitleWidgetItem(
                  text: 'Ciclo ${course.info.termRomanNumeral}',
                  icon: Icons.book,
                ),
                course.info.courseType == CourseType.mandatory
                    ? CourseSubtitleWidgetItem(
                      text: 'Obligatorio',
                      icon: Icons.school,
                    )
                    : CourseSubtitleWidgetItem(
                      text: 'Electivo',
                      icon: MdiIcons.leaf,
                    ),
                CourseSubtitleWidgetItem(
                  text:
                      course.info.credits == 1
                          ? '1 crédito'
                          : '${course.info.credits} créditos',
                ),
              ],
            ),
          ),
        ),
      );
    }

    Widget buildChildren() {
      final dividerColor = theme.dividerColor;
      final fontSize = theme.textTheme.bodyLarge?.fontSize ?? 0;
      final top = fontSize * 2.2;
      final width = fontSize * 1;
      final thickness = 2.0;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
            node.children.asMap().entries.map((entry) {
              final child = entry.value;
              final isLast = entry.key == node.children.length - 1;
              return Stack(
                children: [
                  Positioned(
                    top: 0,
                    child: Container(
                      color: dividerColor,
                      width: thickness,
                      height: top,
                    ),
                  ),
                  if (!isLast)
                    Positioned(
                      top: top,
                      bottom: 0,
                      child: Container(
                        color: dividerColor,
                        width: thickness,
                        height: double.infinity,
                      ),
                    ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: top),
                        color: dividerColor,
                        width: width,
                        height: thickness,
                      ),
                      Expanded(
                        child: _CourseTreeItem(
                          node: child,
                          highlightCriticalPath: highlightCriticalPath,
                          criticalPathIds: criticalPathIds,
                          depth: depth + 1,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }).toList(),
      );
    }

    return showRoot
        ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildRoot(),
            if (node.children.isNotEmpty) buildChildren(),
          ],
        )
        : buildChildren();
  }
}
