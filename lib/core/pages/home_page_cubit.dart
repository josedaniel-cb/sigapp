import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:sigapp/auth/application/usecases.dart';

part 'home_page_cubit.freezed.dart';

@freezed
abstract class HomePageState with _$HomePageState {
  // const factory HomePageState.loading() = HomePageLoadingState;
  const factory HomePageState.success({
    required int selectedTabIndex,
    // required SemesterContext semesterContext,
    String? errorMessage,
  }) = HomePageSuccessState;
  // const factory HomePageState.error(String message) = HomePageErrorState;
}

@singleton
class HomePageCubit extends Cubit<HomePageState> {
  final AuthUsecases _authUsecases;
  // final GetSemesterContextUsecase _getDefaultSemesterUsecase;

  HomePageCubit(this._authUsecases)
      : super(const HomePageState.success(selectedTabIndex: 0));

  // Future<void> init() async {
  //   emit(const HomePageState.loading());
  //   try {
  //     final defaultSemester = await _getDefaultSemesterUsecase.execute();
  //     emit(HomePageState.ready(
  //         selectedTabIndex: 0, semesterContext: defaultSemester));
  //   } catch (e, s) {
  //     if (kDebugMode) {
  //       print(e);
  //       print(s);
  //     }
  //     emit(HomePageState.error(e.toString()));
  //   }
  // }

  void changeTab(int index) {
    if (state is! HomePageSuccessState) return;
    emit((state as HomePageSuccessState).copyWith(selectedTabIndex: index));
  }

  Future<void> logout() async {
    try {
      await _authUsecases.signOut.execute();
    } catch (e, s) {
      if (kDebugMode) {
        print(e);
        print(s);
      }
      emit(
          (state as HomePageSuccessState).copyWith(errorMessage: e.toString()));
    }
  }

  void markErrorAsRead() {
    emit((state as HomePageSuccessState).copyWith(errorMessage: null));
  }
}
