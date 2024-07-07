import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sigapp/schedule/schedule_cubit.dart';
import 'package:sigapp/schedule/ui/schedule_semester_select.dart';
import 'package:sigapp/schedule/ui/weekly_schedule.dart';
import 'package:sigapp/shared/error_state.dart';
import 'package:sigapp/shared/loading_state.dart';
import 'package:device_calendar/device_calendar.dart';
import 'package:sigapp/student/entities/student_semester_schedule.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => SchedulePageState();
}

class SchedulePageState extends State<SchedulePage> {
  late final ScheduleCubit _cubit;
  final DeviceCalendarPlugin _deviceCalendarPlugin = DeviceCalendarPlugin();
  Calendar? _calendar;

  @override
  void initState() {
    _cubit = BlocProvider.of<ScheduleCubit>(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _cubit.setup();
    });

    super.initState();

    _retrieveCalendars();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ScheduleCubit, ScheduleState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Horario${state.map(
                loading: (_) => '',
                success: (state) => ' ${state.schedule.semester.name}',
                error: (_) => '',
              )}',
            ),
            actions: <Widget>[
              IconButton(
                icon:
                    (state is SuccessState && (state.renderingImageForSharing))
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(),
                          )
                        : const Icon(Icons.share),
                onPressed: (state is SuccessState &&
                        state.schedule.semesterList.isNotEmpty &&
                        !state.renderingImageForSharing &&
                        !state.changingSemester)
                    ? () => _captureAndShare(state)
                    : null,
              ),
              IconButton(
                icon: (state is SuccessState && state.changingSemester)
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(),
                      )
                    : const Icon(Icons.list),
                // : const Icon(Icons.schedule),
                // : const Icon(Icons.history),
                onPressed: (state is SuccessState &&
                        !state.changingSemester &&
                        !state.renderingImageForSharing)
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
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (state is SuccessState) {
                _insertEvent(state.schedule);
              }
            },
            child: const Icon(Icons.calendar_today),
          ),
        );
      },
      listener: (context, state) {
        if (state is SuccessState) {
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
        } else if (state is ErrorState) {
          // Do something
        }
      },
    );
  }

  Future<void> _retrieveCalendars() async {
    try {
      var permissionsGranted = await _deviceCalendarPlugin.hasPermissions();
      if (permissionsGranted.isSuccess && !permissionsGranted.data!) {
        permissionsGranted = await _deviceCalendarPlugin.requestPermissions();
        if (!permissionsGranted.isSuccess || !permissionsGranted.data!) {
          return;
        }
      }

      final calendarsResult = await _deviceCalendarPlugin.retrieveCalendars();

      if (kDebugMode) {
        print('founed calendars: ${calendarsResult.data?.length}');
        for (final calendar in calendarsResult.data!) {
          print('calendar: ${calendar.name}');
        }
      }
      _calendar = calendarsResult.data?.first;
    } catch (e, s) {
      if (kDebugMode) {
        print(e);
        print(s);
      }
    }
  }

  Future<void> _insertEvent(SemesterSchedule semesterSchedule) async {
    if (_calendar == null) return;

    // Delete all events from the calendar
    await _removeAllEventsFromCalendar();

    // use semesterSchedule to create events for the current week
    for (final weeklyEvent in semesterSchedule.weeklyEvents) {
      final event = Event(
        _calendar!.id,
        eventId: weeklyEvent.id,
        title: weeklyEvent.title,
        description: weeklyEvent.place,
        start: TZDateTime.from(weeklyEvent.start, local),
        end: TZDateTime.from(weeklyEvent.end, local),
      );
      if (kDebugMode) {
        print(event.eventId);
      }
      final result = await _deviceCalendarPlugin.createOrUpdateEvent(event);

      if (result != null && result.isSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Evento creado con éxito'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error al crear el evento'),
          ),
        );
      }
    }
  }

  Future<void> _removeAllEventsFromCalendar() async {
    final events = await _deviceCalendarPlugin.retrieveEvents(
      _calendar!.id,
      RetrieveEventsParams(
        startDate: DateTime.now().subtract(const Duration(days: 14)),
        endDate: DateTime.now().add(const Duration(days: 14)),
      ),
    );
    if (events.errors.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Error al obtener eventos: ${events.errors.map((e) => '(${e.errorCode}) ${e.errorMessage}').join(', ')}'),
        ),
      );
      return;
    }
    var successCount = 0;
    var errorCount = 0;
    for (final event in events.data ?? []) {
      final result = await _deviceCalendarPlugin.deleteEvent(
        _calendar!.id,
        event.eventId,
      );
      if (result.isSuccess) {
        successCount++;
      } else {
        if (kDebugMode) {
          print(
              'Error deleting event: ${result.errors.map((e) => '(${e.errorCode}) ${e.errorMessage}').join(', ')}');
        }
        errorCount++;
      }
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            'Se eliminaron $successCount eventos con éxito, $errorCount errores.'),
      ),
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
      child: Stack(
        children: [
          WeeklySchedule(
            events: state.schedule.weeklyEvents,
          ),
          // if (state.busy)
          //   Container(
          //     alignment: Alignment.center,
          //     color: Colors.white30,
          //     child: const CircularProgressIndicator(),
          //   ),
        ],
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

  Future<void> _captureAndShare(SuccessState state) async {
    _cubit.updateRenderingImageForSharing(true);

    try {
      final Uint8List image = await screenshotController.captureFromWidget(
        SizedBox(
          width: _pixelsToDIP(context, 1920),
          child: WeeklySchedule(
            events: state.schedule.weeklyEvents,
            topLeftText: 'Semestre ${state.schedule.semester.name}',
            topRightText: 'Sigapp',
            bottomLeftText:
                '${state.schedule.studentAcademicReport.firstName} ${state.schedule.studentAcademicReport.lastName}',
            bottomRightText:
                'Promoción ${state.schedule.studentAcademicReport.cohort}, ${state.schedule.studentAcademicReport.school}',
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

      final directory = await getApplicationDocumentsDirectory();
      final imagePath = await File('${directory.path}/image.png').create();
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
