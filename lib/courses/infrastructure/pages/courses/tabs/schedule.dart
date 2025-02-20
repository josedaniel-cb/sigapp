import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigapp/core/injection/get_it.dart';
import 'package:sigapp/core/widgets/error_state.dart';
import 'package:sigapp/core/widgets/loading_state.dart';
import 'package:sigapp/courses/infrastructure/pages/courses/partials/weekly_schedule.dart';
import 'package:sigapp/courses/infrastructure/pages/courses/courses_page_cubit.dart';
import 'package:sigapp/courses/infrastructure/pages/courses/partials/schedule_share_button.dart';
import 'package:sigapp/courses/infrastructure/pages/courses/partials/schedule_share_button_cubit.dart';
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
      return _buildEmpty();
    }

    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            WeeklyScheduleWidget(
              courses: enrolledCourses,
            ),
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

  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.schedule, size: 80, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            "No tienes cursos inscritos este semestre",
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
