import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:sigapp/courses/application/usecases/get_enrolled_courses_usecase.dart';
import 'package:sigapp/semester/application/get_semester_context_usecase.dart';
import 'package:sigapp/student/domain/entities/enrolled_course.dart';

part 'courses_page_cubit.freezed.dart';

@freezed
abstract class CoursesPageState with _$CoursesPageState {
  const factory CoursesPageState.loading() = CoursesPageLoadingState;
  const factory CoursesPageState.success({
    required List<EnrolledCourse> courses,
    String? errorMessage,
  }) = CoursesPageSuccessState;
  const factory CoursesPageState.error(String message) = CoursesPageErrorState;
}

@singleton
class CoursesPageCubit extends Cubit<CoursesPageState> {
  final GetEnrolledCoursesUsecase _getEnrolledCoursesUsecase;
  final GetSemesterContextUsecase _getSemesterContextUsecase;

  CoursesPageCubit(
      this._getEnrolledCoursesUsecase, this._getSemesterContextUsecase)
      : super(CoursesPageState.loading());

  Future<void> init() async {
    try {
      final semesterContext = await _getSemesterContextUsecase.execute();
      fetch(semesterContext.defaultSemester.id);
    } catch (e) {
      emit(CoursesPageState.error(e.toString()));
    }
  }

  Future<void> fetch(String semesterId) async {
    try {
      final courses = await _getEnrolledCoursesUsecase.execute(semesterId);
      emit(CoursesPageState.success(
        courses: courses,
        errorMessage: null,
      ));
    } catch (e) {
      emit(CoursesPageState.error(e.toString()));
    }
  }

  markErrorMessagesAsRead() {
    if (state is CoursesPageSuccessState) {
      emit((state as CoursesPageSuccessState).copyWith(errorMessage: null));
    }
  }
}
