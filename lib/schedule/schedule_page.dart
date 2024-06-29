import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
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
                    // ? () => _showShareBottomSheet(state)
                    ? () => captureAndShare2(state)
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

  /// https://stackoverflow.com/a/57054302
  double _pixelsToDIP(BuildContext context, double pixels) {
    final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    return pixels / devicePixelRatio;
  }

  ScreenshotController screenshotController = ScreenshotController();

  void _showShareBottomSheet(SuccessState state) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () => captureAndShare(),
                child: const Text('Compartir'),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 2,
                child: InteractiveViewer(
                  constrained: false,
                  minScale: 1,
                  maxScale: 3,
                  child: Screenshot(
                    controller: screenshotController,
                    child: SizedBox(
                      width: _pixelsToDIP(context, 1920),
                      child: WeeklySchedule(
                        events: state.schedule.weeklyEvents,
                        bottomText:
                            'Semestre ${state.schedule.semester.name} | Sigapp',
                        disableScroll: true,
                        fontSize: _pixelsToDIP(context, 40),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> captureAndShare() async {
    final Uint8List? image = await screenshotController.capture();

    if (image != null) {
      final directory = await getApplicationDocumentsDirectory();
      final imagePath = await File('${directory.path}/image.png').create();
      await imagePath.writeAsBytes(image);

      // Updated to use shareXFiles for sharing files
      final result = await Share.shareXFiles([XFile(imagePath.path)],
          text: 'Check out this image!');

      // Handling the result of sharing
      if (result.status == ShareResultStatus.success) {
        print('Image shared successfully!');
      } else if (result.status == ShareResultStatus.dismissed) {
        print('Share dismissed.');
      }
    }
  }

  Future<void> captureAndShare2(SuccessState state) async {
    final Uint8List? image = await screenshotController.captureFromWidget(
      SizedBox(
        width: _pixelsToDIP(context, 1920),
        child: WeeklySchedule(
          events: state.schedule.weeklyEvents,
          bottomText: 'Semestre ${state.schedule.semester.name} | Sigapp',
          disableScroll: true,
          fontSize: _pixelsToDIP(context, 40),
        ),
      ),
      context: context,
      pixelRatio: MediaQuery.of(context).devicePixelRatio,
      targetSize: Size(
        _pixelsToDIP(context, 1920),
        // _pixelsToDIP(context, 1920),
        double.infinity,
      ),
    );

    if (image != null) {
      final directory = await getApplicationDocumentsDirectory();
      final imagePath = await File('${directory.path}/image.png').create();
      await imagePath.writeAsBytes(image);

      // Updated to use shareXFiles for sharing files
      final result = await Share.shareXFiles([XFile(imagePath.path)],
          text: 'Check out this image!');

      // Handling the result of sharing
      if (result.status == ShareResultStatus.success) {
        print('Image shared successfully!');
      } else if (result.status == ShareResultStatus.dismissed) {
        print('Share dismissed.');
      }
    }
  }
}
