import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:sigapp/courses/application/usecases/get_enrolled_courses_usecase.dart';
import 'package:sigapp/semester/domain/value-objects/semester_context.dart';
import 'package:sigapp/student/domain/entities/student_academic_report.dart';
import 'package:sigapp/student/domain/entities/student_semester_schedule.dart';
import 'package:sigapp/student/domain/services/student_info_service.dart';
import 'package:sigapp/student/domain/value_objects/enrolled_course.dart';

part 'career_page_cubit.freezed.dart';

@freezed
abstract class CareerPageState with _$CareerPageState {
  const factory CareerPageState.loading() = CareerPageLoadingState;
  const factory CareerPageState.success(
      // {
      // required AcademicReport academicReport,
      // required SemesterContext semesterContext,
      // required SemesterScheduleSemesterMetadata selectedSemester,
      // required EnrolledCoursesState enrolledCourses,
      // }
      ) = CareerPageSuccessState;
  const factory CareerPageState.error(String message) = CareerPageErrorState;
}

// @singleton
@injectable
class CareerPageCubit extends Cubit<CareerPageState> {
  final SessionInfoService _sessionInfoService;
  final GetEnrolledCoursesUsecase _getEnrolledCoursesUsecase;

  CareerPageCubit(this._getEnrolledCoursesUsecase, this._sessionInfoService)
      : super(CareerPageState.loading());

  Future<void> init() async {
    emit(CareerPageState.loading());
    try {
      final sessionInfo = await _sessionInfoService.getSessionInfo();
      final nextState = CareerPageState.success(
          // academicReport: sessionInfo.academicReport,
          // semesterContext: sessionInfo.semesterContext,
          // selectedSemester: sessionInfo.semesterContext.defaultSemester,
          // enrolledCourses: const EnrolledCoursesState.loading(),
          ) as CareerPageSuccessState;
      emit(nextState);
      // _fetchEnrolledCourses(nextState);
    } catch (e) {
      emit(CareerPageState.error(e.toString()));
    }
  }

  // void retryFetchEnrolledCourses() {
  //   state.mapOrNull(
  //     success: (state) {
  //       final nextState = state.copyWith(
  //         // enrolledCourses: EnrolledCoursesState.loading(),
  //       ) as CareerPageSuccessState;
  //       emit(nextState);
  //       _fetchEnrolledCourses(nextState);
  //     },
  //   );
  // }

  // void changeSemester(SemesterScheduleSemesterMetadata semester) {
  //   state.mapOrNull(
  //     success: (state) {
  //       final nextState = state.copyWith(
  //         // selectedSemester: semester,
  //         // enrolledCourses: EnrolledCoursesState.loading(),
  //       ) as CareerPageSuccessState;
  //       emit(nextState);
  //       _fetchEnrolledCourses(nextState);
  //     },
  //   );
  // }

  // void _fetchEnrolledCourses(CareerPageSuccessState state) {
  //   _getEnrolledCoursesUsecase
  //       .execute(state.selectedSemester.id)
  //       .then((courses) {
  //     emit(state.copyWith(
  //       enrolledCourses: EnrolledCoursesState.success(value: courses),
  //     ));
  //   }).catchError((e) {
  //     emit(state.copyWith(
  //       enrolledCourses: EnrolledCoursesState.error(e.toString()),
  //     ));
  //   });
  // }
}
