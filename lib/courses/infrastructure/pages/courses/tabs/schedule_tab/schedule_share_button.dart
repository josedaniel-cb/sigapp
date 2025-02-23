import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sigapp/core/ui/widgets/brand_text.dart';
import 'package:sigapp/courses/infrastructure/pages/courses/tabs/schedule_tab/weekly_schedule.dart';
import 'package:sigapp/courses/infrastructure/pages/courses/tabs/schedule_tab/schedule_share_button_cubit.dart';
import 'package:sigapp/student/domain/entities/student_academic_report.dart';
import 'package:sigapp/student/domain/entities/student_semester_schedule.dart';
import 'package:sigapp/student/domain/value_objects/enrolled_course.dart';

class ScheduleShareButtonWidget extends StatefulWidget {
  const ScheduleShareButtonWidget({
    super.key,
    required this.enrolledCourses,
    required this.selectedSemester,
    required this.academicReport,
  });

  final List<EnrolledCourse> enrolledCourses;
  final SemesterScheduleSemesterMetadata selectedSemester;
  final AcademicReport academicReport;

  @override
  State<ScheduleShareButtonWidget> createState() =>
      _ScheduleShareButtonWidgetState();
}

class _ScheduleShareButtonWidgetState extends State<ScheduleShareButtonWidget> {
  late final ScheduleShareButtonCubit _cubit;

  @override
  void initState() {
    _cubit = BlocProvider.of<ScheduleShareButtonCubit>(context);
    // _cubit.fetch(widget.semester);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ScheduleShareButtonCubit, ScheduleShareButtonState>(
      builder: (context, state) {
        return state.loadingShare
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
              );
      },
      listener: (context, state) {
        if (state.errorMessage != null && state.errorMessageWasShown == false) {
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
      },
    );
  }

  ScreenshotController screenshotController = ScreenshotController();

  Future<void> _captureAndShare(ScheduleShareButtonState state) async {
    /// https://stackoverflow.com/a/57054302
    double pixelsToDIP(BuildContext context, double pixels) {
      final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
      return pixels / devicePixelRatio;
    }

    _cubit.updateRenderingImageForSharing(true);

    try {
      final Uint8List image = await screenshotController.captureFromWidget(
        SizedBox(
          width: pixelsToDIP(context, 1920),
          child: WeeklyScheduleWidget(
            courses: widget.enrolledCourses,
            topLeft: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BrandTextWidget(),
                Text(
                  'Horario ${widget.selectedSemester.name}',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            ),
            bottomLeft: Text(
                '${widget.academicReport.firstName} ${widget.academicReport.lastName}'),
            bottomRight: Text(
                '${widget.academicReport.school} - Promoción ${widget.academicReport.cohort}'),
            disableScroll: true,
            fontSize: pixelsToDIP(context, 40),
            hourWidth: pixelsToDIP(context, 200),
            rowHeight: pixelsToDIP(context, 200),
          ),
        ),
        context: context,
        pixelRatio: MediaQuery.of(context).devicePixelRatio,
        targetSize: Size(
          pixelsToDIP(context, 1920),
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
