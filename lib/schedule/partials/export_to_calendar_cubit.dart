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
    // required DateTime startDate,
    // required DateTime endDate,
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
          throw Exception('No se han concedido los permisos necesarios');
        }
      }

      final calendarsResult = await _deviceCalendarPlugin.retrieveCalendars();

      if (kDebugMode) {
        print('founed calendars: ${calendarsResult.data?.length}');
        for (final calendar in calendarsResult.data!) {
          print('calendar: ${calendar.name}');
        }
      }

      // final now = DateTime.now();
      emit(
        ExportToCalendarState.success(
          calendars: calendarsResult.data!,
          selectedCalendar: calendarsResult.data!.first,
          // startDate: now,
          // endDate: DateTime(now.year, now.month + 1, 0),
        ),
      );
    } catch (e, s) {
      if (kDebugMode) {
        print(e);
        print(s);
      }
      emit(ExportToCalendarState.error(e.toString()));
    }
  }

  /// Export the list of [weeklyEvents] to the selected calendar.
  Future<void> export({
    required List<WeeklyScheduleEvent> weeklyEvents,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final successState = state as SuccessState;

    // Remove all existing events from the calendar
    await _removeAllEventsFromCalendar();

    // Iterate through each weekly event
    for (final weeklyEvent in weeklyEvents) {
      // Convert startDate and endDate to the same weekday as the event for comparison
      final eventStartDate = startDate
          .add(Duration(days: (weeklyEvent.weekday - startDate.weekday) % 7));
      final eventEndDate = endDate
          .add(Duration(days: (weeklyEvent.weekday - endDate.weekday) % 7));

      // Check if the weekday of the event is within the selected date range
      final weekdayIsInRange =
          eventStartDate.isBefore(endDate) && eventEndDate.isAfter(startDate);

      if (!weekdayIsInRange) {
        if (kDebugMode) {
          print('weekday is out of range: ${weeklyEvent.weekday}');
          print('startDate: ${startDate.weekday}');
          print('endDate: ${endDate.weekday}');
          print(weeklyEvent);
        }
        continue;
      }

      // Calculate the date and time for the event
      final date = startDate
          .add(Duration(days: weeklyEvent.weekday - startDate.weekday));
      final start = date.copyWith(
        hour: weeklyEvent.startHour,
        minute: weeklyEvent.startMinute,
      );
      final end = date.copyWith(
        hour: weeklyEvent.endHour,
        minute: weeklyEvent.endMinute,
      );

      // Create the event object
      final event = Event(
        successState.selectedCalendar.id,
        eventId: weeklyEvent.id,
        title: weeklyEvent.title,
        start: TZDateTime.from(start, local),
        end: TZDateTime.from(end, local),
        location: weeklyEvent.location,
        recurrenceRule: RecurrenceRule(
          RecurrenceFrequency.Weekly,
          endDate: endDate,
        ),
      );

      if (kDebugMode) {
        print(event.eventId);
      }

      // Create or update the event in the calendar
      final result = await _deviceCalendarPlugin.createOrUpdateEvent(event);

      if (result != null && result.isSuccess) {
        if (kDebugMode) {
          print('Evento creado con éxito');
          print('Evento ID: ${result.data}');
          print('Evento: $event');
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

  // void selectDateRange(DateTime start, DateTime end) {
  //   if (state is! SuccessState) {
  //     return;
  //   }

  //   emit((state as SuccessState).copyWith(startDate: start, endDate: end));
  // }
}
