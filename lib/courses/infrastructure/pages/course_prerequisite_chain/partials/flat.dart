import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sigapp/courses/domain/entities/course_type.dart';
import 'package:sigapp/courses/domain/entities/program_curriculum_course_term.dart';
import 'package:sigapp/courses/infrastructure/pages/career/widgets/course_subtitle.dart';

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
      // No aplicamos filtros aquí porque el árbol ya viene filtrado desde TabSectionWidget
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
    final sortedKeys =
        grouped.keys.toList()
          ..sort((a, b) => b.compareTo(a)); // Orden descendente

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStudentSummary(context, flatList),
        Expanded(
          child: ListView.builder(
            itemCount: sortedKeys.length,
            itemBuilder: (context, idx) {
              final ciclo = sortedKeys[idx];
              final nodes = grouped[ciclo]!;
              // Sort nodes by student priority within each cycle
              final sortedNodes = _sortNodesByStudentPriority(nodes);
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
                          node.course.info.courseCode ==
                              root!.course.info.courseCode,
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

  Widget _buildStudentSummary(
    BuildContext context,
    List<CourseTreeNode> flatList,
  ) {
    final stats = _calculateStudentStats(flatList);

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
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
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

  _StudentStats _calculateStudentStats(List<CourseTreeNode> flatList) {
    int availableNew = 0; // New courses that can be taken
    int completed = 0;
    int needsRetake = 0; // Failed courses that can be retaken
    int blocked = 0; // Courses blocked by prerequisites

    for (final node in flatList) {
      final course = node.course;

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
    }

    return _StudentStats(
      availableNew: availableNew,
      completed: completed,
      needsRetake: needsRetake,
      blocked: blocked,
    );
  }

  List<CourseTreeNode> _sortNodesByStudentPriority(List<CourseTreeNode> nodes) {
    return List.from(nodes)..sort((a, b) {
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
  }
}

// Widget para el encabezado de ciclo en la lista plana
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
    final stats = _calculateCycleStats(nodes);

    return Container(
      color: theme.colorScheme.surfaceVariant,
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
              color: theme.colorScheme.onSurfaceVariant.withOpacity(0.7),
            ),
          ),
          const Spacer(),
          _buildCycleStatsChips(stats, theme),
        ],
      ),
    );
  }

  Widget _buildCycleStatsChips(_StudentStats stats, ThemeData theme) {
    final chips = <Widget>[];

    // Available courses chip (priority)
    if (stats.availableNow > 0) {
      chips.add(
        _buildStatChip(
          "${stats.availableNow}",
          stats.availableNew > 0 && stats.needsRetake > 0
              ? "disponibles"
              : stats.needsRetake > 0
              ? "para repetir"
              : "disponibles",
          stats.needsRetake > 0 ? Colors.orange : const Color(0xFF1B5E20),
          Icons.play_circle_fill,
        ),
      );
    }

    // Completed courses chip
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

    // Blocked courses chip (only if significant)
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
                (chip) => Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: chip,
                ),
              )
              .toList(),
    );
  }

  Widget _buildStatChip(
    String count,
    String label,
    Color color,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3), width: 1),
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

  _StudentStats _calculateCycleStats(List<CourseTreeNode> nodes) {
    int availableNew = 0;
    int completed = 0;
    int needsRetake = 0;
    int blocked = 0;

    for (final node in nodes) {
      final course = node.course;

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
    }

    return _StudentStats(
      availableNew: availableNew,
      completed: completed,
      needsRetake: needsRetake,
      blocked: blocked,
    );
  }
}

// Widget para un curso en la lista plana
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

    final studentInfo = _getStudentCourseInfo(course);

    return ListTile(
      dense: true,
      tileColor: _calculateBackgroundColor(studentInfo, isRoot),
      leading: _buildLeadingIcon(course, studentInfo, isCritical, theme),
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
              : _shouldShowActionableBorder(studentInfo)
              ? Icon(studentInfo.icon, color: studentInfo.statusColor, size: 20)
              : null,
    );
  }

  Widget _buildLeadingIcon(
    ProgramCurriculumCourse course,
    _StudentCourseInfo studentInfo,
    bool isCritical,
    ThemeData theme,
  ) {
    // Use student-focused icons that are more semantic
    Color iconColor = isCritical ? Colors.orange : studentInfo.statusColor;

    return Icon(studentInfo.icon, color: iconColor, size: 24);
  }

  Widget _buildStudentStatusBadge(
    _StudentCourseInfo studentInfo,
    BuildContext context,
  ) {
    // Only show badge for actionable courses or completed courses
    if (!studentInfo.isAvailableNow &&
        !studentInfo.actionMessage.contains("Completado")) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: studentInfo.statusColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(studentInfo.icon, color: Colors.white, size: 12),
          const SizedBox(width: 4),
          Text(
            studentInfo.isAvailableNow
                ? (studentInfo.actionMessage.contains("Repetir")
                    ? "REPETIR"
                    : "DISPONIBLE")
                : "APROBADO",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Color _calculateBackgroundColor(_StudentCourseInfo studentInfo, bool isRoot) {
    // Base color for flat view - very subtle
    Color? baseColor;

    // Root course gets yellow highlight
    if (isRoot) {
      baseColor = Colors.yellow.withOpacity(0.1);
    }

    // Student status color overlay - very subtle for ListTiles
    if (studentInfo.isAvailableNow) {
      // Available courses get subtle green tint
      final statusTint = studentInfo.statusColor.withOpacity(0.05);
      return baseColor != null
          ? Color.lerp(baseColor, statusTint, 0.5) ?? statusTint
          : statusTint;
    } else if (studentInfo.actionMessage.contains("Completado")) {
      // Completed courses get subtle green tint
      final statusTint = studentInfo.statusColor.withOpacity(0.03);
      return baseColor != null
          ? Color.lerp(baseColor, statusTint, 0.5) ?? statusTint
          : statusTint;
    }

    // Return base color or transparent for blocked courses
    return baseColor ?? Colors.transparent;
  }

  bool _shouldShowActionableBorder(_StudentCourseInfo studentInfo) {
    // Show border for courses students can take right now
    return studentInfo.isAvailableNow &&
        !studentInfo.actionMessage.contains("Completado");
  }

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
  }
}
