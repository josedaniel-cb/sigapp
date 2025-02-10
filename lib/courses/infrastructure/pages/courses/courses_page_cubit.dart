import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:sigapp/semester/application/get_semester_context_usecase.dart';
import 'package:sigapp/semester/domain/value-objects/semester_context.dart';
import 'package:sigapp/student/domain/entities/student_semester_schedule.dart';

part 'courses_page_cubit.freezed.dart';

@freezed
abstract class CoursesPageState with _$CoursesPageState {
  const factory CoursesPageState.loading() = CoursesPageLoadingState;
  const factory CoursesPageState.success({
    required SemesterContext semesterContext,
    required SemesterScheduleSemesterMetadata selectedSemester,
  }) = CoursesPageSuccessState;
  const factory CoursesPageState.error(String message) = CoursesPageErrorState;
}

@singleton
class CoursesPageCubit extends Cubit<CoursesPageState> {
  final GetSemesterContextUsecase _getSemesterContextUsecase;

  CoursesPageCubit(this._getSemesterContextUsecase)
      : super(CoursesPageState.loading());

  Future<void> init() async {
    try {
      final semesterContext = await _getSemesterContextUsecase.execute();
      // fetch(semesterContext.defaultSemester.id);
      emit(CoursesPageState.success(
        semesterContext: semesterContext,
        selectedSemester: semesterContext.defaultSemester,
      ));
    } catch (e) {
      emit(CoursesPageState.error(e.toString()));
    }
  }

  void changeSemester(SemesterScheduleSemesterMetadata semester) {
    emit(state.maybeWhen(
      success: (semesterContext, _) => CoursesPageState.success(
        semesterContext: semesterContext,
        selectedSemester: semester,
      ),
      orElse: () => state,
    ));
  }
}
