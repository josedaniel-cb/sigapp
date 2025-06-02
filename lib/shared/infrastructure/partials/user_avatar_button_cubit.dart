import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:sigapp/auth/application/usecases/sign_out_usecase.dart';
import 'package:sigapp/student/domain/services/academic_info_service.dart';
import 'package:sigapp/student/domain/value_objects/academic_info_data.dart';

part 'user_avatar_button_cubit.freezed.dart';

@freezed
sealed class UserAvatarButtonState with _$UserAvatarButtonState {
  factory UserAvatarButtonState.initial() = UserAvatarButtonInitialState;
  factory UserAvatarButtonState.loading() = UserAvatarButtonLoadingState;
  factory UserAvatarButtonState.success({
    required AcademicInfoData data,
    String? errorMessage,
  }) = UserAvatarButtonSuccessState;
  factory UserAvatarButtonState.error(dynamic error) =
      UserAvatarButtonErrorState;
}

@injectable
class UserAvatarButtonCubit extends Cubit<UserAvatarButtonState> {
  final AcademicInfoService _sessionInfoService;
  final SignOutUseCase _signOutUseCase;

  UserAvatarButtonCubit(this._sessionInfoService, this._signOutUseCase)
    : super(UserAvatarButtonState.initial());

  void init() async {
    if (state is UserAvatarButtonLoadingState) {
      return;
    }
    try {
      final result = await _sessionInfoService.getSessionInfo();
      emit(UserAvatarButtonState.success(data: result));
    } catch (e, s) {
      if (kDebugMode) {
        print(e);
        print(s);
      }
      emit(UserAvatarButtonState.error(e));
    }
  }

  void signOut() async {
    AcademicInfoData? loadedData;
    switch (state) {
      case UserAvatarButtonSuccessState(:final data):
        loadedData = data;
        emit(UserAvatarButtonState.loading());
        break;
      default:
        break;
    }
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
      emit(
        UserAvatarButtonState.success(
          data: loadedData,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
