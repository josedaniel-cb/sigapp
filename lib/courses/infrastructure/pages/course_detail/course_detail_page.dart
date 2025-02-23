import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_file/open_file.dart';
import 'package:sigapp/core/ui/widgets/loading_indicator_icon.dart';
import 'package:sigapp/core/utils/time_utils.dart';
import 'package:sigapp/courses/infrastructure/pages/course_detail/course_detail_cubit.dart';
import 'package:sigapp/student/domain/entities/enrolled_course_data.dart';
import 'package:url_launcher/url_launcher.dart';

class CourseDetailPageWidget extends StatefulWidget {
  const CourseDetailPageWidget({super.key});

  @override
  State<CourseDetailPageWidget> createState() => _CourseDetailPageWidgetState();
}

class _CourseDetailPageWidgetState extends State<CourseDetailPageWidget> {
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
                  padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                  child: Text(
                    state.course.data.courseName,
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ),
                ListTile(
                  subtitle: _buildTableInfo([
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
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   SnackBar(
                      //       content: Text('Código copiado al portapapeles')),
                      // );
                    },
                  ),
                ListTile(
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
                    loaded: (file) => Icon(Icons.file_open),
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
                  onLongPress: () {
                    state.syllabus.maybeWhen(
                      loaded: (_) {
                        _showPopupMenu(context, cubit);
                      },
                      orElse: () => null,
                    );
                  },
                ),
                Divider(),
                Container(
                  margin: EdgeInsets.only(top: 16),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Horario',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
                ListTile(
                  subtitle: _buildTableInfo(
                    [
                      ['Grupo', state.course.data.group],
                      ['Sección', state.course.data.section],
                    ],
                  ),
                ),
                ListTile(
                  title: Text('Semana'),
                  subtitle: _buildTableInfo(
                    (() {
                      final events = [...state.course.scheduleEvents];
                      events.sort((a, b) => a.weekday.compareTo(b.weekday));
                      return events.map((e) {
                        final weekdayName =
                            TimeUtils.weekdayToString(e.weekday);
                        return [
                          '${weekdayName[0].toUpperCase()}${weekdayName.substring(1)}',
                          TimeUtils.formatEventDuration(EventDuration(
                            startHour: e.startHour,
                            startMinute: e.startMinute,
                            endHour: e.endHour,
                            endMinute: e.endMinute,
                          )),
                        ];
                      }).toList();
                    })(),
                  ),
                ),
                ListTile(
                  title: Text('Tiempo total'),
                  subtitle: Text(
                    (() {
                      final total = state.course.scheduleEvents.fold(
                        Duration(),
                        (acc, e) {
                          final duration = Duration(
                            hours: e.endHour - e.startHour,
                            minutes: e.endMinute - e.startMinute,
                          );
                          return acc + duration;
                        },
                      );
                      final h = total.inHours;
                      final m = total.inMinutes.remainder(60);
                      var result = '$h hora';
                      if (h != 1) result += 's';
                      if (m > 0) {
                        result += ' y $m minuto';
                        if (m != 1) result += 's';
                      }
                      return result;
                    })(),
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

  void _showPopupMenu(BuildContext context, CourseDetailCubit cubit) {
    showMenu(
      context: context,
      position: RelativeRect.fill,
      items: [
        PopupMenuItem(
          child: Text('Refrescar'),
          onTap: () {
            cubit.fetchSyllabus(forceDownload: true);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Actualizando syllabus...')),
            );
          },
        ),
      ],
    );
  }

  Widget _buildTableInfo(List<List<String>> info) {
    return Column(
      children: info
          .map(
            (e) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(e[0]),
                Text(e[1]),
              ],
            ),
          )
          .toList(),
    );
  }
}
