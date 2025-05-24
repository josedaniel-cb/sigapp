import 'package:sigapp/courses/domain/entities/program_curriculum_course_term.dart';
import 'package:sigapp/courses/infrastructure/pages/course_prerequisite_chain/utils/shared_utils.dart';

List<CourseTreeNode> flattenCourseTree(CourseTreeNode? root) {
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
  }

  return flatList;
}

StudentStats calculateFlatStudentStats(List<CourseTreeNode> flatList) {
  int availableNew = 0;
  int completed = 0;
  int needsRetake = 0;
  int blocked = 0;

  for (final node in flatList) {
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

  return StudentStats(
    availableNew: availableNew,
    completed: completed,
    needsRetake: needsRetake,
    blocked: blocked,
  );
}

StudentStats calculateCycleStats(List<CourseTreeNode> nodes) {
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

  return StudentStats(
    availableNew: availableNew,
    completed: completed,
    needsRetake: needsRetake,
    blocked: blocked,
  );
}

Map<String, List<CourseTreeNode>> groupNodesByCycle(
  List<CourseTreeNode> nodes,
) {
  Map<String, List<CourseTreeNode>> grouped = {};
  for (final node in nodes) {
    final ciclo = node.course.info.termRomanNumeral;
    grouped.putIfAbsent(ciclo, () => []).add(node);
  }
  return grouped;
}
