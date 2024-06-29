import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:sigapp/auth/auth_service.dart';
import 'package:sigapp/student/entities/student_academic_report.dart';
import 'package:sigapp/student/models/get_academic_report.dart';
import 'package:sigapp/student/student_service.dart';

part 'home_cubit.freezed.dart';

@freezed
abstract class HomeState with _$HomeState {
  // const factory HomeState.initial() = InitialState;
  const factory HomeState.loading() = LoadingState;
  const factory HomeState.success(
    StudentAcademicReport academicReport,
  ) = SuccessState;
  const factory HomeState.error(String message) = ErrorState;
  // const factory HomeState.signedOut() = SignedOutState;
}

@injectable
class HomeCubit extends Cubit<HomeState> {
  final StudentService _studentService;
  final AuthService _authService;

  HomeCubit(
    this._studentService,
    this._authService,
  ) : super(const HomeState.loading());

  Future<void> setup() async {
    emit(const HomeState.loading());
    try {
      final result = await _studentService.getAcademicReport();
      emit(HomeState.success(result));
    } catch (e, s) {
      print(e);
      print(s);
      emit(HomeState.error(e.toString()));
    }
  }

  logout(BuildContext context) {
    try {
      _authService.logout();
      GoRouter.of(context).go('/login');
    } catch (e, s) {
      print(e);
      print(s);
      emit(HomeState.error(e.toString()));
    }
  }
}
