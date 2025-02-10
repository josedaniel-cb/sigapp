import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:sigapp/courses/application/usecases/get_enrolled_courses_usecase.dart';
import 'package:sigapp/courses/application/usecases/get_syllabus_file_usecase.dart';
import 'package:sigapp/student/domain/entities/raw_enrolled_course.dart';
import 'package:sigapp/student/domain/entities/student_semester_schedule.dart';

part 'enrolled_courses_cubit.freezed.dart';

enum SyllabusState { loading, available, error, notFound }

@freezed
class EnrolledCoursesTabWidgetItem with _$EnrolledCoursesTabWidgetItem {
  factory EnrolledCoursesTabWidgetItem({
    required RawEnrolledCourse data,
    SyllabusState? syllabusState,
    File? syllabusFile,
  }) = _EnrolledCoursesTabWidgetItem;
}

@freezed
abstract class EnrolledCoursesTabState with _$EnrolledCoursesTabState {
  const factory EnrolledCoursesTabState.loading() =
      EnrolledCoursesTabLoadingState;
  const factory EnrolledCoursesTabState.success({
    required List<EnrolledCoursesTabWidgetItem> courses,
    String? errorMessage,
  }) = EnrolledCoursesTabSuccessState;
  const factory EnrolledCoursesTabState.error(String message) =
      EnrolledCoursesTabErrorState;
}

@singleton
class EnrolledCoursesTabCubit extends Cubit<EnrolledCoursesTabState> {
  final GetEnrolledCoursesUsecase _getEnrolledCoursesUsecase;
  final GetSyllabusFileUsecase _getSyllabusFileUsecase;

  EnrolledCoursesTabCubit(
      this._getEnrolledCoursesUsecase, this._getSyllabusFileUsecase)
      : super(EnrolledCoursesTabState.loading());

  Future<void> fetch(SemesterScheduleSemesterMetadata semester) async {
    emit(EnrolledCoursesTabState.loading());
    try {
      final courses = await _getEnrolledCoursesUsecase.execute(semester.id);
      emit(EnrolledCoursesTabState.success(
        courses:
            courses.map((c) => EnrolledCoursesTabWidgetItem(data: c)).toList(),
      ));

      await _fetchSyllabuses();
    } catch (e) {
      emit(EnrolledCoursesTabState.error(e.toString()));
    }
  }

  Future<void> _fetchSyllabuses() async {
    for (var i = 0;
        i < (state as EnrolledCoursesTabSuccessState).courses.length;
        i++) {
      final c = (state as EnrolledCoursesTabSuccessState).courses[i];
      try {
        // Update state
        emit((state as EnrolledCoursesTabSuccessState).copyWith(
          courses: [...(state as EnrolledCoursesTabSuccessState).courses]..[i] =
              c.copyWith(syllabusState: SyllabusState.loading),
        ));

        // Fetch
        final file = await _getSyllabusFileUsecase
            .execute(c.data.regevaScheduledCourseId);

        // Update state
        emit((state as EnrolledCoursesTabSuccessState).copyWith(
          courses: [...(state as EnrolledCoursesTabSuccessState).courses]..[i] =
              (state as EnrolledCoursesTabSuccessState).courses[i].copyWith(
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
        emit((state as EnrolledCoursesTabSuccessState).copyWith(
          courses: [...(state as EnrolledCoursesTabSuccessState).courses]..[i] =
              (state as EnrolledCoursesTabSuccessState).courses[i].copyWith(
                    syllabusState: SyllabusState.error,
                  ),
        ));
      }
    }
  }

  void markErrorMessagesAsRead() {
    if (state is EnrolledCoursesTabSuccessState) {
      emit((state as EnrolledCoursesTabSuccessState)
          .copyWith(errorMessage: null));
    }
  }
}
