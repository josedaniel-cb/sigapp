import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:sigapp/auth/application/usecases/sign_out_usecase.dart';
import 'package:sigapp/student/application/usecases/get_academic_report_usecase.dart';
import 'package:sigapp/student/domain/entities/student_academic_report.dart';

part 'user_avatar_button_cubit.freezed.dart';

@freezed
class UserAvatarButtonState with _$UserAvatarButtonState {
  factory UserAvatarButtonState.empty() = _UserAvatarButtonEmptyState;
  factory UserAvatarButtonState.loading() = _UserAvatarButtonLoadingState;
  factory UserAvatarButtonState.success(AcademicReport data) =
      _UserAvatarButtonSuccessState;
  factory UserAvatarButtonState.error(dynamic error) =
      _UserAvatarButtonErrorState;
}

@singleton
class UserAvatarButtonCubit extends Cubit<UserAvatarButtonState> {
  final GetAcademicReportUsecase _getAcademicReportUsecase;
  final SignOutUseCase _signOutUseCase;

  UserAvatarButtonCubit(this._getAcademicReportUsecase, this._signOutUseCase)
      : super(UserAvatarButtonState.empty());

  void init() async {
    if (state is _UserAvatarButtonLoadingState) {
      return;
    }
    try {
      final result = await _getAcademicReportUsecase.execute();
      emit(UserAvatarButtonState.success(
        result,
      ));
    } catch (e, s) {
      if (kDebugMode) {
        print(e);
        print(s);
      }
      emit(UserAvatarButtonState.error(e));
    }
  }

  void signOut() async {
    state.mapOrNull(
      success: (_) => emit(UserAvatarButtonState.loading()),
    );
    try {
      await _signOutUseCase.execute();
    } catch (e, s) {
      if (kDebugMode) {
        print(e);
        print(s);
      }
      emit(UserAvatarButtonState.error(e));
    }
  }
}
