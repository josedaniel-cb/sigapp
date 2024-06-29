import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigapp/schedule/schedule_cubit.dart';
import 'package:sigapp/schedule/ui/weekly_schedule.dart';
import 'package:sigapp/shared/error_state.dart';
import 'package:sigapp/shared/loading_state.dart';
import 'package:sigapp/student/entities/student_semester_schedule.dart';

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
    return BlocConsumer<ScheduleCubit, ScheduleState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Horario${state.map(
                loading: (_) => '...',
                success: (state) => ' ${state.schedule.semester.name}',
                error: (_) => '',
              )}',
            ),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.calendar_today),
                onPressed: state.map(
                  loading: (_) => null,
                  success: (state) => () => _showModalBottomSheet(state),
                  error: (_) => null,
                ),
              ),
            ],
          ),
          body: state.map(
            loading: (_) => const LoadingStateWidget(),
            success: (state) => _buildSuccessState(context, state),
            error: (state) => ErrorStateWidget(
              message: state.message,
              onRetry: () => _cubit.setup(),
            ),
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
    );
  }

  Widget _buildSuccessState(BuildContext context, SuccessState state) {
    if (state.schedule.weeklyEvents.isEmpty) {
      return const Center(
        child: Text('No disponible'),
      );
    }

    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: WeeklySchedule(
        events: state.schedule.weeklyEvents,
        bottomText: 'Semestre ${state.schedule.semester.name} | Sigapp',
      ),
    );
  }

  void _showModalBottomSheet(SuccessState state) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height / 2,
          child: _buildSemesterList(state),
        );
      },
    );
  }

  Widget _buildSemesterList(SuccessState state) {
    final semesterList = [...state.schedule.semesterList]
      ..sort((a, b) => b.id.compareTo(a.id));

    if (semesterList.isEmpty) {
      return const Center(
        child: Text('No hay semestres disponibles'),
      );
    }

    // Group semesters by year
    final Map<String, List<SemesterScheduleSemesterMetadata>> groupedByYear =
        {};
    for (var semester in semesterList) {
      groupedByYear.putIfAbsent(semester.year, () => []).add(semester);
    }

    // Convert map to list of widgets
    List<Widget> groupedWidgets = [];
    groupedByYear.forEach((year, semesters) {
      if (groupedWidgets.isNotEmpty) {
        groupedWidgets.add(
          const Divider(),
        );
      }
      groupedWidgets.addAll(semesters.map((semester) {
        final enabled = state.schedule.semester.id != semester.id;
        return Center(
          child: ListTile(
            title: Text(
              semester.name,
              textAlign: TextAlign.center,
            ),
            onTap: () {
              _cubit.changeSemester(semester);
              Navigator.pop(context);
            },
            enabled: enabled,
          ),
        );
      }).toList());
    });

    return ListView(
      children: groupedWidgets,
    );
  }
}
