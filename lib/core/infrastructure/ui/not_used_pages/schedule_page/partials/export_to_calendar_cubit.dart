import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:sigapp/courses/application/usecases/get_class_schedule_usecase.dart';
import 'package:sigapp/student/domain/entities/weekly_schedule_event.dart';

part 'export_to_calendar_cubit.freezed.dart';

@freezed
sealed class ExportToCalendarState with _$ExportToCalendarState {
  const factory ExportToCalendarState.loading() = LoadingState;
  const factory ExportToCalendarState.success({
    required List<Calendar> calendars,
    required Calendar selectedCalendar,
    // required DateTime startDate,
    // required DateTime endDate,
  }) = SuccessState;
  // TODO: must be `dynamic error`
  const factory ExportToCalendarState.error(String message) = ErrorState;
}

@injectable
class ExportToCalendarCubit extends Cubit<ExportToCalendarState> {
  final DeviceCalendarPlugin _deviceCalendarPlugin = DeviceCalendarPlugin();
  final GetClassScheduleUsecase _getClassScheduleUsecase;
  final Logger _logger;

  ExportToCalendarCubit(this._getClassScheduleUsecase, this._logger)
    : super(const ExportToCalendarState.loading());

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

      _logger.d('[UI] Found calendars: \\${calendarsResult.data?.length}');
      for (final calendar in calendarsResult.data!) {
        _logger.d('[UI] Calendar: \\${calendar.name}');
      }

      emit(
        ExportToCalendarState.success(
          calendars: calendarsResult.data!,
          selectedCalendar: calendarsResult.data!.first,
        ),
      );
    } catch (e, s) {
      _logger.e(
        '[UI] Error in ExportToCalendarCubit.setup',
        error: e,
        stackTrace: s,
      );
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
    await _removeEventsFromCalendar();
    // await _removeEventsFromCalendar(clearCalendar: true);
    // return;

    // Iterate through each weekly event
    for (final weeklyEvent in weeklyEvents) {
      // Convert startDate and endDate to the same weekday as the event for comparison
      final eventStartDate = startDate.add(
        Duration(days: (weeklyEvent.weekday - startDate.weekday) % 7),
      );
      final eventEndDate = endDate.add(
        Duration(days: (weeklyEvent.weekday - endDate.weekday) % 7),
      );

      // Check if the weekday of the event is within the selected date range
      final weekdayIsInRange =
          eventStartDate.isBefore(endDate) && eventEndDate.isAfter(startDate);

      if (!weekdayIsInRange) {
        _logger.d(
          '[UI] Weekday out of range: \\${weeklyEvent.weekday}, startDate: \\${startDate.weekday}, endDate: \\${endDate.weekday}, event: \\$weeklyEvent',
        );
        continue;
      }

      // Calculate the date and time for the event
      final date = startDate.add(
        Duration(days: weeklyEvent.weekday - startDate.weekday),
      );
      final start = date.copyWith(
        hour: weeklyEvent.startHour,
        minute: weeklyEvent.startMinutes,
      );
      final end = date.copyWith(
        hour: weeklyEvent.endHour,
        minute: weeklyEvent.endMinutes,
      );

      // Create the event object
      final event = Event(
        successState.selectedCalendar.id,
        eventId: weeklyEvent.id,
        title: weeklyEvent.courseName,
        start: TZDateTime.from(start, local),
        end: TZDateTime.from(end, local),
        location: weeklyEvent.location,
        recurrenceRule: RecurrenceRule(
          RecurrenceFrequency.Weekly,
          endDate: endDate,
        ),
      );

      _logger.d('[UI] Creating event: \\${event.eventId}');

      // Create or update the event in the calendar
      final result = await _deviceCalendarPlugin.createOrUpdateEvent(event);

      if (result != null && result.isSuccess) {
        _logger.i(
          '[UI] Evento creado con éxito, ID: \\${result.data}, Evento: \\$event',
        );
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

  Future<void> _removeEventsFromCalendar({clearCalendar = false}) async {
    if (state is! SuccessState) {
      return;
    }

    final successState = state as SuccessState;

    final events = await _deviceCalendarPlugin.retrieveEvents(
      successState.selectedCalendar.id,
      RetrieveEventsParams(
        startDate: DateTime.now().subtract(const Duration(days: 356)),
        endDate: DateTime.now().add(const Duration(days: 356)),
      ),
    );
    if (events.errors.isNotEmpty) {
      throw Exception(
        'Error al obtener eventos: \\${events.errors.map((e) => '(\\${e.errorCode}) \\${e.errorMessage}').join(', ')}',
      );
    }
    if (events.data?.isEmpty ?? true) {
      _logger.d('[UI] There is no old events between the selected dates');
      return;
    }
    final allEvents = events.data?.toList() ?? [];

    var filteredEvents = allEvents;
    if (!clearCalendar) {
      var discardedToRemoveCount = 0;
      var selectedToRemoveCount = 0;
      filteredEvents =
          allEvents.where((event) {
            final eventId = event.eventId;
            if (eventId == null) {
              discardedToRemoveCount++;
              return false;
            }
            final eventIsOwnedByThisApp = _getClassScheduleUsecase
                .calculateIfEventIsOwnedByThisApp(eventId);
            if (eventIsOwnedByThisApp) {
              selectedToRemoveCount++;
            } else {
              _logger.d(
                '[UI] Discarded event \\$eventId: \\${event.description}',
              );
              discardedToRemoveCount++;
            }
            return eventIsOwnedByThisApp;
          }).toList();
      _logger.d('[UI] Discarded events: \\$discardedToRemoveCount');
      _logger.d('[UI] Selected to remove: \\$selectedToRemoveCount');
    }

    var successCount = 0;
    var errorCount = 0;
    for (final Event event in filteredEvents) {
      final result = await _deviceCalendarPlugin.deleteEvent(
        successState.selectedCalendar.id,
        event.eventId,
      );
      if (result.isSuccess) {
        successCount++;
      } else {
        _logger.e(
          '[UI] Error deleting event: \\${result.errors.map((e) => '(\\${e.errorCode}) \\${e.errorMessage}').join(', ')}',
        );
        errorCount++;
      }
    }
    _logger.i(
      '[UI] Se eliminaron \\$successCount eventos con éxito, \\$errorCount errores.',
    );
  }
}
