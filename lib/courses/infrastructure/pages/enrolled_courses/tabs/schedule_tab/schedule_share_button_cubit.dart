import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'schedule_share_button_cubit.freezed.dart';

@freezed
abstract class ScheduleShareButtonState with _$ScheduleShareButtonState {
  const factory ScheduleShareButtonState({
    required bool loadingShare,
    String? errorMessage,
    bool? errorMessageWasShown,
  }) = _ScheduleShareButtonState;
}

@injectable
class ScheduleShareButtonCubit extends Cubit<ScheduleShareButtonState> {
  ScheduleShareButtonCubit()
    : super(ScheduleShareButtonState(loadingShare: false));

  void markErrorMessagesAsRead() {
    emit(state.copyWith(errorMessage: null));
  }

  void updateRenderingImageForSharing(bool value) {
    emit(state.copyWith(loadingShare: value));
  }

  void showErrorMessage(String message) {
    emit(state.copyWith(errorMessage: message, errorMessageWasShown: false));
  }

  void setErrorMessageAsShown() {
    emit(state.copyWith(errorMessageWasShown: true));
  }
}
