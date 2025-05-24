import 'package:flutter/material.dart';
import 'package:sigapp/courses/domain/entities/program_curriculum_course_term.dart';
import 'package:sigapp/courses/infrastructure/pages/course_prerequisite_chain/utils/shared_utils.dart';

class ConnectionMetrics {
  final double verticalOffset;
  final double horizontalWidth;
  final double thickness;

  ConnectionMetrics(double fontSize)
    : verticalOffset = fontSize * 2.2,
      horizontalWidth = fontSize,
      thickness = 2.0;
}

class ConnectionColors {
  final Color verticalTo;
  final Color horizontal;
  final Color verticalContinue;

  const ConnectionColors({
    required this.verticalTo,
    required this.horizontal,
    required this.verticalContinue,
  });
}

bool isNodeInCriticalPath(
  String courseCode,
  bool highlightCriticalPath,
  Set<String> criticalPathIds,
) {
  return highlightCriticalPath && criticalPathIds.contains(courseCode);
}

bool hasSiblingInCriticalPath({
  required List<CourseTreeNode> siblings,
  required int fromIndex,
  required bool highlightCriticalPath,
  required Set<String> criticalPathIds,
}) {
  return siblings
      .skip(fromIndex)
      .any(
        (sibling) => isNodeInCriticalPath(
          sibling.course.info.courseCode,
          highlightCriticalPath,
          criticalPathIds,
        ),
      );
}

ConnectionColors calculateConnectionColors({
  required bool isParentCritical,
  required bool isChildCritical,
  required bool hasSiblingInPath,
  required Color defaultColor,
}) {
  const criticalColor = Colors.orange;

  final useCriticalColor = isParentCritical && isChildCritical;
  final connectionColor =
      useCriticalColor ? criticalColor.withValues(alpha: 0.8) : defaultColor;

  final continueColor =
      isParentCritical && hasSiblingInPath
          ? criticalColor.withValues(alpha: 0.8)
          : defaultColor;

  return ConnectionColors(
    verticalTo: connectionColor,
    horizontal: connectionColor,
    verticalContinue: continueColor,
  );
}

Color calculateBackgroundColor(
  ThemeData theme,
  StudentCourseInfo studentInfo,
  int depth,
) {
  if (depth == 0) return Colors.transparent;

  final baseOpacity = (0.06 * depth).clamp(0.0, 0.24);
  final baseColor = theme.colorScheme.primary.withValues(alpha: baseOpacity);

  if (studentInfo.isAvailableNow &&
      !studentInfo.actionMessage.contains("Completado")) {
    return Color.lerp(
          baseColor,
          studentInfo.statusColor.withValues(alpha: 0.06),
          0.3,
        ) ??
        baseColor;
  }

  if (studentInfo.actionMessage.contains("Completado")) {
    return Color.lerp(baseColor, Colors.green.withValues(alpha: 0.04), 0.2) ??
        baseColor;
  }

  return baseColor;
}

List<CourseTreeNode> sortChildrenForStudentPriority(
  List<CourseTreeNode> children,
  StudentCourseInfo Function(ProgramCurriculumCourse) getStudentCourseInfo,
) {
  return List.from(children)..sort((a, b) {
    final aInfo = getStudentCourseInfo(a.course);
    final bInfo = getStudentCourseInfo(b.course);

    int getPriority(StudentCourseInfo info) {
      if (info.isAvailableNow && !info.actionMessage.contains("Completado")) {
        if (info.actionMessage.contains("Repetir")) return 2;
        return 1;
      }
      if (info.actionMessage.contains("Completado")) return 3;
      return 4;
    }

    return getPriority(aInfo).compareTo(getPriority(bInfo));
  });
}
