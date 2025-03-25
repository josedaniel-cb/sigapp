import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sigapp/courses/domain/entities/course_type.dart';
import 'package:sigapp/courses/domain/entities/program_curriculum_course_term.dart';
import 'package:sigapp/courses/infrastructure/pages/career/widgets/course_subtitle.dart';
import 'package:sigapp/courses/infrastructure/pages/course_prerequisite_chain/course_prerequisite_chain_page.dart';

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
                Icon(Icons.book),
                SizedBox(width: 8),
                Text(
                  'Ciclo ${term.termRomanNumeral}',
                  style: Theme.of(context).textTheme.titleMedium,
                )
              ],
            ),
            children: term.courses.map(
              (course) {
                return _buildItem(
                  context,
                  course: course,
                  onSeePrerequisites: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CoursePrerequisiteChainPage(
                          course: course,
                          programCurriculum: programCurriculum,
                        ),
                      ),
                    );
                  },
                );
              },
            ).toList(),
          );
        },
      ).toList(),
    );
  }

  Widget _buildItem(
    BuildContext context, {
    required ProgramCurriculumCourse course,
    required VoidCallback onSeePrerequisites,
  }) {
    final items = <CourseSubtitleWidgetItem>[];
    items.add(CourseSubtitleWidgetItem(
      icon: course.info.courseType == CourseType.mandatory
          ? MdiIcons.school
          : MdiIcons.leaf,
      text: course.info.courseType == CourseType.mandatory
          ? 'Obligatorio'
          : 'Electivo',
    ));
    items.add(CourseSubtitleWidgetItem(
      text: course.info.credits == 1
          ? '1 crédito'
          : '${course.info.credits} créditos',
    ));
    if (course.prerequisites.isNotEmpty) {
      items.add(CourseSubtitleWidgetItem(
        icon: MdiIcons.link,
        text:
            '${course.prerequisites.length} requisito${course.prerequisites.length != 1 ? 's' : ''}',
      ));
    } else if (course.info.termNumber != 1) {
      items.add(CourseSubtitleWidgetItem(
        icon: MdiIcons.linkOff,
        text: 'Sin requisitos',
      ));
    }

    return ListTile(
      leading: (() {
        if (course.isApproved == true) {
          return const Icon(Icons.check, color: Colors.green);
        }
        if (course.isApproved == false) {
          return const Icon(Icons.close, color: Colors.red);
        }
        if (course.hasPrerequisitesApproved == null) {
          return Icon(Icons.abc, color: Colors.transparent);
        }
        if (course.hasPrerequisitesApproved == true) {
          return Icon(
            Icons.lock_open_outlined,
            color: Theme.of(context).primaryColor,
          );
        }
        return Icon(Icons.lock_outlined);
      })(),
      title: Text(course.info.courseName),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CourseSubtitleWidget(children: items),
          if (course.prerequisites.isNotEmpty ||
              course.getDependentCoursesTree(
                      programCurriculum: programCurriculum) !=
                  null)
            TextButton.icon(
              icon: Icon(Icons.link),
              label: Text('Ver cadena de requisitos'),
              onPressed: onSeePrerequisites,
            ),
        ],
      ),
      // trailing: course.isApproved == null
      //     ? null
      //     : Icon(
      //         course.isApproved! ? Icons.check : Icons.close,
      //         color: course.isApproved! ? Colors.green : Colors.red,
      //       ),
    );
  }
}
