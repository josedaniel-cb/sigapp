import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:sigapp/courses/application/usecases/get_enrolled_courses_usecase.dart';
import 'package:sigapp/courses/domain/entities/scheduled_term_identifier.dart';
import 'package:sigapp/student/domain/value_objects/semester_context.dart';
import 'package:sigapp/student/domain/entities/student_academic_report.dart';
import 'package:sigapp/student/domain/services/academic_info_service.dart';
import 'package:sigapp/student/domain/value_objects/enrolled_course.dart';

part 'enrolled_courses_page_cubit.freezed.dart';

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
abstract class EnrolledCoursesPageState with _$EnrolledCoursesPageState {
  const factory EnrolledCoursesPageState.loading() = CoursesPageLoadingState;
  const factory EnrolledCoursesPageState.success({
    required AcademicReport academicReport,
    required SemesterContext semesterContext,
    required ScheduledTermIdentifier selectedSemester,
    required EnrolledCoursesState enrolledCourses,
  }) = CoursesPageSuccessState;
  const factory EnrolledCoursesPageState.error(String message) =
      CoursesPageErrorState;
}

// @singleton
@injectable
class EnrolledCoursesPageCubit extends Cubit<EnrolledCoursesPageState> {
  final AcademicInfoService _sessionInfoService;
  final GetEnrolledCoursesUsecase _getEnrolledCoursesUsecase;

  EnrolledCoursesPageCubit(
      this._getEnrolledCoursesUsecase, this._sessionInfoService)
      : super(EnrolledCoursesPageState.loading());

  Future<void> init() async {
    emit(EnrolledCoursesPageState.loading());
    try {
      final sessionInfo = await _sessionInfoService.getSessionInfo();
      final nextState = EnrolledCoursesPageState.success(
        academicReport: sessionInfo.academicReport,
        semesterContext: sessionInfo.semesterContext,
        selectedSemester: sessionInfo.semesterContext.defaultSemester,
        enrolledCourses: const EnrolledCoursesState.loading(),
      ) as CoursesPageSuccessState;
      emit(nextState);
      _fetchEnrolledCourses(nextState);
    } catch (e, s) {
      if (kDebugMode) {
        print(e);
        print(s);
      }
      emit(EnrolledCoursesPageState.error(e.toString()));
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

  void changeSemester(ScheduledTermIdentifier semester) {
    state.mapOrNull(
      success: (state) {
        final nextState = state.copyWith(
          selectedSemester: semester,
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
