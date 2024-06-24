import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigapp/schedule/schedule_cubit.dart';
import 'package:sigapp/schedule/ui/weekly_calendar.dart';
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

  Widget _buildSuccessState(
    BuildContext context,
    SuccessState state,
  ) {
    return WeeklySchedule(
      events: [
        WeeklyScheduleEvent(
          title: 'Plan Execution',
          start: DateTime(2024, 6, 24, 9),
          end: DateTime(2024, 6, 24, 10),
          color: Colors.purple,
        ),
        WeeklyScheduleEvent(
          title: 'General Meeting',
          start: DateTime(2024, 6, 24, 12),
          end: DateTime(2024, 6, 24, 13),
          color: Colors.blue,
        ),
        WeeklyScheduleEvent(
          title: 'Development',
          start: DateTime(2024, 6, 24, 10),
          end: DateTime(2024, 6, 24, 11),
          color: Colors.green,
        ),
      ],
    );
  }
}
