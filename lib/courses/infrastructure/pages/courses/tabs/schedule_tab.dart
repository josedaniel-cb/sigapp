import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigapp/core/injection/get_it.dart';
import 'package:sigapp/core/infrastructure/ui/widgets/error_state.dart';
import 'package:sigapp/core/infrastructure/ui/widgets/loading_state.dart';
import 'package:sigapp/courses/infrastructure/pages/courses/partials/empty_courses.dart';
import 'package:sigapp/courses/infrastructure/pages/courses/tabs/enrolled_courses_tab.dart';
import 'package:sigapp/courses/infrastructure/pages/courses/tabs/schedule_tab/weekly_schedule.dart';
import 'package:sigapp/courses/infrastructure/pages/courses/courses_page_cubit.dart';
import 'package:sigapp/courses/infrastructure/pages/courses/tabs/schedule_tab/schedule_share_button.dart';
import 'package:sigapp/courses/infrastructure/pages/courses/tabs/schedule_tab/schedule_share_button_cubit.dart';
import 'package:sigapp/student/domain/entities/student_academic_report.dart';
import 'package:sigapp/student/domain/entities/student_semester_schedule.dart';

class ScheduleTabWidget extends StatelessWidget {
  const ScheduleTabWidget({
    super.key,
    required this.enrolledCoursesState,
    required this.onRetry,
    required this.selectedSemester,
    required this.academicReport,
  });

  final EnrolledCoursesState enrolledCoursesState;
  final SemesterScheduleSemesterMetadata selectedSemester;
  final AcademicReport academicReport;
  final void Function() onRetry;

  @override
  Widget build(BuildContext context) {
    return enrolledCoursesState.map(
      loading: (_) => LoadingStateWidget(),
      error: (state) => ErrorStateWidget(
        message: state.message,
        onRetry: onRetry,
      ),
      success: (state) => _buildSuccessState(context, state),
    );
  }

  Widget _buildSuccessState(
      BuildContext context, EnrolledCoursesSuccessState state) {
    final enrolledCourses = state.value;

    if (enrolledCourses.isEmpty) {
      return EmptyCoursesWidget();
    }

    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            WeeklyScheduleWidget(courses: enrolledCourses),
          ],
        ),
      ),
      floatingActionButton: BlocProvider(
        create: (context) => getIt<ScheduleShareButtonCubit>(),
        child: ScheduleShareButtonWidget(
          enrolledCourses: enrolledCourses,
          selectedSemester: selectedSemester,
          academicReport: academicReport,
        ),
      ),
    );
  }
}
