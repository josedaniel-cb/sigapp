import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:sigapp/courses/application/usecases/get_syllabus_file_usecase.dart';

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
  const factory CourseDetailState({
    required CourseDetailSyllabusState syllabus,
  }) = _CourseDetailState;
}

@injectable
class CourseDetailCubit extends Cubit<CourseDetailState> {
  final GetSyllabusFileUsecase _getSyllabusFileUsecase;

  CourseDetailCubit(this._getSyllabusFileUsecase)
      : super(const CourseDetailState(
          syllabus: CourseDetailSyllabusState.initial(),
        ));

  Future<void> loadSyllabus(String regevaScheduledCourseId) async {
    emit(const CourseDetailState(
      syllabus: CourseDetailSyllabusState.loading(),
    ));
    try {
      final file =
          await _getSyllabusFileUsecase.execute(regevaScheduledCourseId);
      if (file == null) {
        emit(const CourseDetailState(
          syllabus: CourseDetailSyllabusState.notFound(),
        ));
      } else {
        emit(CourseDetailState(
          syllabus: CourseDetailSyllabusState.loaded(file),
        ));
      }
    } catch (e) {
      emit(const CourseDetailState(
        syllabus:
            CourseDetailSyllabusState.error('Error al descargar syllabus'),
      ));
    }
  }
}
