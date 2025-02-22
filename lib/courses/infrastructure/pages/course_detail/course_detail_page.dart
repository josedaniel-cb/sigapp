import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigapp/core/utils/list_utils.dart';
import 'package:sigapp/core/utils/time_utils.dart';
import 'package:sigapp/courses/infrastructure/pages/course_detail/course_detail_cubit.dart';
import 'package:sigapp/student/domain/entities/enrolled_course_data.dart';

class CourseDetailPageWidget extends StatefulWidget {
  const CourseDetailPageWidget({super.key});

  @override
  State<CourseDetailPageWidget> createState() => _CourseDetailPageWidgetState();
}

class _CourseDetailPageWidgetState extends State<CourseDetailPageWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CourseDetailCubit, CourseDetailState>(
      builder: (context, state) {
        return state.map(
          empty: (_) => Container(),
          ready: (state) => Scaffold(
            appBar: AppBar(
              title: Text('Detalle'),
            ),
            body: ListView(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    state.course.data.courseName,
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        title: Text('Tipo'),
                        subtitle:
                            state.course.data.courseType == CourseType.mandatory
                                ? Text('Obligatorio')
                                : Text('Electivo'),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        title: Text('Créditos'),
                        subtitle: Text(state.course.data.credits.toString()),
                      ),
                    ),
                  ],
                ),
                ListTile(
                  title: Text('Syllabus'),
                  subtitle: state.syllabus.map(
                    initial: (_) => Text('Cargando...'),
                    loading: (_) => Text('Cargando...'),
                    loaded: (_) => Text('Descargar syllabus'),
                    notFound: (_) => Text('No se encontró el syllabus'),
                    error: (_) => Text('Error al descargar syllabus'),
                  ),
                ),
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
                Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        title: Text('Grupo'),
                        subtitle: Text(state.course.data.group.toString()),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        title: Text('Sección'),
                        subtitle: Text(state.course.data.section.toString()),
                      ),
                    ),
                  ],
                ),
                ListTile(
                  title: Text('Días'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: state.course.scheduleEvents.map(
                      (e) {
                        final text =
                            '${TimeUtils.weekdayToString(e.weekday)} ${TimeUtils.formatEventDuration(EventDuration(
                          startHour: e.startHour,
                          endHour: e.endHour,
                          endMinute: e.endMinute,
                          startMinute: e.startMinute,
                        ))}';
                        // Capitalize
                        return Text(text[0].toUpperCase() + text.substring(1));
                      },
                    ).toList(),
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
                      return '${total.inHours} horas y ${total.inMinutes.remainder(60)} minutos';
                    })(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
