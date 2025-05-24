import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sigapp/courses/domain/entities/course_type.dart';
import 'package:sigapp/courses/domain/entities/program_curriculum_course_term.dart';
import 'package:sigapp/courses/infrastructure/pages/career/widgets/course_subtitle.dart';
import 'package:sigapp/courses/infrastructure/pages/course_prerequisite_chain/utils/shared_utils.dart'
    as shared_utils;
import 'package:sigapp/courses/infrastructure/pages/course_prerequisite_chain/utils/tree_utils.dart';

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
                _buildStudentSummary(context),
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

  Widget _buildStudentSummary(BuildContext context) {
    final stats = _calculateStudentStats();
    final theme = Theme.of(context);
    return shared_utils.buildStudentSummaryWidget(stats: stats, theme: theme);
  }

  shared_utils.StudentStats _calculateStudentStats() {
    return shared_utils.calculateStudentStats(node);
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
    final studentInfo = _getStudentCourseInfo(course, theme: theme);
    final backgroundColor = shared_utils.calculateCourseTileBackgroundColor(
      theme,
      studentInfo,
      depth: depth,
      isRoot: showRoot,
    );

    return Container(
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
        border:
            _shouldShowActionableBorder(studentInfo)
                ? Border.all(
                  color: studentInfo.statusColor.withValues(alpha: 0.4),
                  width: 1.5,
                )
                : null,
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 64,
        child: ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                course.info.courseCode,
                style: TextStyle(
                  color: theme.colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                course.info.courseName,
                style: TextStyle(
                  color: isCritical ? theme.colorScheme.primary : null,
                  fontWeight: isCritical ? FontWeight.bold : FontWeight.normal,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildStudentStatusBadge(course, theme: theme),
                const SizedBox(height: 8),
                _buildSubtitle(course),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChildren(BuildContext context) {
    if (node.children.isEmpty) return const SizedBox.shrink();

    final theme = Theme.of(context);
    final fontSize = theme.textTheme.bodyLarge?.fontSize ?? 16;
    final connectionMetrics = ConnectionMetrics(fontSize);
    final isParentCritical = _isNodeInCriticalPath(node.course.info.courseCode);
    final sortedChildren = _sortChildrenForStudentPriority(node.children);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
          sortedChildren.asMap().entries.map((entry) {
            final child = entry.value;
            final childIndex = entry.key;
            final isLast = childIndex == sortedChildren.length - 1;

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

  List<CourseTreeNode> _sortChildrenForStudentPriority(
    List<CourseTreeNode> children,
  ) {
    return sortChildrenForStudentPriority(children, _getStudentCourseInfo);
  }

  Widget _buildSingleChild(
    CourseTreeNode child,
    ConnectionMetrics metrics,
    ConnectionColors colors,
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

  Widget _buildVerticalToLine(ConnectionMetrics metrics, Color color) {
    return Positioned(
      top: 0,
      child: Container(
        color: color,
        width: metrics.thickness,
        height: metrics.verticalOffset,
      ),
    );
  }

  Widget _buildVerticalContinueLine(ConnectionMetrics metrics, Color color) {
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
    ConnectionMetrics metrics,
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

  Widget _buildStudentStatusBadge(
    ProgramCurriculumCourse course, {
    ThemeData? theme,
  }) {
    final studentInfo = _getStudentCourseInfo(course, theme: theme);
    return shared_utils.buildStudentStatusBadge(
      studentInfo,
      style: shared_utils.BadgeStyle.outlined,
    );
  }

  shared_utils.StudentCourseInfo _getStudentCourseInfo(
    ProgramCurriculumCourse course, {
    ThemeData? theme,
  }) {
    return shared_utils.getStudentCourseInfo(course, theme: theme);
  }

  bool _isNodeInCriticalPath(String courseCode) => shared_utils
      .isNodeInCriticalPath(courseCode, highlightCriticalPath, criticalPathIds);
  bool _hasSiblingInCriticalPath(int fromIndex) {
    return shared_utils.hasSiblingInCriticalPath(
      siblings: node.children,
      fromIndex: fromIndex,
      highlightCriticalPath: highlightCriticalPath,
      criticalPathIds: criticalPathIds,
    );
  }

  bool _shouldShowActionableBorder(shared_utils.StudentCourseInfo studentInfo) {
    return shared_utils.shouldShowActionableBorder(studentInfo);
  }

  ConnectionColors _calculateConnectionColors(
    CourseTreeNode child,
    int childIndex,
    bool isParentCritical,
    Color defaultColor,
  ) {
    final isChildCritical = _isNodeInCriticalPath(child.course.info.courseCode);
    final hasSiblingInPath = _hasSiblingInCriticalPath(childIndex + 1);

    final colors = calculateConnectionColors(
      isParentCritical: isParentCritical,
      isChildCritical: isChildCritical,
      hasSiblingInPath: hasSiblingInPath,
      defaultColor: defaultColor,
    );

    return ConnectionColors(
      verticalTo: colors.verticalTo,
      horizontal: colors.horizontal,
      verticalContinue: colors.verticalContinue,
    );
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
