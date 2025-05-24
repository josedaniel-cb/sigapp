import 'package:flutter/material.dart';
import 'package:sigapp/courses/domain/entities/program_curriculum_course_term.dart';

class StudentCourseInfo {
  final String actionMessage;
  final Color statusColor;
  final IconData icon;
  final bool isAvailableNow;

  const StudentCourseInfo({
    required this.actionMessage,
    required this.statusColor,
    required this.icon,
    required this.isAvailableNow,
  });
}

class StudentStats {
  final int availableNew;
  final int completed;
  final int needsRetake;
  final int blocked;

  StudentStats({
    required this.availableNew,
    required this.completed,
    required this.needsRetake,
    required this.blocked,
  });

  int get availableNow => availableNew + needsRetake;
}

StudentCourseInfo getStudentCourseInfo(
  ProgramCurriculumCourse course, {
  ThemeData? theme,
}) {
  final primaryColor = theme?.colorScheme.primary ?? const Color(0xFF1565C0);
  if (course.isApproved == true) {
    return const StudentCourseInfo(
      actionMessage: "Completado",
      statusColor: Color(0xFF2E7D32),
      icon: Icons.check,
      isAvailableNow: false,
    );
  }

  if (course.isApproved == false) {
    return const StudentCourseInfo(
      actionMessage: "Repetir curso",
      statusColor: Color(0xFFD32F2F),
      icon: Icons.refresh,
      isAvailableNow: true,
    );
  }

  if (course.hasPrerequisitesApproved == true) {
    return StudentCourseInfo(
      actionMessage: "Desbloqueado",
      statusColor: primaryColor,
      icon: Icons.lock_open,
      isAvailableNow: true,
    );
  }

  if (course.prerequisites.isNotEmpty) {
    final pendingCount =
        course.prerequisites
            .where((prereq) => prereq.isApproved != true)
            .length;

    const blockedColor = Color(0xFFE65100);
    if (pendingCount == 1) {
      return const StudentCourseInfo(
        actionMessage: "1 prerrequisito pendiente",
        statusColor: blockedColor,
        icon: Icons.lock,
        isAvailableNow: false,
      );
    } else {
      return StudentCourseInfo(
        actionMessage: "$pendingCount prerrequisitos pendientes",
        statusColor: blockedColor,
        icon: Icons.lock,
        isAvailableNow: false,
      );
    }
  }

  return StudentCourseInfo(
    actionMessage: "Desbloqueado",
    statusColor: primaryColor,
    icon: Icons.lock_open,
    isAvailableNow: true,
  );
}

Map<String, dynamic> buildStudentSummaryInfo(
  StudentStats stats,
  ThemeData theme,
) {
  String message;
  IconData icon;
  Color color;

  if (stats.availableNow == 0 &&
      stats.completed == 0 &&
      stats.needsRetake == 0 &&
      stats.blocked == 0) {
    return {"showSummary": false};
  }

  if (stats.needsRetake > 0) {
    message =
        "${stats.needsRetake} curso${stats.needsRetake == 1 ? '' : 's'} para repetir";
    icon = Icons.refresh;
    color = Colors.orange;
  } else if (stats.completed > 0 && stats.blocked > 0) {
    message = "Revisa los prerrequisitos para planificar tu siguiente semestre";
    icon = Icons.schedule;
    color = theme.colorScheme.primary;
  } else if (stats.completed > 0) {
    message = "Has completado todos los cursos de esta cadena";
    icon = Icons.check;
    color = Colors.green;
  } else if (stats.blocked > 0) {
    message = "Completa los prerrequisitos para desbloquear estos cursos";
    icon = Icons.lock;
    color = Colors.grey;
  } else {
    return {"showSummary": false};
  }

  return {
    "showSummary": true,
    "message": message,
    "icon": icon,
    "color": color,
  };
}

StudentStats calculateStudentStats(CourseTreeNode rootNode) {
  int availableNew = 0;
  int completed = 0;
  int needsRetake = 0;
  int blocked = 0;

  void countRecursive(CourseTreeNode currentNode) {
    final course = currentNode.course;

    if (course.isApproved == true) {
      completed++;
    } else if (course.isApproved == false) {
      needsRetake++;
    } else if (course.hasPrerequisitesApproved == true ||
        course.prerequisites.isEmpty) {
      availableNew++;
    } else {
      blocked++;
    }

    for (final child in currentNode.children) {
      countRecursive(child);
    }
  }

  countRecursive(rootNode);

  return StudentStats(
    availableNew: availableNew,
    completed: completed,
    needsRetake: needsRetake,
    blocked: blocked,
  );
}

