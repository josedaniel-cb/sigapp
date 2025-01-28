import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:sigapp/student/application/usecases/get_academic_report_usecase.dart';
import 'package:sigapp/student/domain/entities/student_academic_report.dart';
import 'package:sigapp/auth/application/usecases.dart';

part 'home_cubit.freezed.dart';

@freezed
abstract class HomeState with _$HomeState {
  const factory HomeState.loading() = LoadingState;
  const factory HomeState.success(
    AcademicReport academicReport,
  ) = SuccessState;
  const factory HomeState.error(String message) = ErrorState;
}

@injectable
class HomeCubit extends Cubit<HomeState> {
  final GetAcademicReportUsecase _getAcademicReportUsecase;
  final AuthUsecases _authUsecases;

  HomeCubit(
    this._getAcademicReportUsecase,
    this._authUsecases,
  ) : super(const HomeState.loading());

  Future<void> setup() async {
    emit(const HomeState.loading());
    try {
      final result = await _getAcademicReportUsecase.execute();
      emit(HomeState.success(result));
    } catch (e, s) {
      print(e);
      print(s);
      emit(HomeState.error(e.toString()));
    }
  }

  logout(BuildContext context) {
    try {
      _authUsecases.signOut.execute();
      GoRouter.of(context).go('/login');
    } catch (e, s) {
      print(e);
      print(s);
      emit(HomeState.error(e.toString()));
    }
  }
}
