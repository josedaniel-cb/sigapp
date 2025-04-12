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
                      spacing: 4,
                      children: [
                        CourseSubtitleWidget(
                          children: [
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
                          ],
                        ),
                        Builder(
                          builder: (context) {
                            final additionalItems = <CourseSubtitleWidgetItem?>[
                              // Notas
                              state.grades.maybeWhen(
                                loading: () => CourseSubtitleWidgetItem(
                                    text: 'Notas', loading: true),
                                loaded: (courseGradeInfo) {
                                  return courseGradeInfo.grade.maybeWhen(
                                    loaded: (value, isPartial) =>
                                        CourseSubtitleWidgetItem(
                                      text: value.toStringAsFixed(2),
                                      icon: isPartial
                                          ? MdiIcons.clipboardCheckOutline
                                          : MdiIcons.clipboardCheck,
                                    ),
                                    orElse: () => null,
                                  );
                                },
                                orElse: () => null,
                              ),
                              // Syllabus
                              state.syllabus.maybeWhen(
                                loading: () => CourseSubtitleWidgetItem(
                                  text: 'Syllabus',
                                  loading: true,
                                ),
                                loaded: (_) => CourseSubtitleWidgetItem(
                                  text: 'Syllabus',
                                  icon: Icons.check_circle,
                                ),
                                orElse: () => null,
                              ),
                            ].whereType<CourseSubtitleWidgetItem>().toList();

                            if (additionalItems.isEmpty) {
                              return const SizedBox.shrink();
                            }

                            return CourseSubtitleWidget(
                                children: additionalItems);
                          },
                        ),
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
