import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:sigapp/auth/auth_repository.dart';
import 'package:sigapp/student/models/get_academic_report.dart';
import 'package:sigapp/student/student_repository.dart';

part 'home_cubit.freezed.dart';

@freezed
abstract class HomeState with _$HomeState {
  // const factory HomeState.initial() = InitialState;
  const factory HomeState.loading() = LoadingState;
  const factory HomeState.success(
    GetAcademicReportModel academicReport,
  ) = SuccessState;
  const factory HomeState.error(String message) = ErrorState;
  // const factory HomeState.signedOut() = SignedOutState;
}

@injectable
class HomeCubit extends Cubit<HomeState> {
  final StudentRepository _studentRepository;
  final AuthRepository _authRepository;

  HomeCubit(
    this._studentRepository,
    this._authRepository,
  ) : super(const HomeState.loading());

  Future<void> setup() async {
    emit(const HomeState.loading());
    try {
      final result = await _studentRepository.getAcademicReport();
      emit(HomeState.success(result));
    } catch (e, s) {
      print(e);
      print(s);
      emit(HomeState.error(e.toString()));
    }
  }

  logout(BuildContext context) {
    try {
      _authRepository.logout();
      GoRouter.of(context).go('/login');
    } catch (e, s) {
      print(e);
      print(s);
      emit(HomeState.error(e.toString()));
    }
  }
}
