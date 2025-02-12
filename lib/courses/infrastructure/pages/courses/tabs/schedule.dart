import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sigapp/core/widgets/error_state.dart';
import 'package:sigapp/core/widgets/loading_state.dart';
import 'package:sigapp/courses/infrastructure/pages/courses/tabs/schedule_cubit.dart';
import 'package:sigapp/core/not_used/schedule_page/partials/weekly_schedule.dart';

class ScheduleTabWidget extends StatefulWidget {
  const ScheduleTabWidget({super.key});

  @override
  State<ScheduleTabWidget> createState() => _ScheduleTabWidgetState();
}

class _ScheduleTabWidgetState extends State<ScheduleTabWidget>
    with TickerProviderStateMixin {
  late final ScheduleTabCubit _cubit;

  @override
  void initState() {
    _cubit = BlocProvider.of<ScheduleTabCubit>(context);
    // _cubit.fetch(widget.semester);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ScheduleTabCubit, ScheduleTabState>(
      builder: (context, state) {
        return state.map(
          loading: (_) => LoadingStateWidget(),
          error: (state) => ErrorStateWidget(
            message: state.message,
            onRetry: () => _cubit.retry(),
          ),
          success: (state) => _buildSuccessState(state),
        );
      },
      listener: (context, state) {
        if (state is ScheduleTabSuccessState) {
          if (state.errorMessage != null &&
              state.errorMessageWasShown == false) {
            ScaffoldMessenger.of(context)
                .showSnackBar(
                  SnackBar(
                    content: Text(state.errorMessage!),
                  ),
                )
                .closed
                .then((_) {
              _cubit.setErrorMessageAsShown();
            });
          }
        }
      },
    );
  }

  Widget _buildSuccessState(ScheduleTabSuccessState state) {
    if (state.scheduleEvents.isEmpty) {
      return _buildEmpty();
    }

    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            WeeklySchedule(
              events: state.scheduleEvents,
            ),
          ],
        ),
      ),
      floatingActionButton: state.loadingShare
          ? FloatingActionButton(
              onPressed: null,
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(),
              ),
            )
          : FloatingActionButton(
              onPressed: () => _captureAndShare(state),
              child: Icon(Icons.share),
            ),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.schedule, size: 80, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            "No tienes cursos inscritos este semestre",
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  ScreenshotController screenshotController = ScreenshotController();

  Future<void> _captureAndShare(ScheduleTabSuccessState state) async {
    /// https://stackoverflow.com/a/57054302
    double _pixelsToDIP(BuildContext context, double pixels) {
      final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
      return pixels / devicePixelRatio;
    }

    _cubit.updateRenderingImageForSharing(true);

    try {
      final Uint8List image = await screenshotController.captureFromWidget(
        SizedBox(
          width: _pixelsToDIP(context, 1920),
          child: WeeklySchedule(
            events: state.scheduleEvents,
            topLeftText: 'Semestre ${state.selectedSemester.name}',
            topRightText: 'Sigapp',
            bottomLeftText:
                '${state.academicReport.firstName} ${state.academicReport.lastName}',
            bottomRightText:
                'Promoción ${state.academicReport.cohort}, ${state.academicReport.school}',
            disableScroll: true,
            fontSize: _pixelsToDIP(context, 40),
            hourWidth: _pixelsToDIP(context, 200),
            rowHeight: _pixelsToDIP(context, 200),
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

      final directory = await getApplicationDocumentsDirectory();
      final imagePath =
          await File('${directory.path}/schedule_capture.png').create();
      await imagePath.writeAsBytes(image);

      _cubit.updateRenderingImageForSharing(false);

      // Updated to use shareXFiles for sharing files
      final result = await Share.shareXFiles([XFile(imagePath.path)],
          text: 'Check out this image!');

      // Handling the result of sharing
      if (result.status == ShareResultStatus.success) {
        if (kDebugMode) {
          print('Image shared successfully!');
        }
      } else if (result.status == ShareResultStatus.dismissed) {
        if (kDebugMode) {
          print('Share dismissed.');
        }
      }
    } catch (e, s) {
      if (kDebugMode) {
        print(e);
        print(s);
      }
      _cubit.updateRenderingImageForSharing(false);

      _cubit.showErrorMessage(
          'Ocurrió un error al intentar compartir el horario. Por favor, inténtalo de nuevo.');
    }
  }
}
