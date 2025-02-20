import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:sigapp/courses/application/usecases/get_enrolled_courses_usecase.dart';
import 'package:sigapp/semester/application/get_semester_context_usecase.dart';
import 'package:sigapp/semester/domain/value-objects/semester_context.dart';
import 'package:sigapp/student/application/usecases/get_academic_report_usecase.dart';
import 'package:sigapp/student/domain/entities/student_academic_report.dart';
import 'package:sigapp/student/domain/entities/student_semester_schedule.dart';
import 'package:sigapp/student/domain/value_objects/enrolled_course.dart';

part 'courses_page_cubit.freezed.dart';

@freezed
abstract class EnrolledCoursesState with _$EnrolledCoursesState {
  const factory EnrolledCoursesState.loading() = EnrolledCoursesLoadingState;
  const factory EnrolledCoursesState.success({
    required List<EnrolledCourse> value,
  }) = EnrolledCoursesSuccessState;
  const factory EnrolledCoursesState.error(String message) =
      EnrolledCoursesErrorState;
}

@freezed
abstract class CoursesPageState with _$CoursesPageState {
  const factory CoursesPageState.loading() = CoursesPageLoadingState;
  const factory CoursesPageState.success({
    required AcademicReport academicReport,
    required SemesterContext semesterContext,
    required SemesterScheduleSemesterMetadata selectedSemester,
    required EnrolledCoursesState enrolledCourses,
  }) = CoursesPageSuccessState;
  const factory CoursesPageState.error(String message) = CoursesPageErrorState;
}

@singleton
class CoursesPageCubit extends Cubit<CoursesPageState> {
  final GetAcademicReportUsecase _getAcademicReportUsecase;
  final GetSemesterContextUsecase _getSemesterContextUsecase;
  final GetEnrolledCoursesUsecase _getEnrolledCoursesUsecase;

  CoursesPageCubit(this._getSemesterContextUsecase,
      this._getEnrolledCoursesUsecase, this._getAcademicReportUsecase)
      : super(CoursesPageState.loading());

  Future<void> init() async {
    try {
      final academicReport = await _getAcademicReportUsecase.execute();
      final semesterContext = await _getSemesterContextUsecase.execute();
      final nextState = CoursesPageState.success(
        academicReport: academicReport,
        semesterContext: semesterContext,
        selectedSemester: semesterContext.defaultSemester,
        enrolledCourses: const EnrolledCoursesState.loading(),
      ) as CoursesPageSuccessState;
      emit(nextState);
      _fetchEnrolledCourses(nextState);
    } catch (e) {
      emit(CoursesPageState.error(e.toString()));
    }
  }

  void retryFetchEnrolledCourses() {
    state.mapOrNull(
      success: (state) {
        final nextState = state.copyWith(
          enrolledCourses: EnrolledCoursesState.loading(),
        ) as CoursesPageSuccessState;
        emit(nextState);
        _fetchEnrolledCourses(nextState);
      },
    );
  }

  void changeSemester(SemesterScheduleSemesterMetadata semester) {
    state.mapOrNull(
      success: (state) {
        final nextState = state.copyWith(
          enrolledCourses: EnrolledCoursesState.loading(),
        ) as CoursesPageSuccessState;
        emit(nextState);
        _fetchEnrolledCourses(nextState);
      },
    );
  }

  void _fetchEnrolledCourses(CoursesPageSuccessState state) {
    _getEnrolledCoursesUsecase
        .execute(state.selectedSemester.id)
        .then((courses) {
      emit(state.copyWith(
        enrolledCourses: EnrolledCoursesState.success(value: courses),
      ));
    }).catchError((e) {
      emit(state.copyWith(
        enrolledCourses: EnrolledCoursesState.error(e.toString()),
      ));
    });
  }
}
