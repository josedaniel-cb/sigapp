import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_file/open_file.dart';
import 'package:sigapp/courses/infrastructure/pages/course_detail/course_detail_cubit.dart';
import 'package:sigapp/courses/infrastructure/pages/course_detail/course_detail_page.dart';
import 'package:sigapp/courses/infrastructure/pages/course_detail/partials/course_avatar.dart';
import 'package:sigapp/student/domain/entities/enrolled_course_data.dart';

class CourseItemWidget extends StatelessWidget {
  final Color color;

  const CourseItemWidget({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseDetailCubit, CourseDetailState>(
      builder: (context, state) {
        return state.map(
          empty: (_) => Container(),
          ready: (state) => InkWell(
            onTap: () {
              final cubit = BlocProvider.of<CourseDetailCubit>(context);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => BlocProvider.value(
                    value: cubit,
                    child: CourseDetailPageWidget(),
                  ),
                ),
              );
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 16, top: 8),
                  child: CourseAvatarWidget(
                    courseName: state.course.data.courseName,
                    color: color,
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: Text(state.course.data.courseName),
                    // leading: Expanded(
                    //   child: ,
                    // ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            state.course.data.courseType == CourseType.mandatory
                                ? Text('Obligatorio')
                                : Text('Electivo'),
                            // Text('Grupo ${state.course.data.group} - Sección ${state.course.data.section}'),
                            Text(' • '),
                            // Row(
                            //   children: [
                            //     Text(state.course.data.credits.toString()),
                            //     SizedBox(width: 2),
                            //     Icon(Icons.stars, size: 16),
                            //   ],
                            // ),
                            Text('${state.course.data.credits} créditos'),
                          ],
                        ),
                        // _buildSyllabusButton(itemState),
                        state.syllabus.when(
                          loading: () => Container(
                            margin: const EdgeInsets.only(top: 4),
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 12,
                                  width: 12,
                                  child:
                                      CircularProgressIndicator(strokeWidth: 2),
                                ),
                                SizedBox(width: 3),
                                Text('Verificando syllabus'),
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
            ),
          ),
        );
        if (state is CourseDetailEmptyState) {
          return Container();
        }
        state = state as CourseDetailReadyState;
      },
    );
  }

  Widget _buildSyllabusButton(CourseDetailReadyState state) {
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
