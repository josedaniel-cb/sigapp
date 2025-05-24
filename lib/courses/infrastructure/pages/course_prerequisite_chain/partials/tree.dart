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
      horizontalWidth = fontSize,
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

// Status information for student-focused UX
class _StudentCourseInfo {
  final String actionMessage;
  final Color statusColor;
  final IconData icon;
  final bool isAvailableNow;

  const _StudentCourseInfo({
    required this.actionMessage,
    required this.statusColor,
    required this.icon,
    required this.isAvailableNow,
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

    // Don't show summary if there are no courses at all
    if (stats.availableNow == 0 &&
        stats.completed == 0 &&
        stats.needsRetake == 0 &&
        stats.blocked == 0) {
      return const SizedBox.shrink();
    }

    final theme = Theme.of(context);
    String message;
    IconData icon;
    Color color;

    // Priority: Show most actionable information first
    if (stats.availableNew > 0 && stats.needsRetake > 0) {
      // Mixed: both new courses and retakes available
      message =
          "${stats.availableNew + stats.needsRetake} cursos disponibles (${stats.availableNew} nuevos, ${stats.needsRetake} para repetir)";
      icon = Icons.info;
      color = theme.colorScheme.primary;
    } else if (stats.availableNew > 0) {
      // Only new courses available
      message =
          "${stats.availableNew} curso${stats.availableNew == 1 ? '' : 's'} disponible${stats.availableNew == 1 ? '' : 's'} para tomar";
      icon = Icons.school;
      color = Colors.green;
    } else if (stats.needsRetake > 0) {
      // Only retakes available
      message =
          "${stats.needsRetake} curso${stats.needsRetake == 1 ? '' : 's'} para repetir";
      icon = Icons.refresh;
      color = Colors.orange;
    } else if (stats.completed > 0 && stats.blocked > 0) {
      // Has completed courses but some are blocked
      message =
          "Revisa los prerrequisitos para planificar tu siguiente semestre";
      icon = Icons.schedule;
      color = theme.colorScheme.primary;
    } else if (stats.completed > 0) {
      // All courses completed (rare case in a prerequisite chain)
      message = "Has completado todos los cursos de esta cadena";
      icon = Icons.check_circle;
      color = Colors.green;
    } else if (stats.blocked > 0) {
      // Only blocked courses (student needs to complete prerequisites)
      message = "Completa los prerrequisitos para desbloquear estos cursos";
      icon = Icons.lock;
      color = Colors.grey;
    } else {
      // Fallback (shouldn't happen)
      return const SizedBox.shrink();
    }
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start, // Align icon to top for multiline
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 2,
            ), // Small adjustment for visual alignment
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
              maxLines: null, // Allow unlimited lines
              overflow: TextOverflow.visible, // Show full text
              softWrap: true, // Enable text wrapping
            ),
          ),
        ],
      ),
    );
  }

  _StudentStats _calculateStudentStats() {
    int availableNew = 0; // New courses that can be taken
    int completed = 0;
    int needsRetake = 0; // Failed courses that can be retaken
    int blocked = 0; // Courses blocked by prerequisites

    void countRecursive(CourseTreeNode currentNode) {
      final course = currentNode.course;

      if (course.isApproved == true) {
        completed++;
      } else if (course.isApproved == false) {
        needsRetake++; // Failed, can retake
      } else if (course.hasPrerequisitesApproved == true ||
          course.prerequisites.isEmpty) {
        availableNew++; // Available to take for first time
      } else {
        blocked++; // Blocked by prerequisites
      }

      for (final child in currentNode.children) {
        countRecursive(child);
      }
    }

    countRecursive(node);
    return _StudentStats(
      availableNew: availableNew,
      completed: completed,
      needsRetake: needsRetake,
      blocked: blocked,
    );
  }
}

class _StudentStats {
  final int availableNew; // New courses available to take
  final int completed; // Approved courses
  final int needsRetake; // Failed courses that can be retaken
  final int blocked; // Courses blocked by prerequisites

  _StudentStats({
    required this.availableNew,
    required this.completed,
    required this.needsRetake,
    required this.blocked,
  });

  // Computed property for backward compatibility
  int get availableNow => availableNew + needsRetake;
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
    final studentInfo = _getStudentCourseInfo(course);
    final backgroundColor = _calculateBackgroundColor(theme, studentInfo);

