import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:sigapp/courses/application/usecases/get_syllabus_file_usecase.dart';
import 'package:sigapp/student/domain/value_objects/enrolled_course.dart';

part 'course_detail_cubit.freezed.dart';

@freezed
class CourseDetailSyllabusState with _$CourseDetailSyllabusState {
  const factory CourseDetailSyllabusState.initial() = _Initial;
  const factory CourseDetailSyllabusState.loading() = _Loading;
  const factory CourseDetailSyllabusState.loaded(File syllabusFile) = _Loaded;
  const factory CourseDetailSyllabusState.notFound() = _NotFound;
  const factory CourseDetailSyllabusState.error(String message) = _Error;
}

@freezed
class CourseDetailState with _$CourseDetailState {
  const factory CourseDetailState.empty() = CourseDetailEmptyState;
  const factory CourseDetailState.ready({
    required EnrolledCourse course,
    required String regevaScheduledCourseId,
    required CourseDetailSyllabusState syllabus,
  }) = CourseDetailReadyState;
}

@injectable
class CourseDetailCubit extends Cubit<CourseDetailState> {
  final GetSyllabusFileUsecase _getSyllabusFileUsecase;
  CourseDetailCubit(this._getSyllabusFileUsecase)
      : super(const CourseDetailState.empty());

  Future<void> init({
    required EnrolledCourse course,
    required String regevaScheduledCourseId,
  }) async {
    emit(CourseDetailState.ready(
      course: course,
      regevaScheduledCourseId: regevaScheduledCourseId,
      syllabus: CourseDetailSyllabusState.initial(),
    ));
    await fetchSyllabus();
  }

  Future<void> fetchSyllabus() async {
    if (state is! CourseDetailReadyState) return;

    emit(
      (state as CourseDetailReadyState).copyWith(
        syllabus: CourseDetailSyllabusState.loading(),
      ),
    );

    final regevaScheduledCourseId =
        (state as CourseDetailReadyState).regevaScheduledCourseId;
    try {
      final file =
          await _getSyllabusFileUsecase.execute(regevaScheduledCourseId);
      if (file == null) {
        emit((state as CourseDetailReadyState).copyWith(
          syllabus: CourseDetailSyllabusState.notFound(),
        ));
      } else {
        emit((state as CourseDetailReadyState).copyWith(
          syllabus: CourseDetailSyllabusState.loaded(file),
        ));
      }
    } catch (e) {
      emit((state as CourseDetailReadyState).copyWith(
        syllabus:
            CourseDetailSyllabusState.error('Error al descargar syllabus'),
      ));
    }
  }
}
