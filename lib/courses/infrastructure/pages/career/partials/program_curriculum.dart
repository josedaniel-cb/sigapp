import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sigapp/courses/domain/entities/course_type.dart';
import 'package:sigapp/courses/domain/entities/program_curriculum_course_term.dart';

class CareerPageProgramCurriculumWidget extends StatelessWidget {
  const CareerPageProgramCurriculumWidget({
    super.key,
    required this.programCurriculum,
  });

  final List<ProgramCurriculumTerm> programCurriculum;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: programCurriculum.map(
        (term) {
          return ExpansionTile(
            title: Row(
              children: [
                Icon(Icons.school),
                SizedBox(width: 8),
                Text(
                  'Ciclo ${term.termRomanNumeral}',
                  style: Theme.of(context).textTheme.titleMedium,
                )
              ],
            ),
            children: term.courses.map(
              (course) {
                return _buildItem(course);
              },
            ).toList(),
          );
        },
      ).toList(),
    );
  }

  Widget _buildItem(ProgramCurriculumCourse course) {
    Widget buildInfo({
      required String text,
      IconData? icon,
    }) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 16),
            SizedBox(width: 4),
          ],
          Text(text),
        ],
      );
    }

    List<Widget> join(List<Widget> list, Widget separator) {
      final result = <Widget>[];
      for (var i = 0; i < list.length; i++) {
        result.add(list[i]);
        if (i < list.length - 1) {
          result.add(separator);
        }
      }
      return result;
    }

    final items = <Widget>[];

    items.add(buildInfo(
      icon: course.info.courseType == CourseType.elective
          ? MdiIcons.leaf
          : Icons.lock_outline,
      text: course.info.courseType == CourseType.mandatory
          ? 'Obligatorio'
          : 'Electivo',
    ));
    items.add(buildInfo(
      text: course.info.credits == 1
          ? '1 crédito'
          : '${course.info.credits} créditos',
    ));
    if (course.requirements.isNotEmpty) {
      items.add(buildInfo(
        icon: MdiIcons.link,
        text:
            '${course.requirements.length} requisito${course.requirements.length > 1 ? 's' : ''}',
      ));
    }

    return ListTile(
      title: Text('${course.info.courseCode} - ${course.info.courseName}'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 4,
            runSpacing: 4,
            children: join(items, Text('•')),
          ),
          if (course.requirements.isNotEmpty)
            TextButton.icon(
              icon: Icon(Icons.link),
              label: Text('Ver cadena de requisitos'),
              onPressed: () {},
            ),
        ],
      ),
      trailing: course.isApproved == null
          ? null
          : Icon(
              course.isApproved! ? Icons.check : Icons.close,
              color: course.isApproved! ? Colors.green : Colors.red,
            ),
    );
  }
}
