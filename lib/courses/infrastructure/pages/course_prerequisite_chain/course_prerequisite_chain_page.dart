import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sigapp/courses/domain/entities/course_type.dart';
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Container(
            //   margin: const EdgeInsets.symmetric(horizontal: 16),
            //   child: Text(
            //     course.info.courseName,
            //     style: Theme.of(context).textTheme.titleLarge,
            //   ),
            // ),
            if (prerequisiteCoursesTree != null)
              _buildTree(
                context,
                node: prerequisiteCoursesTree,
                title: 'Requisitos',
                subtitle:
                    'Cursos que abren ${course.info.courseName} (ciclo ${course.info.termRomanNumeral})',
              ),
            if (prerequisiteCoursesTree != null && dependentCoursesTree != null)
              SizedBox(height: 16),
            if (dependentCoursesTree != null)
              _buildTree(
                context,
                node: dependentCoursesTree,
                title: 'Dependientes',
                subtitle:
                    'Cursos que abre de ${course.info.courseName} (ciclo ${course.info.termRomanNumeral})',
              ),
            if (prerequisiteCoursesTree == null && dependentCoursesTree == null)
              Center(
                child: Text('No hay cursos relacionados'),
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
                style: Theme.of(context).textTheme.titleMedium,
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
    final course = node.course;
    final theme = Theme.of(context);

    Widget buildRoot() {
      return ListTile(
        leading: Icon(course.info.courseType == CourseType.mandatory
            ? MdiIcons.school
            : MdiIcons.leaf),
        title: Text(course.info.courseName),
        subtitle: Text('Ciclo ${course.info.termRomanNumeral}'),
        trailing: (() {
          if (course.isApproved == null) return null;
          return course.isApproved!
              ? const Icon(Icons.check, color: Colors.green)
              : const Icon(Icons.close, color: Colors.red);
        })(),
      );
    }

    Widget buildChildren() {
      final dividerColor = theme.dividerColor;

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
            children: node.children.map((child) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      top: (theme.textTheme.bodyLarge?.fontSize ?? 0) * 2.2,
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
              );
            }).toList(),
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
