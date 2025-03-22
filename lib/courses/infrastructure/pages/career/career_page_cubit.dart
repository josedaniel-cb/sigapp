import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:sigapp/courses/application/usecases/get_program_curriculum_progress_usecase.dart';
import 'package:sigapp/courses/domain/value-objects/program_curriculum_progress.dart';

part 'career_page_cubit.freezed.dart';

@freezed
abstract class CareerPageState with _$CareerPageState {
  const factory CareerPageState.loading() = CareerPageLoadingState;
  const factory CareerPageState.success({
    required ProgramCurriculumProgress programCurriculumProgress,
  }) = CareerPageSuccessState;
  const factory CareerPageState.error(String message) = CareerPageErrorState;
}

// @singleton
@injectable
class CareerPageCubit extends Cubit<CareerPageState> {
  final GetProgramCurriculumProgressUsecase
      _getProgramCurriculumProgressUsecase;

  CareerPageCubit(this._getProgramCurriculumProgressUsecase)
      : super(CareerPageState.loading());

  Future<void> fetch() async {
    emit(CareerPageState.loading());
    try {
      final result = await _getProgramCurriculumProgressUsecase.execute();
      emit(CareerPageState.success(
        programCurriculumProgress: result,
      ));
    } catch (e, s) {
      if (kDebugMode) {
        print(e);
        print(s);
      }
      emit(CareerPageState.error(e.toString()));
    }
  }
}
