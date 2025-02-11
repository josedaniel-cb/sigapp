import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:sigapp/courses/application/usecases/get_class_schedule_usecase.dart';
import 'package:sigapp/student/application/usecases/get_academic_report_usecase.dart';
import 'package:sigapp/student/domain/entities/student_academic_report.dart';
import 'package:sigapp/student/domain/entities/student_semester_schedule.dart';
import 'package:sigapp/student/domain/entities/weekly_schedule_event.dart';

part 'schedule_cubit.freezed.dart';

@freezed
abstract class ScheduleTabState with _$ScheduleTabState {
  const factory ScheduleTabState.loading() = ScheduleTabLoadingState;
  const factory ScheduleTabState.success({
    required SemesterScheduleSemesterMetadata selectedSemester,
    required List<WeeklyScheduleEvent> scheduleEvents,
    required AcademicReport academicReport,
    required bool loadingShare,
    String? errorMessage,
    bool? errorMessageWasShown,
  }) = ScheduleTabSuccessState;
  const factory ScheduleTabState.error(String message) = ScheduleTabErrorState;
}

@singleton
class ScheduleTabCubit extends Cubit<ScheduleTabState> {
  final GetClassScheduleUsecase _getScheduleUsecase;
  final GetAcademicReportUsecase _getAcademicReportUsecase;

  ScheduleTabCubit(this._getScheduleUsecase, this._getAcademicReportUsecase)
      : super(ScheduleTabState.loading());

  SemesterScheduleSemesterMetadata? selectedSemester;

  Future<void> fetch(SemesterScheduleSemesterMetadata semester) async {
    selectedSemester = semester;
    emit(ScheduleTabState.loading());
    try {
      final scheduleEvents = await _getScheduleUsecase.execute(semester.id);
      final academicReport = await _getAcademicReportUsecase.execute();
      emit(ScheduleTabState.success(
        selectedSemester: semester,
        scheduleEvents: scheduleEvents,
        academicReport: academicReport,
        loadingShare: false,
      ));
    } catch (e) {
      emit(ScheduleTabState.error(e.toString()));
    }
  }

  void retry() {
    fetch(selectedSemester!);
  }

  void markErrorMessagesAsRead() {
    if (state is ScheduleTabSuccessState) {
      emit((state as ScheduleTabSuccessState).copyWith(errorMessage: null));
    }
  }

  void updateRenderingImageForSharing(bool value) {
    if (state is ScheduleTabSuccessState) {
      emit((state as ScheduleTabSuccessState).copyWith(loadingShare: value));
    }
  }

  void showErrorMessage(String message) {
    if (state is! ScheduleTabSuccessState) {
      return;
    }
    final successState = state as ScheduleTabSuccessState;
    emit(successState.copyWith(
      errorMessage: message,
      errorMessageWasShown: false,
    ));
  }

  void setErrorMessageAsShown() {
    if (state is! ScheduleTabSuccessState) {
      return;
    }
    final successState = state as ScheduleTabSuccessState;
    emit(successState.copyWith(
      errorMessageWasShown: true,
    ));
  }
}