    return Container(
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
        // Sutil border para cursos disponibles
        border:
            _shouldShowActionableBorder(studentInfo)
                ? Border.all(
                  color: studentInfo.statusColor.withOpacity(0.4),
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
              // Course code - keep original color, no changes
              Text(
                course.info.courseCode,
                style: TextStyle(
                  color: theme.colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              // Course name
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
                // Student status badge
                _buildStudentStatusBadge(course),
                const SizedBox(height: 8),
                // Original subtitle content
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
    final connectionMetrics = _ConnectionMetrics(fontSize);
    final isParentCritical = _isNodeInCriticalPath(node.course.info.courseCode);

    // Sort children to prioritize available courses for better student experience
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
    // Sort to show available courses first, then blocked ones
    // This helps students quickly see what they can take next
    return List.from(children)..sort((a, b) {
      final aInfo = _getStudentCourseInfo(a.course);
      final bInfo = _getStudentCourseInfo(b.course);

      // Priority order:
      // 1. Available now (can take)
      // 2. Needs retaking
      // 3. Completed
      // 4. Blocked by prerequisites
      int getPriority(_StudentCourseInfo info) {
        if (info.isAvailableNow && !info.actionMessage.contains("Completado")) {
          if (info.actionMessage.contains("Repetir")) return 2; // Retake
          return 1; // Available now
        }
        if (info.actionMessage.contains("Completado")) return 3; // Completed
        return 4; // Blocked
      }

      return getPriority(aInfo).compareTo(getPriority(bInfo));
    });
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

  Widget _buildStudentStatusBadge(ProgramCurriculumCourse course) {
    final studentInfo = _getStudentCourseInfo(course);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: studentInfo.statusColor.withOpacity(0.12),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: studentInfo.statusColor.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(studentInfo.icon, color: studentInfo.statusColor, size: 14),
          const SizedBox(width: 6),
          Text(
            studentInfo.actionMessage,
            style: TextStyle(
              color: studentInfo.statusColor,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  } // STUDENT-FOCUSED HELPERS - What students actually need to know

  _StudentCourseInfo _getStudentCourseInfo(ProgramCurriculumCourse course) {
    // Already passed/approved
    if (course.isApproved == true) {
      return const _StudentCourseInfo(
        actionMessage: "Completado",
        statusColor: Color(0xFF2E7D32), // Verde más rico y contrastante
        icon: Icons.check_circle,
        isAvailableNow: false,
      );
    }

    // Failed before - needs retaking
    if (course.isApproved == false) {
      return const _StudentCourseInfo(
        actionMessage: "Repetir curso",
        statusColor: Color(0xFFD32F2F), // Rojo más vibrante
        icon: Icons.refresh,
        isAvailableNow: true, // Can retake
      );
    }

    // Available to take now! - This is what students care about most
    if (course.hasPrerequisitesApproved == true) {
      return const _StudentCourseInfo(
        actionMessage: "¡PUEDES TOMAR AHORA!",
        statusColor: Color(
          0xFF1B5E20,
        ), // Verde oscuro que contrasta perfecto con azul
        icon: Icons.play_circle_fill,
        isAvailableNow: true,
      );
    }

    // Blocked by prerequisites - show what's blocking them with specifics
    if (course.prerequisites.isNotEmpty) {
      final pendingCount =
          course.prerequisites
              .where((prereq) => prereq.isApproved != true)
              .length;
      if (pendingCount == 1) {
        return const _StudentCourseInfo(
          actionMessage: "1 prerrequisito pendiente",
          statusColor: Color(0xFFE65100), // Naranja que funciona mejor con azul
          icon: Icons.lock,
          isAvailableNow: false,
        );
      } else {
        return _StudentCourseInfo(
          actionMessage: "$pendingCount prerrequisitos pendientes",
          statusColor: const Color(0xFFE65100), // Mismo naranja mejorado
          icon: Icons.lock,
          isAvailableNow: false,
        );
      }
    }

    // No prerequisites (first semester course)
    return const _StudentCourseInfo(
      actionMessage: "¡PUEDES TOMAR AHORA!",
      statusColor: Color(0xFF1B5E20), // Verde oscuro consistente
      icon: Icons.play_circle_fill,
      isAvailableNow: true,
    );
  } // Helper methods

  bool _isNodeInCriticalPath(String courseCode) =>
      highlightCriticalPath && criticalPathIds.contains(courseCode);

  bool _hasSiblingInCriticalPath(int fromIndex) {
    return node.children
        .skip(fromIndex)
        .any(
          (sibling) => _isNodeInCriticalPath(sibling.course.info.courseCode),
        );
  }

  Color _calculateBackgroundColor(
    ThemeData theme,
    _StudentCourseInfo studentInfo,
  ) {
    if (depth == 0) return Colors.transparent;

    // SIEMPRE aplicar el background progresivo azul basado en depth
    final baseOpacity = (0.06 * depth).clamp(0.0, 0.24);
    final baseColor = theme.colorScheme.primary.withOpacity(baseOpacity);

    // Si el curso está disponible para tomar, agregar un tinte sutil del status
    if (studentInfo.isAvailableNow &&
        !studentInfo.actionMessage.contains("Completado")) {
      // Combinar el azul progresivo con un toque del color del status
      return Color.lerp(
            baseColor,
            studentInfo.statusColor.withOpacity(0.06),
            0.3, // 30% del color del status, 70% del azul progresivo
          ) ??
          baseColor;
    }

    // Para cursos completados, agregar un toque verde muy sutil al azul progresivo
    if (studentInfo.actionMessage.contains("Completado")) {
      return Color.lerp(
            baseColor,
            Colors.green.withOpacity(0.04),
            0.2, // 20% verde, 80% azul progresivo
          ) ??
          baseColor;
    }

    // Para cursos bloqueados, mantener el azul progresivo puro (se ve elegante)
    return baseColor;
  }

  bool _shouldShowActionableBorder(_StudentCourseInfo studentInfo) {
    // Solo mostrar border para cursos que el estudiante puede tomar AHORA
    return studentInfo.isAvailableNow &&
        !studentInfo.actionMessage.contains("Completado");
  }

  _ConnectionColors _calculateConnectionColors(
    CourseTreeNode child,
    int childIndex,
    bool isParentCritical,
    Color defaultColor,
  ) {
    const criticalColor = Colors.orange;
    final isChildCritical = _isNodeInCriticalPath(child.course.info.courseCode);
    final hasSiblingInPath = _hasSiblingInCriticalPath(childIndex + 1);

    final useCriticalColor = isParentCritical && isChildCritical;
    final connectionColor =
        useCriticalColor ? criticalColor.withOpacity(0.8) : defaultColor;

    final continueColor =
        isParentCritical && hasSiblingInPath
            ? criticalColor.withOpacity(0.8)
            : defaultColor;

    return _ConnectionColors(
      verticalTo: connectionColor,
      horizontal: connectionColor,
      verticalContinue: continueColor,
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
