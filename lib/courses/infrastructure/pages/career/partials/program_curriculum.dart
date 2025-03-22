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
            title: Text('Ciclo ${term.termRomanNumeral}'),
            children: term.courses.map(
              (course) {
                return ListTile(
                  title: Text(
                      '${course.info.courseCode} - ${course.info.courseName}'),
                  subtitle: Row(
                    children: [
                      Icon((() {
                        if (course.info.courseType == CourseType.elective) {
                          return MdiIcons.leaf;
                        }
                        return course.isApproved == true
                            ? Icons.lock_open
                            : Icons.lock;
                      })(), size: 16),
                      SizedBox(width: 4),
                      Text((() {
                        final data = [];
                        data.add(course.info.courseType == CourseType.mandatory
                            ? 'Obligatorio'
                            : 'Electivo');
                        data.add(course.info.credits > 1
                            ? '${course.info.credits} créditos'
                            : '${course.info.credits} crédito');
                        return data.join(' • ');
                      })())
                    ],
                  ),
                  trailing: course.isApproved == null
                      ? null
                      : course.isApproved!
                          ? Icon(Icons.check, color: Colors.green)
                          : Icon(Icons.close, color: Colors.red),
                );
              },
            ).toList(),
          );
        },
      ).toList(),
    );
  }
}
