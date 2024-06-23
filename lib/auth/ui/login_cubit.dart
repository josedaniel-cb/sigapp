import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:sigapp/auth/auth_service.dart';
// import 'package:sigapp/student/get_academic_report.dart';

part 'login_cubit.freezed.dart';

// @freezed
// abstract class LoginState with _$LoginState {
//   const factory LoginState.initial() = InitialState;
//   const factory LoginState.loading() = LoadingState;
//   const factory LoginState.success() = SuccessState;
//   const factory LoginState.error(String message) = ErrorState;
// }

@freezed
class LoginState with _$LoginState {
  const factory LoginState({
    required String username,
    required String password,
    required LoginStatus status,
  }) = _LoginState;
}

@freezed
abstract class LoginStatus with _$LoginStatus {
  const factory LoginStatus.initial() = LoginInitial;
  const factory LoginStatus.loading() = LoginLoading;
  const factory LoginStatus.success() = LoginSuccess;
  const factory LoginStatus.error(String message) = LoginError;
}

@injectable
class LoginCubit extends Cubit<LoginState> {
  final AuthService _authService;

  LoginCubit(this._authService)
      : super(const LoginState(
          username: '',
          password: '',
          status: LoginStatus.initial(),
        ));

  void setup() {
    final storedUsername = _authService.getUsername();
    if (storedUsername != null) {
      emit(state.copyWith(username: storedUsername));
    }

    final storedPassword = _authService.getPassword();
    if (storedUsername != null && storedPassword != null) {
      emit(state.copyWith(
        username: storedUsername,
        password: storedPassword,
      ));
      login(storedUsername, storedPassword);
    } else {
      emit(state.copyWith(
        status: const LoginStatus.initial(),
      ));
    }
  }

  Future<void> login(String username, String password) async {
    emit(state.copyWith(
      status: const LoginStatus.loading(),
    ));
    try {
      final successAuth = await _authService.login(username, password);
      if (!successAuth) {
        emit(state.copyWith(
          status: const LoginStatus.error('Credenciales inválidos'),
        ));
        return;
      }
      emit(state.copyWith(
        status: const LoginStatus.success(),
      ));
    } catch (e, s) {
      if (kDebugMode) {
        print(e);
        print(s);
      }
      emit(state.copyWith(
        status: LoginStatus.error(e.toString()),
      ));
    }
  }
}
