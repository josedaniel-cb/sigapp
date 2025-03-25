import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sigapp/courses/domain/entities/course_type.dart';
import 'package:sigapp/courses/domain/entities/program_curriculum_course_term.dart';
import 'package:sigapp/courses/infrastructure/pages/career/widgets/course_subtitle.dart';

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
      body: (() {
        final maxDepth = math.max(
          prerequisiteCoursesTree?.depth ?? 0,
          dependentCoursesTree?.depth ?? 0,
        );
        if (maxDepth < 5) {
          return SingleChildScrollView(
            child: _buildBody(
              prerequisiteCoursesTree,
              dependentCoursesTree,
              context,
            ),
          );
        }

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SizedBox(
            width: (() {
              final mediaQueryWidth = MediaQuery.of(context).size.width;
              return mediaQueryWidth * (1 + (maxDepth - 5) * 0.1);
            })(),
            child: SingleChildScrollView(
              child: _buildBody(
                prerequisiteCoursesTree,
                dependentCoursesTree,
                context,
              ),
            ),
          ),
        );
      })(),
    );
  }

  Container _buildBody(CourseTreeNode? prerequisiteCoursesTree,
      CourseTreeNode? dependentCoursesTree, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: prerequisiteCoursesTree == null && dependentCoursesTree == null
          ? Center(
              child: Text('No hay cursos relacionados'),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (prerequisiteCoursesTree != null)
                  _buildTree(
                    context,
                    node: prerequisiteCoursesTree,
                    title: 'Requisitos',
                    subtitle:
                        'Cursos que abren ${course.info.courseName} (ciclo ${course.info.termRomanNumeral})',
                  ),
                if (prerequisiteCoursesTree != null &&
                    dependentCoursesTree != null)
                  SizedBox(height: 16),
                if (dependentCoursesTree != null)
                  _buildTree(
                    context,
                    node: dependentCoursesTree,
                    title: 'Dependientes',
                    subtitle:
                        'Cursos que abre de ${course.info.courseName} (ciclo ${course.info.termRomanNumeral})',
                  ),
              ],
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
      return SizedBox(
        // constraints: BoxConstraints(
        //   minWidth: MediaQuery.of(context).size.width,
        // ),
        width: MediaQuery.of(context).size.width - 8 * 8,
        child: ListTile(
          title: Text(course.info.courseName),
          leading: (() {
            if (course.isApproved == true) {
              return const Icon(Icons.check, color: Colors.green);
            }
            if (course.isApproved == false) {
              return const Icon(Icons.close, color: Colors.red);
            }
            if (course.hasPrerequisitesApproved == true) {
              return Icon(Icons.lock_open_outlined, color: theme.primaryColor);
            }
            return Icon(Icons.lock_outlined);
          })(),
          // subtitle: Text('Ciclo ${course.info.termRomanNumeral}'),
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
                text: course.info.credits == 1
                    ? '1 crédito'
                    : '${course.info.credits} créditos',
              )
            ],
          ),
        ),
      );
    }

    Widget buildChildren() {
      final dividerColor = theme.dividerColor;
      // final dividerColor = Colors.teal;

      final fontSize = theme.textTheme.bodyLarge?.fontSize ?? 0;
      final top = fontSize * 2.2;
      final width = fontSize;
      final thickness = 2.0;

      return Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: node.children.asMap().entries.map((entry) {
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
                      child: _buildTreeItem(
                        context,
                        node: child,
                      ),
                    ),
                  ],
                ),
              ],
            );
          }).toList(),
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
