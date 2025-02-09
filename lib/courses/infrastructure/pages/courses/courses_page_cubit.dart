import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:sigapp/courses/application/usecases/get_enrolled_courses_usecase.dart';
import 'package:sigapp/courses/application/usecases/get_syllabus_file_usecase.dart';
import 'package:sigapp/semester/application/get_semester_context_usecase.dart';
import 'package:sigapp/student/domain/entities/raw_enrolled_course.dart';

part 'courses_page_cubit.freezed.dart';

enum SyllabusState { loading, available, error, notFound }

// class CoursesPageWidgetItem {
//   final RawEnrolledCourse data;
//   final SyllabusState? syllabusState;
//   final File? syllabusFile;

//   CoursesPageWidgetItem(
//       {required this.data, this.syllabusState, this.syllabusFile});
// }

@freezed
class CoursesPageWidgetItem with _$CoursesPageWidgetItem {
  factory CoursesPageWidgetItem({
    required RawEnrolledCourse data,
    SyllabusState? syllabusState,
    File? syllabusFile,
  }) = _CoursesPageWidgetItem;
}

@freezed
abstract class CoursesPageState with _$CoursesPageState {
  const factory CoursesPageState.loading() = CoursesPageLoadingState;
  const factory CoursesPageState.success({
    required List<CoursesPageWidgetItem> courses,
    String? errorMessage,
  }) = CoursesPageSuccessState;
  const factory CoursesPageState.error(String message) = CoursesPageErrorState;
}

@singleton
class CoursesPageCubit extends Cubit<CoursesPageState> {
  final GetEnrolledCoursesUsecase _getEnrolledCoursesUsecase;
  final GetSemesterContextUsecase _getSemesterContextUsecase;
  final GetSyllabusFileUsecase _getSyllabusFileUsecase;

  CoursesPageCubit(this._getEnrolledCoursesUsecase,
      this._getSemesterContextUsecase, this._getSyllabusFileUsecase)
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
    emit(CoursesPageState.loading());
    try {
      final courses = await _getEnrolledCoursesUsecase.execute(semesterId);
      emit(CoursesPageState.success(
        courses: courses.map((c) => CoursesPageWidgetItem(data: c)).toList(),
      ));

      await _fetchSyllabuses();
    } catch (e) {
      emit(CoursesPageState.error(e.toString()));
    }
  }

  Future<void> _fetchSyllabuses() async {
    for (var i = 0;
        i < (state as CoursesPageSuccessState).courses.length;
        i++) {
      final c = (state as CoursesPageSuccessState).courses[i];
      try {
        // Update state
        emit((state as CoursesPageSuccessState).copyWith(
          courses: [...(state as CoursesPageSuccessState).courses]..[i] =
              c.copyWith(syllabusState: SyllabusState.loading),
        ));

        // Fetch
        final file = await _getSyllabusFileUsecase
            .execute(c.data.regevaScheduledCourseId);

        // Update state
        emit((state as CoursesPageSuccessState).copyWith(
          courses: [...(state as CoursesPageSuccessState).courses]..[i] =
              (state as CoursesPageSuccessState).courses[i].copyWith(
                    syllabusState: file != null
                        ? SyllabusState.available
                        : SyllabusState.notFound,
                    syllabusFile: file,
                  ),
        ));
      } catch (e, s) {
        if (kDebugMode) {
          print(e);
          print(s);
        }

        // Update state
        emit((state as CoursesPageSuccessState).copyWith(
          courses: [...(state as CoursesPageSuccessState).courses]..[i] =
              (state as CoursesPageSuccessState).courses[i].copyWith(
                    syllabusState: SyllabusState.error,
                  ),
        ));
      }
    }
  }

  markErrorMessagesAsRead() {
    if (state is CoursesPageSuccessState) {
      emit((state as CoursesPageSuccessState).copyWith(errorMessage: null));
    }
  }
}
