import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_file/open_file.dart';
import 'package:sigapp/core/infrastructure/ui/widgets/loading_indicator_icon.dart';
import 'package:sigapp/core/infrastructure/utils/time_utils.dart';
import 'package:sigapp/core/injection/get_it.dart';
import 'package:sigapp/courses/domain/entities/course_type.dart';
import 'package:sigapp/courses/infrastructure/pages/course_detail/course_detail_cubit.dart';
import 'package:sigapp/courses/infrastructure/pages/course_detail/partials/course_avatar.dart';
import 'package:sigapp/courses/infrastructure/pages/course_detail/partials/grade_tracker_section.dart';
import 'package:sigapp/courses/infrastructure/pages/course_detail/partials/grade_tracker_section_cubit.dart';
import 'package:sigapp/courses/infrastructure/pages/course_detail/partials/schedule_section.dart';
import 'package:sigapp/courses/infrastructure/pages/course_detail/components/table_info.dart';
import 'package:url_launcher/url_launcher.dart';

class CourseDetailPageWidget extends StatefulWidget {
  const CourseDetailPageWidget({super.key, required this.color});

  final Color color;

  @override
  State<CourseDetailPageWidget> createState() => _CourseDetailPageWidgetState();
}

class _CourseDetailPageWidgetState extends State<CourseDetailPageWidget> {
  Offset _tapPosition = Offset.zero;

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<CourseDetailCubit>(context);
    return BlocConsumer<CourseDetailCubit, CourseDetailState>(
      builder: (context, state) {
        return state.map(
          empty: (_) => Container(),
          ready: (state) => Scaffold(
            appBar: AppBar(
              title: Text('Detalle'),
            ),
            // backgroundColor: Theme.of(context).colorScheme.,
            body: ListView(
              children: [
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 16),
                  child: CourseAvatarWidget(
                    courseName: state.course.data.courseName,
                    color: widget.color,
                    diameter: MediaQuery.of(context).size.width * 0.25,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 16, left: 16, right: 16),
                  child: Text(
                    state.course.data.courseName,
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ),
                ListTile(
                  subtitle: TableInfoWidget([
                    ['Código', state.course.data.courseCode],
                    [
                      'Tipo',
                      state.course.data.courseType == CourseType.mandatory
                          ? 'Obligatorio'
                          : 'Electivo'
                    ],
                    ['Créditos', state.course.data.credits.toString()],
                    ['Docente', state.course.data.professor],
                    ['Fecha', TimeUtils.formatDate(state.course.data.date)],
                  ]),
                ),
                if (state.course.data.url.trim().isNotEmpty)
                  ListTile(
                    title: Text('Abrir enlace'),
                    trailing: Icon(Icons.open_in_browser),
                    onTap: () {
                      launchUrl(
                        Uri.parse(state.course.data.url),
                        mode: LaunchMode.externalApplication,
                      );
                    },
                  ),
                if (state.course.data.googleClassroomCode != null)
                  ListTile(
                    title: Text('Código Classroom'),
                    subtitle: Text(state.course.data.googleClassroomCode!),
                    trailing: Icon(Icons.copy),
                    onTap: () {
                      Clipboard.setData(ClipboardData(
                          text: state.course.data.googleClassroomCode!));
                    },
                  ),
                GestureDetector(
                  onTapDown: (details) {
                    // Guarda la posición a del toque.
                    _tapPosition = details.globalPosition;
                  },
                  onLongPress: () {
                    state.syllabus.maybeWhen(
                      loaded: (_) {
                        _showPopupMenu(context, cubit, _tapPosition);
                      },
                      orElse: () => null,
                    );
                  },
                  child: ListTile(
                    title: Text('Syllabus'),
                    subtitle: state.syllabus.map(
                      initial: (_) => Text('-'),
                      loading: (_) => Text('Cargando'),
                      loaded: (_) => Text('Disponible'),
                      notFound: (_) => Text('No disponible'),
                      error: (_) => Text('Error al descargar'),
                    ),
                    trailing: state.syllabus.maybeWhen(
                      loading: () => LoadingIndicatorIconWidget(),
                      loaded: (file) => Icon(Icons.open_in_new),
                      notFound: () => Icon(Icons.refresh),
                      error: (_) => Icon(Icons.info),
                      orElse: () => null,
                    ),
                    onTap: () {
                      state.syllabus.maybeWhen(
                        loaded: (file) => OpenFile.open(file.path),
                        notFound: () {
                          cubit.fetchSyllabus(forceDownload: true);
                        },
                        error: (_) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Reintentando'),
                            ),
                          );
                          cubit.fetchSyllabus(forceDownload: true);
                        },
                        orElse: () => null,
                      );
                    },
                  ),
                ),
                ListTile(
                  title: Text('Notas'),
                  subtitle: state.grades.map(
                    initial: (_) => Text('-'),
                    loading: (_) => Text('Cargando'),
                    loaded: (state) {
                      return state.value.grade.maybeWhen(
                        loaded: (value, isPartial) {
                          return Text(
                            isPartial
                                ? 'Nota parcial: ${value.toStringAsFixed(2)}'
                                : 'Nota final: ${value.toStringAsFixed(2)}',
                          );
                        },
                        empty: () {
                          return Text('No disponibles');
                        },
                        orElse: () {
                          return null;
                        },
                      );
                    },
                    error: (_) => Text('Error al obtener notas'),
                  ),
                  trailing: state.grades.maybeMap(
                    loading: (_) => LoadingIndicatorIconWidget(),
                    loaded: (state) => Icon(Icons.open_in_new),
                    error: (_) => Icon(Icons.info),
                    orElse: () => null,
                  ),
                  onTap: () {
                    state.grades.maybeMap(
                      loaded: (state) {
                        state.maybeWhen(
                          loaded: (value) {
                            launchUrl(
                              Uri.parse(value.url),
                              mode: LaunchMode.externalApplication,
                            );
                            value.grade.maybeWhen(
                              empty: () {
                                cubit.fetchGrades(forceDownload: true);
                              },
                              orElse: () => null,
                            );
                          },
                          orElse: () => null,
                        );
                      },
                      error: (_) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Reintentando'),
                          ),
                        );
                        cubit.fetchGrades(forceDownload: true);
                      },
                      orElse: () => null,
                    );
                  },
                ),
                Divider(),
                ScheduleSectionWidget(
                  enrolledCourse: state.course,
                ),
                Divider(),
                BlocProvider(
                  create: (context) => getIt<GradeTrackerSectionCubit>(),
                  child: GradeTrackerSectionWidget(
                    enrolledCourse: state.course,
                  ),
                ),
                Divider(),
              ],
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }

  void _showPopupMenu(
      BuildContext context, CourseDetailCubit cubit, Offset tapPosition) {
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;
    showMenu(
      context: context,
      position: RelativeRect.fromRect(
        tapPosition & const Size(40, 40),
        Offset.zero & overlay.size,
      ),
      items: [
        PopupMenuItem(
          child: Text('Refrescar'),
          onTap: () {
            cubit.fetchSyllabus(forceDownload: true);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Refrescando syllabus')),
            );
          },
        ),
      ],
    );
  }
}
