import 'package:flutter/material.dart';
import 'package:sigapp/courses/domain/entities/program_curriculum_course_term.dart';

class CoursePrerequisiteChainPage extends StatelessWidget {
  const CoursePrerequisiteChainPage({
    super.key,
    required this.programCurriculum,
    required this.course,
  });

  final ProgramCurriculumCourse course;
  final List<ProgramCurriculumTerm> programCurriculum;

  @override
  Widget build(BuildContext context) {
    final prerequisiteCoursesTree = course.getPrerequisiteCoursesTree(
      programCurriculum: programCurriculum,
    );
    final dependentCoursesTree = course.getDependentCoursesTree(
      programCurriculum: programCurriculum,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Cadena de requisitos'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildTree(
              context,
              node: prerequisiteCoursesTree,
              title: 'Requisitos',
              subtitle:
                  'Cursos requisito de ${course.info.courseName} (ciclo ${course.info.termRomanNumeral})',
            ),
            SizedBox(height: 16),
            _buildTree(
              context,
              node: dependentCoursesTree,
              title: 'Dependientes',
              subtitle:
                  'Cursos que requieren de ${course.info.courseName} (ciclo ${course.info.termRomanNumeral})',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTree(
    BuildContext context, {
    required CourseTreeNode node,
    required String title,
    required String subtitle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              // SizedBox(height: 4),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
        _buildTreeItem(
          context,
          node: node,
          showRoot: false,
        ),
      ],
    );
  }

  Widget _buildTreeItem(
    BuildContext context, {
    required CourseTreeNode node,
    bool showRoot = true,
  }) {
    Widget buildRoot() {
      return ListTile(
        title: Text(node.course.info.courseName),
        subtitle: Text('Ciclo ${node.course.info.termRomanNumeral}'),
      );
    }

    Widget buildChildren() {
      final theme = Theme.of(context);
      final dividerColor = theme.dividerColor;
      final textTheme = theme.textTheme;
      return Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(color: dividerColor),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: node.children
                .map(
                  (child) => Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: (theme.textTheme.bodyLarge?.fontSize ?? 0) * 1.5,
                        ),
                        color: dividerColor,
                        width: 8,
                        height: 1,
                      ),
                      Expanded(
                        child: _buildTreeItem(
                          context,
                          node: child,
                        ),
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
        ),
      );
    }

    if (!showRoot) {
      return buildChildren();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildRoot(),
        if (node.children.isNotEmpty) buildChildren(),
      ],
    );
  }
}
