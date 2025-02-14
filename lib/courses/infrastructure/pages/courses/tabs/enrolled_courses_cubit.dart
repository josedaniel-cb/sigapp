import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:sigapp/courses/application/usecases/get_enrolled_courses_usecase.dart';
import 'package:sigapp/student/domain/entities/raw_enrolled_course.dart';
import 'package:sigapp/student/domain/entities/student_semester_schedule.dart';

part 'enrolled_courses_cubit.freezed.dart';

enum SyllabusState { loading, available, error, notFound }

@freezed
abstract class EnrolledCoursesTabState with _$EnrolledCoursesTabState {
  const factory EnrolledCoursesTabState.loading() =
      EnrolledCoursesTabLoadingState;
  const factory EnrolledCoursesTabState.success({
    required List<RawEnrolledCourse> courses,
    String? errorMessage,
  }) = EnrolledCoursesTabSuccessState;
  const factory EnrolledCoursesTabState.error(String message) =
      EnrolledCoursesTabErrorState;
}

@singleton
class EnrolledCoursesTabCubit extends Cubit<EnrolledCoursesTabState> {
  final GetEnrolledCoursesUsecase _getEnrolledCoursesUsecase;

  EnrolledCoursesTabCubit(this._getEnrolledCoursesUsecase)
      : super(const EnrolledCoursesTabState.loading());

  SemesterScheduleSemesterMetadata? selectedSemester;

  Future<void> fetch(SemesterScheduleSemesterMetadata semester) async {
    selectedSemester = semester;
    emit(const EnrolledCoursesTabState.loading());
    try {
      final courses = await _getEnrolledCoursesUsecase.execute(semester.id);
      emit(EnrolledCoursesTabState.success(courses: courses));
    } catch (e) {
      emit(EnrolledCoursesTabState.error(e.toString()));
    }
  }

  void retry() {
    fetch(selectedSemester!);
  }
}
