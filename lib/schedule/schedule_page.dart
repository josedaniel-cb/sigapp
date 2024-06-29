import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigapp/schedule/schedule_cubit.dart';
import 'package:sigapp/schedule/ui/schedule_semester_select.dart';
import 'package:sigapp/schedule/ui/weekly_schedule.dart';
import 'package:sigapp/shared/error_state.dart';
import 'package:sigapp/shared/loading_state.dart';

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
                icon: const Icon(Icons.share),
                onPressed: (state is SuccessState &&
                        state.schedule.semesterList.isNotEmpty)
                    ? () => _showShareBottomSheet(state)
                    : null,
              ),
              IconButton(
                icon: const Icon(Icons.calendar_today),
                onPressed: state is SuccessState
                    ? () => _showModalBottomSheet(state)
                    : null,
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
        // bottomText: 'Semestre ${state.schedule.semester.name} | Sigapp',
      ),
    );
  }

  void _showModalBottomSheet(SuccessState state) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height / 2,
          child: ScheduleSemesterSelect(
            onSemesterSelected: (semester) {
              _cubit.changeSemester(semester);
              Navigator.pop(context);
            },
            schedule: state.schedule,
          ),
        );
      },
    );
  }

  void _showShareBottomSheet(SuccessState state) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height / 2,
          child: InteractiveViewer(
            constrained:
                false, // Allow the child to be bigger than the viewport
            minScale: 1,
            maxScale: 3,
            // panEnabled: true, // This is the default, but just to be explicit
            child: SizedBox(
              width: MediaQuery.of(context).size.height,
              height: MediaQuery.of(context).size.height,
              child: WeeklySchedule(
                events: state.schedule.weeklyEvents,
                bottomText: 'Semestre ${state.schedule.semester.name} | Sigapp',
                disableScroll:
                    true, // Consider adjusting if this interferes with desired behavior
              ),
            ),
          ),
        );
      },
    );
  }
}
