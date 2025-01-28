import 'dart:io';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sigapp/courses/infrastructure/pages/schedule/partials/export_to_calendar.dart';
import 'package:sigapp/courses/infrastructure/pages/schedule/schedule_cubit.dart';
import 'package:sigapp/courses/infrastructure/pages/schedule/partials/schedule_semester_select.dart';
import 'package:sigapp/courses/infrastructure/pages/schedule/partials/weekly_schedule.dart';
import 'package:sigapp/core/widgets/error_state.dart';
import 'package:sigapp/core/widgets/loading_state.dart';

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
                loading: (_) => '',
                success: (state) => ' ${state.schedule.semester.name}',
                error: (_) => '',
              )}',
            ),
            actions: <Widget>[
              IconButton(
                icon: (state is SuccessState && state.loadingChangeSemester)
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(),
                      )
                    : const Icon(Icons.calendar_today),
                onPressed: (state is SuccessState &&
                        !state.loadingChangeSemester &&
                        !state.loadingShare)
                    ? () => _showModalBottomSheet(state)
                    : null,
              ),
              // Build a "three dots" menu
              PopupMenuButton<String>(
                enabled: state is SuccessState,
                offset: const Offset(0, 50),
                onSelected: (String value) {
                  if (value == 'export' && state is SuccessState) {
                    _exportToCalendar(context, state);
                  }
                },
                itemBuilder: (BuildContext context) {
                  return <PopupMenuEntry<String>>[
                    const PopupMenuItem<String>(
                      value: 'export',
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Exportar a calendario'),
                          Icon(Icons.calendar_month),
                        ],
                      ),
                    ),
                  ];
                },
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
          floatingActionButton: state is SuccessState
              ? FloatingActionButton(
                  onPressed: (state.schedule.semesterList.isNotEmpty &&
                          !state.loadingShare &&
                          !state.loadingChangeSemester)
                      ? () => _captureAndShare(state)
                      : null,
                  child: (state.loadingShare)
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(),
                        )
                      : const Icon(Icons.share),
                )
              : null,
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

  Future<void> _exportToCalendar(
      BuildContext context, SuccessState state) async {
    final config = _buildCalendarDatePicker2Dialog();
    final now = DateTime.now();
    final values = await showCalendarDatePicker2Dialog(
      context: context,
      config: config,
      dialogSize: const Size(325, 370),
      borderRadius: BorderRadius.circular(15),
      value: [
        DateTime(now.year, now.month, 1),
        DateTime(now.year, now.month + 1, 0),
      ],
      dialogBackgroundColor: Colors.white,
    );
    if (values != null) {
      showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (context) {
          return AlertDialog(
            content: ExportToCalendar(
              startDate: values[0]!,
              endDate: values[1]!,
              weeklyEvents: state.schedule.weeklyEvents,
            ),
          );
        },
      );
    }
  }

  CalendarDatePicker2WithActionButtonsConfig _buildCalendarDatePicker2Dialog() {
    final theme = Theme.of(context);
    final dayTextStyle =
        theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700);
    final weekendTextStyle = theme.textTheme.bodyLarge
        ?.copyWith(color: theme.hintColor, fontWeight: FontWeight.w600);
    final anniversaryTextStyle = theme.textTheme.bodyLarge?.copyWith(
      color: theme.colorScheme.error,
      fontWeight: FontWeight.w700,
      decoration: TextDecoration.underline,
    );

    return CalendarDatePicker2WithActionButtonsConfig(
      calendarViewScrollPhysics: const NeverScrollableScrollPhysics(),
      dayTextStyle: dayTextStyle,
      calendarType: CalendarDatePicker2Type.range,
      selectedDayHighlightColor: theme.colorScheme.primary,
      closeDialogOnCancelTapped: true,
      firstDayOfWeek: 1,
      weekdayLabelTextStyle: theme.textTheme.bodyLarge?.copyWith(
        color: theme.colorScheme.onSurface,
        fontWeight: FontWeight.bold,
      ),
      controlsTextStyle: theme.textTheme.bodyLarge?.copyWith(
        color: theme.colorScheme.onSurface,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
      centerAlignModePicker: true,
      customModePickerIcon: const SizedBox(),
      selectedDayTextStyle:
          dayTextStyle?.copyWith(color: theme.colorScheme.onPrimary),
      dayTextStylePredicate: ({required date}) {
        TextStyle? textStyle;
        if (date.weekday == DateTime.saturday ||
            date.weekday == DateTime.sunday) {
          textStyle = weekendTextStyle;
        }
        if (DateUtils.isSameDay(date, DateTime(2021, 1, 25))) {
          textStyle = anniversaryTextStyle;
        }
        return textStyle;
      },
      dayBuilder: ({
        required date,
        textStyle,
        decoration,
        isSelected,
        isDisabled,
        isToday,
      }) {
        Widget? dayWidget;
        if (date.day % 3 == 0 && date.day % 9 != 0) {
          dayWidget = Container(
            decoration: decoration,
            child: Center(
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Text(
                    MaterialLocalizations.of(context).formatDecimal(date.day),
                    style: textStyle,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 27.5),
                    child: Container(
                      height: 4,
                      width: 4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: isSelected == true
                            ? theme.colorScheme.onPrimary
                            : theme.hintColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return dayWidget;
      },
      yearBuilder: ({
        required year,
        decoration,
        isCurrentYear,
        isDisabled,
        isSelected,
        textStyle,
      }) {
        return Center(
          child: Container(
            decoration: decoration,
            height: 36,
            width: 72,
            child: Center(
              child: Semantics(
                selected: isSelected,
                button: true,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      year.toString(),
                      style: textStyle,
                    ),
                    if (isCurrentYear == true)
                      Container(
                        padding: const EdgeInsets.all(5),
                        margin: const EdgeInsets.only(left: 5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: theme.colorScheme.error,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
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
      child: Stack(
        children: [
          WeeklySchedule(
            events: state.schedule.weeklyEvents,
          ),
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
