import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigapp/schedule/schedule_cubit.dart';
import 'package:sigapp/schedule/ui/weekly_calendar.dart';
import 'package:sigapp/shared/error_state.dart';
import 'package:sigapp/shared/loading_state.dart';
import 'package:sigapp/student/models/get_class_schedule.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => SchedulePageState();
}

class SchedulePageState extends State<SchedulePage> {
  late final ScheduleCubit _cubit;

  @override
  void initState() {
    _cubit = BlocProvider.of<ScheduleCubit>(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _cubit.setup();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: BlocConsumer<ScheduleCubit, ScheduleState>(
        builder: (context, state) {
          return state.map(
            loading: (_) => const LoadingStateWidget(),
            success: (state) => _buildSuccessState(context, state),
            error: (state) => ErrorStateWidget(
              message: state.message,
              onRetry: () => _cubit.setup(),
            ),
          );
        },
        listener: (context, state) {
          if (state is SuccessState) {
            // Do something
          } else if (state is ErrorState) {
            // Do something
          }
        },
      ),
    );
  }

  Widget _buildSuccessState(BuildContext context, SuccessState state) {
    List<WeeklyScheduleEvent> events =
        _convertToWeeklyScheduleEvents(state.schedule);
    // return WeeklySchedule(events: events);
    // Set a fixed h and w for the WeeklySchedule because it internally uses a CustomScrollView
    // The h and w must be the available space, use MediaQuery
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: WeeklySchedule(
        events: events,
      ),
    );
  }

  List<WeeklyScheduleEvent> _convertToWeeklyScheduleEvents(
      List<GetClassScheduleModel> schedule) {
    Map<String, Color> courseColors = {};
    List<WeeklyScheduleEvent> events = [];
    List<Color> availableColors = [
      Colors.purple,
      Colors.green,
      Colors.orange,
      Colors.blue,
      Colors.yellow,
      Colors.red,
      Colors.cyan,
      Colors.teal,
      Colors.indigo,
      Colors.pink,
    ];

    Color getCourseColor(String course) {
      if (!courseColors.containsKey(course)) {
        courseColors[course] =
            availableColors[courseColors.length % availableColors.length];
      }
      return courseColors[course]!;
    }

    for (var item in schedule) {
      DateTime startTime = _convertToDateTime(item.HoraInicio);
      DateTime endTime = _convertToDateTime(item.HoraFinal);

      if (item.Lunes.isNotEmpty) {
        events.add(WeeklyScheduleEvent(
          title: item.Lunes,
          start: _getDateTimeForDay(startTime, DateTime.monday),
          end: _getDateTimeForDay(endTime, DateTime.monday),
          color: getCourseColor(item.Lunes),
        ));
      }
      if (item.Martes.isNotEmpty) {
        events.add(WeeklyScheduleEvent(
          title: item.Martes,
          start: _getDateTimeForDay(startTime, DateTime.tuesday),
          end: _getDateTimeForDay(endTime, DateTime.tuesday),
          color: getCourseColor(item.Martes),
        ));
      }
      if (item.Miercoles.isNotEmpty) {
        events.add(WeeklyScheduleEvent(
          title: item.Miercoles,
          start: _getDateTimeForDay(startTime, DateTime.wednesday),
          end: _getDateTimeForDay(endTime, DateTime.wednesday),
          color: getCourseColor(item.Miercoles),
        ));
      }
      if (item.Jueves.isNotEmpty) {
        events.add(WeeklyScheduleEvent(
          title: item.Jueves,
          start: _getDateTimeForDay(startTime, DateTime.thursday),
          end: _getDateTimeForDay(endTime, DateTime.thursday),
          color: getCourseColor(item.Jueves),
        ));
      }
      if (item.Viernes.isNotEmpty) {
        events.add(WeeklyScheduleEvent(
          title: item.Viernes,
          start: _getDateTimeForDay(startTime, DateTime.friday),
          end: _getDateTimeForDay(endTime, DateTime.friday),
          color: getCourseColor(item.Viernes),
        ));
      }
      if (item.Sabado.isNotEmpty) {
        events.add(WeeklyScheduleEvent(
          title: item.Sabado,
          start: _getDateTimeForDay(startTime, DateTime.saturday),
          end: _getDateTimeForDay(endTime, DateTime.saturday),
          color: getCourseColor(item.Sabado),
        ));
      }
    }
    return events;
  }

  DateTime _getDateTimeForDay(DateTime time, int weekday) {
    DateTime now = DateTime.now();
    int currentWeekday = now.weekday;
    int daysToAdd = (weekday - currentWeekday) % 7;
    if (daysToAdd < 0) daysToAdd += 7;
    return DateTime(
      now.year,
      now.month,
      now.day + daysToAdd,
      time.hour,
      time.minute,
    );
  }

  DateTime _convertToDateTime(String timestamp) {
    final regex = RegExp(r'\/Date\((\d+)\)\/');
    final match = regex.firstMatch(timestamp);
    if (match != null) {
      final milliseconds = int.parse(match.group(1)!);
      return DateTime.fromMillisecondsSinceEpoch(milliseconds);
    }
    throw FormatException("Invalid timestamp format");
  }
}
