import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:sigapp/courses/application/usecases/get_program_curriculum_progress_usecase.dart';
import 'package:sigapp/courses/domain/value-objects/program_curriculum_progress.dart';
import 'package:sigapp/student/domain/entities/student_academic_report.dart';
import 'package:sigapp/student/domain/services/academic_info_service.dart';

part 'career_page_cubit.freezed.dart';

@freezed
abstract class CareerPageState with _$CareerPageState {
  const factory CareerPageState.loading() = CareerPageLoadingState;
  const factory CareerPageState.success({
    required ProgramCurriculumProgress programCurriculumProgress,
    required AcademicReport academicReport,
  }) = CareerPageSuccessState;
  const factory CareerPageState.error(String message) = CareerPageErrorState;
}

// @singleton
@injectable
class CareerPageCubit extends Cubit<CareerPageState> {
  final GetProgramCurriculumProgressUsecase
      _getProgramCurriculumProgressUsecase;
  final AcademicInfoService _sessionInfoService;

  CareerPageCubit(
    this._getProgramCurriculumProgressUsecase,
    this._sessionInfoService,
  ) : super(CareerPageState.loading());

  Future<void> fetch() async {
    emit(CareerPageState.loading());
    try {
      final academicReport = await _sessionInfoService
          .getSessionInfo()
          .then((v) => v.academicReport);
      final programCurriculumProgress =
          await _getProgramCurriculumProgressUsecase.execute();
      emit(CareerPageState.success(
        academicReport: academicReport,
        programCurriculumProgress: programCurriculumProgress,
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