bool shouldShowActionableBorder(StudentCourseInfo studentInfo) {
  return studentInfo.isAvailableNow &&
      !studentInfo.actionMessage.contains("Completado");
}

enum BadgeStyle { outlined, filled }

Widget buildStudentStatusBadge(
  StudentCourseInfo studentInfo, {
  BadgeStyle style = BadgeStyle.outlined,
  bool compactVersion = false,
}) {
  final bool isOutlined = style == BadgeStyle.outlined;
  final Color bgColor =
      isOutlined
          ? studentInfo.statusColor.withValues(alpha: 0.12)
          : studentInfo.statusColor;
  final Color textColor = isOutlined ? studentInfo.statusColor : Colors.white;

  return Container(
    padding: EdgeInsets.symmetric(
      horizontal: compactVersion ? 6 : 8,
      vertical: compactVersion ? 2 : 4,
    ),
    decoration: BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(isOutlined ? 12 : 10),
      border:
          isOutlined
              ? Border.all(
                color: studentInfo.statusColor.withValues(alpha: 0.3),
                width: 1,
              )
              : null,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          studentInfo.icon,
          color: textColor,
          size: compactVersion ? 12 : 14,
        ),
        SizedBox(width: compactVersion ? 4 : 6),
        Text(
          _getBadgeText(studentInfo, compactVersion),
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w600,
            fontSize: compactVersion ? 10 : 12,
          ),
        ),
      ],
    ),
  );
}

String _getBadgeText(StudentCourseInfo info, bool compact) {
  if (compact) {
    return info.isAvailableNow
        ? (info.actionMessage.contains("Repetir") ? "REPETIR" : "DESBLOQUEADO")
        : info.actionMessage.contains("Completado")
        ? "APROBADO"
        : info.actionMessage;
  }
  return info.actionMessage;
}

Widget buildStudentSummaryWidget({
  required StudentStats stats,
  required ThemeData theme,
  EdgeInsets margin = const EdgeInsets.only(bottom: 12),
}) {
  final summaryInfo = buildStudentSummaryInfo(stats, theme);

  if (summaryInfo["showSummary"] == false) {
    return const SizedBox.shrink();
  }

  final message = summaryInfo["message"] as String;
  final icon = summaryInfo["icon"] as IconData;
  final color = summaryInfo["color"] as Color;

  return Container(
    margin: margin,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 2),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            message,
            style: TextStyle(
              color: theme.colorScheme.onSurface,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
            maxLines: null,
            overflow: TextOverflow.visible,
            softWrap: true,
          ),
        ),
      ],
    ),
  );
}

Color calculateCourseTileBackgroundColor(
  ThemeData theme,
  StudentCourseInfo studentInfo, {
  bool isRoot = false,
  int depth = 0,
}) {
  if (studentInfo.isAvailableNow) {
    final statusTint = studentInfo.statusColor.withValues(alpha: 0.05);
    return statusTint;
  } else if (studentInfo.actionMessage.contains("Completado")) {
    final statusTint = studentInfo.statusColor.withValues(alpha: 0.03);
    return statusTint;
  } else {
    // Para bloqueados y cualquier otro estado, usar el statusColor con opacidad
    final statusTint = studentInfo.statusColor.withValues(alpha: 0.07);
    return statusTint;
  }
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
  if (!highlightCriticalPath) return false;
  for (int i = fromIndex; i < siblings.length; i++) {
    if (criticalPathIds.contains(siblings[i].course.info.courseCode)) {
      return true;
    }
  }
  return false;
}

List<CourseTreeNode> sortNodesByStudentPriority(
  List<CourseTreeNode> nodes, [
  StudentCourseInfo Function(ProgramCurriculumCourse)? getInfoFunc,
]) {
  final getInfo = getInfoFunc ?? getStudentCourseInfo;
  return List<CourseTreeNode>.from(nodes)..sort((a, b) {
    final infoA = getInfo(a.course);
    final infoB = getInfo(b.course);
    if (infoA.isAvailableNow && !infoB.isAvailableNow) return -1;
    if (!infoA.isAvailableNow && infoB.isAvailableNow) return 1;
    final aCompleted = infoA.actionMessage.contains("Completado");
    final bCompleted = infoB.actionMessage.contains("Completado");
    if (aCompleted && !bCompleted) return 1;
    if (!aCompleted && bCompleted) return -1;
    return a.course.info.courseCode.compareTo(b.course.info.courseCode);
  });
}
