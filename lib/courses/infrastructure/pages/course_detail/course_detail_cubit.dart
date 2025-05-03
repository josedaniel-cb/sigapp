import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:sigapp/courses/application/usecases/get_course_grade_usecase.dart';
import 'package:sigapp/courses/application/usecases/get_syllabus_file_usecase.dart';
import 'package:sigapp/courses/domain/value-objects/course_grade.dart';
import 'package:sigapp/student/domain/value_objects/enrolled_course.dart';

part 'course_detail_cubit.freezed.dart';

@freezed
class CourseDetailState with _$CourseDetailState {
  const factory CourseDetailState.empty() = CourseDetailEmptyState;
  const factory CourseDetailState.ready({
    required EnrolledCourse course,
    required String regevaScheduledCourseId,
    required CourseDetailSyllabusState syllabus,
    required CourseDetailGradesState grades,
  }) = CourseDetailReadyState;
}

@freezed
class CourseDetailSyllabusState with _$CourseDetailSyllabusState {
  const factory CourseDetailSyllabusState.initial() =
      _CourseDetailSyllabusStateInitial;
  const factory CourseDetailSyllabusState.loading() =
      _CourseDetailSyllabusStateLoading;
  const factory CourseDetailSyllabusState.loaded(File syllabusFile) =
      _CourseDetailSyllabusStateLoaded;
  const factory CourseDetailSyllabusState.notFound() =
      _CourseDetailSyllabusStateNotFound;
  // TODO: must be `dynamic error`
  const factory CourseDetailSyllabusState.error(String message) =
      _CourseDetailSyllabusStateError;
}

@freezed
class CourseDetailGradesState with _$CourseDetailGradesState {
  const factory CourseDetailGradesState.initial() =
      _CourseDetailGradesStateInitial;
  const factory CourseDetailGradesState.loading() =
      _CourseDetailGradesStateLoading;
  const factory CourseDetailGradesState.loaded(
    CourseGradeInfo value,
  ) = _CourseDetailGradesStateLoaded;
  // TODO: must be `dynamic error`
  const factory CourseDetailGradesState.error(String message) =
      _CourseDetailGradesStateError;
}

@injectable
class CourseDetailCubit extends Cubit<CourseDetailState> {
  final GetSyllabusFileUsecase _getSyllabusFileUsecase;
  final GetCourseGradeUsecase _getCourseGradeUsecase;

  CourseDetailCubit(this._getSyllabusFileUsecase, this._getCourseGradeUsecase)
      : super(const CourseDetailState.empty());

  Future<void> init({
    required EnrolledCourse course,
    required String regevaScheduledCourseId,
  }) async {
    emit(CourseDetailState.ready(
      course: course,
      regevaScheduledCourseId: regevaScheduledCourseId,
      syllabus: CourseDetailSyllabusState.initial(),
      grades: CourseDetailGradesState.initial(),
    ));
    await fetchSyllabus();
    await fetchGrades();
  }

  Future<void> fetchSyllabus({bool? forceDownload}) async {
    if (state is! CourseDetailReadyState) return;

    emit(
      (state as CourseDetailReadyState).copyWith(
        syllabus: CourseDetailSyllabusState.loading(),
      ),
    );

    final regevaScheduledCourseId =
        (state as CourseDetailReadyState).regevaScheduledCourseId;
    try {
      final file = await _getSyllabusFileUsecase.execute(
        regevaScheduledCourseId,
        forceDownload: forceDownload,
      );
      if (file == null) {
        emit((state as CourseDetailReadyState).copyWith(
          syllabus: CourseDetailSyllabusState.notFound(),
        ));
      } else {
        emit((state as CourseDetailReadyState).copyWith(
          syllabus: CourseDetailSyllabusState.loaded(file),
        ));
      }
    } catch (e, s) {
      if (kDebugMode) {
        print(e);
        print(s);
      }
      emit((state as CourseDetailReadyState).copyWith(
        syllabus:
            CourseDetailSyllabusState.error('Error al descargar syllabus'),
      ));
    }
  }

  Future<void> fetchGrades({bool? forceDownload}) async {
    if (state is! CourseDetailReadyState) return;

    emit(
      (state as CourseDetailReadyState).copyWith(
        grades: CourseDetailGradesState.loading(),
      ),
    );

    final regevaScheduledCourseId =
        (state as CourseDetailReadyState).regevaScheduledCourseId;
    try {
      final courseGradeInfo = await _getCourseGradeUsecase.execute(
        regevaScheduledCourseId,
        forceDownload,
      );
      emit((state as CourseDetailReadyState).copyWith(
        grades: CourseDetailGradesState.loaded(courseGradeInfo),
      ));
    } catch (e, s) {
      if (kDebugMode) {
        print(e);
        print(s);
      }
      emit((state as CourseDetailReadyState).copyWith(
        grades: CourseDetailGradesState.error(
          'Error al descargar notas',
        ),
      ));
    }
  }
}
