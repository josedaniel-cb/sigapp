import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:sigapp/student/entities/weekly_schedule_event.dart';

part 'export_to_calendar_cubit.freezed.dart';

@freezed
abstract class ExportToCalendarState with _$ExportToCalendarState {
  const factory ExportToCalendarState.loading() = LoadingState;
  const factory ExportToCalendarState.success({
    required List<Calendar> calendars,
    required Calendar selectedCalendar,
  }) = SuccessState;
  const factory ExportToCalendarState.error(String message) = ErrorState;
}

@injectable
class ExportToCalendarCubit extends Cubit<ExportToCalendarState> {
  final DeviceCalendarPlugin _deviceCalendarPlugin = DeviceCalendarPlugin();

  ExportToCalendarCubit() : super(const ExportToCalendarState.loading());

  Future<void> setup() async {
    emit(const ExportToCalendarState.loading());
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

      emit(ExportToCalendarState.success(
        calendars: calendarsResult.data!,
        selectedCalendar: calendarsResult.data!.first,
      ));
    } catch (e, s) {
      if (kDebugMode) {
        print(e);
        print(s);
      }
      emit(ExportToCalendarState.error(e.toString()));
    }
  }

  Future<void> export(List<WeeklyScheduleEvent> weeklyEvents) async {
    final successState = state as SuccessState;

    // Delete all events from the calendar
    await _removeAllEventsFromCalendar();

    // use semesterSchedule to create events for the current week
    for (final weeklyEvent in weeklyEvents) {
      final event = Event(
        successState.selectedCalendar.id,
        eventId: weeklyEvent.id,
        title: weeklyEvent.title,
        // description: weeklyEvent.place,
        start: TZDateTime.from(weeklyEvent.start, local),
        end: TZDateTime.from(weeklyEvent.end, local),
        location: weeklyEvent.place,
      );
      if (kDebugMode) {
        print(event.eventId);
      }
      final result = await _deviceCalendarPlugin.createOrUpdateEvent(event);

      if (result != null && result.isSuccess) {
        if (kDebugMode) {
          print('Evento creado con éxito');
        }
      } else {
        throw Exception('Error al crear el evento');
      }
    }
  }

  void selectCalendar(Calendar calendar) {
    if (state is! SuccessState) {
      return;
    }

    emit((state as SuccessState).copyWith(selectedCalendar: calendar));
  }

  Future<void> _removeAllEventsFromCalendar() async {
    if (state is! SuccessState) {
      return;
    }

    final successState = state as SuccessState;

    final events = await _deviceCalendarPlugin.retrieveEvents(
      successState.selectedCalendar.id,
      RetrieveEventsParams(
        startDate: DateTime.now().subtract(const Duration(days: 14)),
        endDate: DateTime.now().add(const Duration(days: 14)),
      ),
    );
    if (events.errors.isNotEmpty) {
      throw Exception(
          'Error al obtener eventos: ${events.errors.map((e) => '(${e.errorCode}) ${e.errorMessage}').join(', ')}');
    }
    var successCount = 0;
    var errorCount = 0;
    for (final Event event in events.data ?? []) {
      final result = await _deviceCalendarPlugin.deleteEvent(
        successState.selectedCalendar.id,
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
    if (kDebugMode) {
      print(
          'Se eliminaron $successCount eventos con éxito, $errorCount errores.');
    }
  }
}
