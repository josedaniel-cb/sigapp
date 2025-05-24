import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sigapp/courses/domain/entities/course_type.dart';
import 'package:sigapp/courses/domain/entities/program_curriculum_course_term.dart';
import 'package:sigapp/courses/infrastructure/pages/career/widgets/course_subtitle.dart';

class _ConnectionMetrics {
  final double verticalOffset;
  final double horizontalWidth;
  final double thickness;

  _ConnectionMetrics(double fontSize)
    : verticalOffset = fontSize * 2.2,
      horizontalWidth = fontSize * 1,
      thickness = 2.0;
}

class _ConnectionColors {
  final Color verticalTo;
  final Color horizontal;
  final Color verticalContinue;

  const _ConnectionColors({
    required this.verticalTo,
    required this.horizontal,
    required this.verticalContinue,
  });
}

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
    return showRoot
        ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRootCourse(context),
            if (node.children.isNotEmpty) _buildChildren(context),
          ],
        )
        : _buildChildren(context);
  }

  Widget _buildRootCourse(BuildContext context) {
    final course = node.course;
    final theme = Theme.of(context);
    final isCritical = _isNodeInCriticalPath(course.info.courseCode);
    final backgroundColor = _calculateBackgroundColor(theme);

    return Container(
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 64,
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
          leading: _buildLeadingIcon(course, isCritical, theme),
          subtitle: _buildSubtitle(course),
        ),
      ),
    );
  }

  Widget _buildChildren(BuildContext context) {
    if (node.children.isEmpty) return const SizedBox.shrink();

    final theme = Theme.of(context);
    final fontSize = theme.textTheme.bodyLarge?.fontSize ?? 16;
    final connectionMetrics = _ConnectionMetrics(fontSize);
    final isParentCritical = _isNodeInCriticalPath(node.course.info.courseCode);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
          node.children.asMap().entries.map((entry) {
            final child = entry.value;
            final childIndex = entry.key;
            final isLast = childIndex == node.children.length - 1;

            final connectionColors = _calculateConnectionColors(
              child,
              childIndex,
              isParentCritical,
              theme.dividerColor,
            );

            return _buildSingleChild(
              child,
              connectionMetrics,
              connectionColors,
              isLast,
            );
          }).toList(),
    );
  }

  Widget _buildSingleChild(
    CourseTreeNode child,
    _ConnectionMetrics metrics,
    _ConnectionColors colors,
    bool isLast,
  ) {
    return Stack(
      children: [
        _buildVerticalToLine(metrics, colors.verticalTo),
        if (!isLast)
          _buildVerticalContinueLine(metrics, colors.verticalContinue),
        _buildHorizontalLineAndChild(child, metrics, colors.horizontal),
      ],
    );
  }

  Widget _buildVerticalToLine(_ConnectionMetrics metrics, Color color) {
    return Positioned(
      top: 0,
      child: Container(
        color: color,
        width: metrics.thickness,
        height: metrics.verticalOffset,
      ),
    );
  }

  Widget _buildVerticalContinueLine(_ConnectionMetrics metrics, Color color) {
    return Positioned(
      top: metrics.verticalOffset,
      bottom: 0,
      child: Container(
        color: color,
        width: metrics.thickness,
        height: double.infinity,
      ),
    );
  }

  Widget _buildHorizontalLineAndChild(
    CourseTreeNode child,
    _ConnectionMetrics metrics,
    Color connectionColor,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: metrics.verticalOffset),
          color: connectionColor,
          width: metrics.horizontalWidth,
          height: metrics.thickness,
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
    );
  }

  // Helper methods
  bool _isNodeInCriticalPath(String courseCode) {
    return highlightCriticalPath && criticalPathIds.contains(courseCode);
  }

  bool _hasSiblingInCriticalPath(int fromIndex) {
    return node.children
        .skip(fromIndex)
        .any(
          (sibling) => _isNodeInCriticalPath(sibling.course.info.courseCode),
        );
  }

  Color _calculateBackgroundColor(ThemeData theme) {
    if (depth == 0) return Colors.transparent;
    final double opacity = (0.06 * depth).clamp(0.0, 0.24);
    return theme.colorScheme.primary.withValues(alpha: opacity);
  }

  _ConnectionColors _calculateConnectionColors(
    CourseTreeNode child,
    int childIndex,
    bool isParentCritical,
    Color defaultColor,
  ) {
    final criticalColor = Colors.orange.withOpacity(0.8);
    final isChildCritical = _isNodeInCriticalPath(child.course.info.courseCode);
    final hasSiblingInPath = _hasSiblingInCriticalPath(childIndex + 1);

    return _ConnectionColors(
      verticalTo:
          isParentCritical && isChildCritical ? criticalColor : defaultColor,
      horizontal:
          isParentCritical && isChildCritical ? criticalColor : defaultColor,
      verticalContinue:
          isParentCritical && hasSiblingInPath ? criticalColor : defaultColor,
    );
  }

  Widget _buildLeadingIcon(
    ProgramCurriculumCourse course,
    bool isCritical,
    ThemeData theme,
  ) {
    if (course.isApproved == true) {
      return Icon(
        Icons.check,
        color: isCritical ? Colors.orange : Colors.green,
      );
    }
    if (course.isApproved == false) {
      return Icon(Icons.close, color: isCritical ? Colors.orange : Colors.red);
    }
    if (course.hasPrerequisitesApproved == true) {
      return Icon(
        Icons.lock_open_outlined,
        color: isCritical ? Colors.orange : theme.colorScheme.primary,
      );
    }
    return Icon(Icons.lock_outlined, color: isCritical ? Colors.orange : null);
  }

  Widget _buildSubtitle(ProgramCurriculumCourse course) {
    return CourseSubtitleWidget(
      children: [
        CourseSubtitleWidgetItem(
          text: 'Ciclo ${course.info.termRomanNumeral}',
          icon: Icons.book,
        ),
        course.info.courseType == CourseType.mandatory
            ? CourseSubtitleWidgetItem(text: 'Obligatorio', icon: Icons.school)
            : CourseSubtitleWidgetItem(text: 'Electivo', icon: MdiIcons.leaf),
        CourseSubtitleWidgetItem(
          text:
              course.info.credits == 1
                  ? '1 crédito'
                  : '${course.info.credits} créditos',
        ),
      ],
    );
  }
}
