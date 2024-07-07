import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:sigapp/student/entities/student_semester_schedule.dart';
import 'package:sigapp/student/student_service.dart';

part 'schedule_cubit.freezed.dart';

@freezed
abstract class ScheduleState with _$ScheduleState {
  const factory ScheduleState.loading() = LoadingState;
  const factory ScheduleState.success({
    required bool loadingShare,
    required bool loadingChangeSemester,
    required SemesterSchedule schedule, // rename to studentSemesterSchedule
    // required List<Calendar> calendars,
    // required Calendar? selectedCalendar,
    String? errorMessage,
    bool? errorMessageWasShown,
  }) = SuccessState;
  const factory ScheduleState.error(String message) = ErrorState;
}

@injectable
class ScheduleCubit extends Cubit<ScheduleState> {
  final StudentService _studentService;
  // final DeviceCalendarPlugin _deviceCalendarPlugin = DeviceCalendarPlugin();

  ScheduleCubit(
    this._studentService,
  ) : super(const ScheduleState.loading());

  Future<void> setup() async {
    emit(const ScheduleState.loading());
    try {
      final studentSemesterSchedule =
          await _studentService.getDefaultClassSchedule();

      emit(ScheduleState.success(
        loadingChangeSemester: false,
        loadingShare: false,
        schedule: studentSemesterSchedule,
      ));
    } catch (e, s) {
      if (kDebugMode) {
        print(e);
        print(s);
      }
      emit(ScheduleState.error(e.toString()));
    }
  }

  void changeSemester(SemesterScheduleSemesterMetadata semester) async {
    if (state is! SuccessState) {
      return;
    }
    final successState = state as SuccessState;
    emit(successState.copyWith(loadingChangeSemester: true));
    try {
      final weeklyEvents = await _studentService.getClassSchedule(semester.id);
      final newSchedule = successState.schedule.copyWith(
        semester: semester,
        weeklyEvents: weeklyEvents,
      );
      // throw Exception('Not implemented ajefobea ');
      emit(successState.copyWith(
        loadingChangeSemester: false,
        schedule: newSchedule,
      ));
    } catch (e, s) {
      if (kDebugMode) {
        print(e);
        print(s);
      }
      emit(successState.copyWith(
        loadingChangeSemester: false,
        errorMessage: e.toString(),
        errorMessageWasShown: false,
      ));
    }
  }

  void updateRenderingImageForSharing(bool value) {
    if (state is! SuccessState) {
      return;
    }
    final successState = state as SuccessState;
    emit(successState.copyWith(
      loadingShare: value,
    ));
  }

  void showErrorMessage(String message) {
    if (state is! SuccessState) {
      return;
    }
    final successState = state as SuccessState;
    emit(successState.copyWith(
      errorMessage: message,
      errorMessageWasShown: false,
    ));
  }

  void setErrorMessageAsShown() {
    if (state is! SuccessState) {
      return;
    }
    final successState = state as SuccessState;
    emit(successState.copyWith(
      errorMessageWasShown: true,
    ));
  }
}
