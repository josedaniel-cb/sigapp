import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:sigapp/auth/auth_service.dart';
import 'package:sigapp/student/get_academic_report.dart';

part 'login_cubit.freezed.dart';

@freezed
abstract class LoginState with _$LoginState {
  const factory LoginState.initial() = InitialState;
  const factory LoginState.loading() = LoadingState;
  const factory LoginState.success() = SuccessState;
  const factory LoginState.error(String message) = ErrorState;
}

@injectable
class LoginCubit extends Cubit<LoginState> {
  final AuthService _authService;

  LoginCubit(this._authService) : super(LoginState.initial());

  Future<void> login(String username, String password) async {
    emit(const LoginState.loading());
    try {
      final successAuth = await _authService.login(username, password);
      if (!successAuth) {
        emit(const LoginState.error('Credenciales inválidos'));
        return;
      }
      emit(const LoginState.success());
    } catch (e, s) {
      print(e);
      print(s);
      emit(LoginState.error(e.toString()));
    }
  }
}
