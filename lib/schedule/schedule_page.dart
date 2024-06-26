import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigapp/schedule/schedule_cubit.dart';
import 'package:sigapp/schedule/ui/weekly_schedule.dart';
import 'package:sigapp/shared/error_state.dart';
import 'package:sigapp/shared/loading_state.dart';
import 'package:sigapp/student/entities/weekly_schedule_event.dart';

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
        title: const Text('Horario'),
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
    List<WeeklyScheduleEvent> events = state.schedule.weeklyEvents;
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
}
