import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:sigapp/auth/application/usecases.dart';

part 'home_page_cubit.freezed.dart';

@freezed
abstract class HomePageState with _$HomePageState {
  const factory HomePageState({
    required int selectedIndex,
    String? errorMessage,
  }) = _HomePageState;
}

@singleton
class HomePageCubit extends Cubit<HomePageState> {
  final AuthUsecases _authUsecases;

  HomePageCubit(this._authUsecases)
      : super(const HomePageState(
          selectedIndex: 0,
        ));

  void changeTab(int index) {
    emit(HomePageState(selectedIndex: index));
  }

  Future<void> logout() async {
    try {
      await _authUsecases.signOut.execute();
    } catch (e, s) {
      if (kDebugMode) {
        print(e);
        print(s);
      }
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  void markErrorAsRead() {
    emit(state.copyWith(errorMessage: null));
  }
}
