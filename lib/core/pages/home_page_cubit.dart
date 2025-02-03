import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:sigapp/auth/application/usecases.dart';
import 'package:sigapp/semester/application/get_default_semester_usecase.dart';
import 'package:sigapp/semester/domain/value-objects/default_semester_id.dart';

part 'home_page_cubit.freezed.dart';

@freezed
abstract class HomePageState with _$HomePageState {
  const factory HomePageState.loading() = HomePageLoadingState;
  const factory HomePageState.ready({
    required int selectedIndex,
    required DefaultSemester defaultSemester,
    String? errorMessage,
  }) = HomePageReadyState;
  const factory HomePageState.error(String message) = HomePageErrorState;
}

@singleton
class HomePageCubit extends Cubit<HomePageState> {
  final AuthUsecases _authUsecases;
  final GetDefaultSemesterUsecase _getDefaultSemesterUsecase;

  HomePageCubit(this._authUsecases, this._getDefaultSemesterUsecase)
      : super(const HomePageState.loading());

  Future<void> init() async {
    emit(const HomePageState.loading());
    try {
      final defaultSemester = await _getDefaultSemesterUsecase.execute();
      emit(HomePageState.ready(
          selectedIndex: 0, defaultSemester: defaultSemester));
    } catch (e, s) {
      if (kDebugMode) {
        print(e);
        print(s);
      }
      emit(HomePageState.error(e.toString()));
    }
  }

  void changeTab(int index) {
    if (state is! HomePageReadyState) return;
    emit((state as HomePageReadyState).copyWith(selectedIndex: index));
  }

  Future<void> logout() async {
    try {
      await _authUsecases.signOut.execute();
    } catch (e, s) {
      if (kDebugMode) {
        print(e);
        print(s);
      }
      emit((state as HomePageReadyState).copyWith(errorMessage: e.toString()));
    }
  }

  void markErrorAsRead() {
    emit((state as HomePageReadyState).copyWith(errorMessage: null));
  }
}
