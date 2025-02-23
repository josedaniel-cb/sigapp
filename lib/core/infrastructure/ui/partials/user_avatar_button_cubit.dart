import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:sigapp/auth/application/usecases/sign_out_usecase.dart';
import 'package:sigapp/student/domain/entities/student_academic_report.dart';
import 'package:sigapp/student/domain/services/student_info_service.dart';

part 'user_avatar_button_cubit.freezed.dart';

@freezed
class UserAvatarButtonState with _$UserAvatarButtonState {
  factory UserAvatarButtonState.initial() = _UserAvatarButtonInitialState;
  factory UserAvatarButtonState.loading() = _UserAvatarButtonLoadingState;
  factory UserAvatarButtonState.success({
    required AcademicReport data,
    String? errorMessage,
  }) = _UserAvatarButtonSuccessState;
  factory UserAvatarButtonState.error(dynamic error) =
      _UserAvatarButtonErrorState;
}

@singleton
class UserAvatarButtonCubit extends Cubit<UserAvatarButtonState> {
  final SessionInfoService _sessionInfoService;
  final SignOutUseCase _signOutUseCase;

  UserAvatarButtonCubit(this._sessionInfoService, this._signOutUseCase)
      : super(UserAvatarButtonState.initial());

  void init() async {
    if (state is _UserAvatarButtonLoadingState) {
      return;
    }
    try {
      final result = await _sessionInfoService.getSessionInfo();
      emit(UserAvatarButtonState.success(data: result.academicReport));
    } catch (e, s) {
      if (kDebugMode) {
        print(e);
        print(s);
      }
      emit(UserAvatarButtonState.error(e));
    }
  }

  void signOut() async {
    AcademicReport? loadedData;
    state.mapOrNull(
      success: (s) {
        loadedData = s.data;
        emit(UserAvatarButtonState.loading());
      },
    );
    try {
      await _signOutUseCase.execute();
      emit(UserAvatarButtonState.initial());
    } catch (e, s) {
      if (kDebugMode) {
        print(e);
        print(s);
      }
      if (loadedData == null) {
        emit(UserAvatarButtonState.error(e));
        return;
      }
      emit(UserAvatarButtonState.success(
        data: loadedData!,
        errorMessage: e.toString(),
      ));
    }
  }
}
