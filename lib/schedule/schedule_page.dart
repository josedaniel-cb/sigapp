import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigapp/schedule/schedule_cubit.dart';
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
                success: (state) => ' ${state.schedule.semester}',
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
    final semesterList = state.schedule.semesterList;
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: WeeklySchedule(
        events: state.schedule.weeklyEvents,
        bottomText:
            'Semestre ${state.schedule.semester.substring(0, 4)}-${state.schedule.semester.substring(4)} | Sigapp',
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
    return ListView.builder(
      itemCount: state.schedule.semesterList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(state.schedule.semesterList[index]),
          onTap: () {
            _cubit.changeSemester(state.schedule.semesterList[index]);
            Navigator.pop(context);
          },
        );
      },
    );
  }
}
