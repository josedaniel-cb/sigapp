import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:sigapp/auth/application/usecases/sign_out_usecase.dart';

part 'home_page_cubit.freezed.dart';

@freezed
abstract class HomePageState with _$HomePageState {
  const factory HomePageState({
    required int selectedTabIndex,
    String? errorMessage,
  }) = _HomePageState;
}

@injectable
class HomePageCubit extends Cubit<HomePageState> {
  final SignOutUseCase _signOutUseCase;
  final Logger _logger;

  HomePageCubit(this._signOutUseCase, this._logger)
    : super(const HomePageState(selectedTabIndex: 0));

  void changeTab(int index) {
    emit(state.copyWith(selectedTabIndex: index));
  }

  Future<void> logout() async {
    try {
      await _signOutUseCase.execute();
    } catch (e, s) {
      _logger.e('[UI] Error logging out', error: e, stackTrace: s);
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  void markErrorAsRead() {
    emit(state.copyWith(errorMessage: null));
  }
}
