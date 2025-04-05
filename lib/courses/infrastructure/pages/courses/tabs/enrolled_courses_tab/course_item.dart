import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sigapp/courses/domain/entities/course_type.dart';
import 'package:sigapp/courses/infrastructure/pages/career/widgets/course_subtitle.dart';
import 'package:sigapp/courses/infrastructure/pages/course_detail/course_detail_cubit.dart';
import 'package:sigapp/courses/infrastructure/pages/course_detail/course_detail_page.dart';
import 'package:sigapp/courses/infrastructure/pages/course_detail/partials/course_avatar.dart';

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
                    child: CourseDetailPageWidget(color: color),
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
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CourseSubtitleWidget(children: [
                          // Tipo de curso
                          state.course.data.courseType == CourseType.mandatory
                              ? CourseSubtitleWidgetItem(
                                  text: 'Obligatorio',
                                  icon: Icons.school,
                                )
                              : state.course.data.courseType ==
                                      CourseType.elective
                                  ? CourseSubtitleWidgetItem(
                                      text: 'Electivo',
                                      icon: MdiIcons.leaf,
                                    )
                                  : CourseSubtitleWidgetItem(
                                      text: 'Tipo desconocido',
                                    ),
                          // Créditos
                          CourseSubtitleWidgetItem(
                            text: state.course.data.credits == 1
                                ? '1 crédito'
                                : '${state.course.data.credits} créditos',
                          ),
                        ]),
                        // Syllabus
                        CourseSubtitleWidget(children: [
                          state.syllabus.when(
                            initial: () => CourseSubtitleWidgetItem(
                              text: 'Verificando syllabus',
                              loading: true,
                            ),
                            loading: () => CourseSubtitleWidgetItem(
                              text: 'Verificando syllabus',
                              loading: true,
                            ),
                            loaded: (_) => CourseSubtitleWidgetItem(
                              text: 'Syllabus disponible',
                              icon: Icons.check_circle,
                            ),
                            notFound: () => CourseSubtitleWidgetItem(
                              text: 'Syllabus no disponible',
                              icon: Icons.cancel_outlined,
                            ),
                            error: (_) => CourseSubtitleWidgetItem(
                              text: 'Error al descargar syllabus',
                              icon: Icons.error,
                            ),
                          ),
                        ]),
                        CourseSubtitleWidget(children: [
                          // Notas
                          state.grades.when(
                            initial: () => CourseSubtitleWidgetItem(
                              text: 'Verificando notas',
                              loading: true,
                            ),
                            loading: () => CourseSubtitleWidgetItem(
                              text: 'Verificando notas',
                              loading: true,
                            ),
                            loaded: (courseGradeInfo) {
                              final params = courseGradeInfo.grade.maybeWhen(
                                empty: () => [
                                  MdiIcons.clipboardAlertOutline,
                                  'Notas no disponibles'
                                ],
                                loaded: (grade, isPartial) => isPartial
                                    ? [
                                        MdiIcons.clipboardCheckOutline,
                                        'Nota parcial: $grade'
                                      ]
                                    : [
                                        MdiIcons.clipboardCheck,
                                        'Nota final: $grade'
                                      ],
                                orElse: () =>
                                    [Icons.error, 'Error al verificar notas'],
                              );
                              return CourseSubtitleWidgetItem(
                                text: params[1] as String,
                                icon: params[0] as IconData?,
                              );
                            },
                            error: (_) => CourseSubtitleWidgetItem(
                              text: 'Error al verificar notas',
                              icon: Icons.error,
                            ),
                          ),
                        ]),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
