import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_file/open_file.dart';
import 'package:sigapp/courses/infrastructure/pages/course_detail/course_detail_cubit.dart';
import 'package:sigapp/courses/infrastructure/pages/course_detail/partials/course_avatar.dart';
import 'package:sigapp/student/domain/entities/enrolled_course_data.dart';

class CourseItemWidget extends StatelessWidget {
  final EnrolledCourseData course;
  final Color color;

  const CourseItemWidget(
      {super.key, required this.course, required this.color});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseDetailCubit, CourseDetailState>(
      builder: (context, itemState) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 16, top: 8),
              child: CourseAvatarWidget(
                courseName: course.courseName,
                color: color,
              ),
            ),
            Expanded(
              child: ListTile(
                title: Text(course.courseName),
                // leading: Expanded(
                //   child: ,
                // ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        course.courseType == CourseType.mandatory
                            ? Text('Obligatorio')
                            : Text('Electivo'),
                        // Text('Grupo ${course.group} - Sección ${course.section}'),
                        Text(' • '),
                        // Row(
                        //   children: [
                        //     Text(course.credits.toString()),
                        //     SizedBox(width: 2),
                        //     Icon(Icons.stars, size: 16),
                        //   ],
                        // ),
                        Text('${course.credits} créditos'),
                      ],
                    ),
                    // _buildSyllabusButton(itemState),
                    itemState.syllabus.when(
                      loading: () => Container(
                        margin: const EdgeInsets.only(top: 4),
                        child: Row(
                          children: [
                            SizedBox(
                              height: 12,
                              width: 12,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                            SizedBox(width: 2),
                            Text('Syllabus'),
                          ],
                        ),
                      ),
                      // loaded: (file) => TextButton.icon(
                      //   icon: Icon(Icons.list_alt),
                      //   label: Text('Syllabus disponible'),
                      //   onPressed: () {
                      //     OpenFilex.open(file.path);
                      //   },
                      // ),
                      loaded: (syllabusFile) => Container(
                        margin: const EdgeInsets.only(top: 4),
                        child: Row(
                          children: [
                            Icon(Icons.check_circle, size: 16),
                            SizedBox(width: 2),
                            Text('Syllabus'),
                          ],
                        ),
                      ),
                      notFound: () => Container(
                        margin: const EdgeInsets.only(top: 4),
                        child: Text('Syllabus no disponible'),
                      ),
                      error: (msg) => Container(
                        margin: const EdgeInsets.only(top: 4),
                        child: Text('Error al descargar syllabus'),
                      ),
                      initial: () => Container(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSyllabusButton(CourseDetailState state) {
    return state.syllabus.when(
      initial: () => TextButton.icon(
        onPressed: null,
        icon: Icon(Icons.list),
        label: Text('Cargar syllabus...'),
      ),
      loading: () => TextButton.icon(
        icon: SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(strokeWidth: 3),
        ),
        label: Text('Descargando...'),
        onPressed: null,
      ),
      loaded: (file) => TextButton.icon(
        icon: Icon(Icons.list_alt),
        label: Text('Syllabus'),
        onPressed: () {
          OpenFile.open(file.path);
        },
      ),
      notFound: () => Text('Syllabus no disponible'),
      error: (msg) => Text('Error al descargar syllabus'),
    );
  }
}
