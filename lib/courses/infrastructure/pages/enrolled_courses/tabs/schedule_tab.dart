import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigapp/core/injection/get_it.dart';
import 'package:sigapp/core/infrastructure/ui/widgets/error_state.dart';
import 'package:sigapp/core/infrastructure/ui/widgets/loading_state.dart';
import 'package:sigapp/courses/domain/entities/scheduled_term_identifier.dart';
import 'package:sigapp/courses/infrastructure/pages/enrolled_courses/partials/empty_courses.dart';
import 'package:sigapp/courses/infrastructure/pages/enrolled_courses/partials/weekly_schedule.dart';
import 'package:sigapp/courses/infrastructure/pages/enrolled_courses/partials/weekly_schedule/course_details_dialog.dart';
import 'package:sigapp/courses/infrastructure/pages/enrolled_courses/partials/weekly_schedule/course_visibility_cubit.dart';
import 'package:sigapp/courses/infrastructure/pages/enrolled_courses/enrolled_courses_page_cubit.dart';
import 'package:sigapp/courses/infrastructure/pages/enrolled_courses/tabs/schedule_tab/schedule_share_button.dart';
import 'package:sigapp/courses/infrastructure/pages/enrolled_courses/tabs/schedule_tab/schedule_share_button_cubit.dart';
import 'package:sigapp/student/domain/entities/student_academic_report.dart';

class ScheduleTabWidget extends StatelessWidget {
  const ScheduleTabWidget({
    super.key,
    required this.enrolledCoursesState,
    required this.onRetry,
    required this.selectedSemester,
    required this.academicReport,
  });

  final EnrolledCoursesState enrolledCoursesState;
  final ScheduledTermIdentifier selectedSemester;
  final AcademicReport academicReport;
  final void Function() onRetry;

  @override
  Widget build(BuildContext context) {
    return enrolledCoursesState.map(
      loading: (_) => LoadingStateWidget(),
      error: (state) => ErrorStateWidget.from(
        state.error,
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

    // Crear una instancia de WeeklyScheduleWidget para obtener la lista de eventos
    final weeklyScheduleWidget = WeeklyScheduleWidget(
      courses: enrolledCourses,
    );

    return BlocProvider(
      create: (context) {
        final cubit = CourseVisibilityCubit();
        // Cargar los eventos ocultos
        cubit.loadHiddenEvents(weeklyScheduleWidget.events);
        return cubit;
      },
      child: Builder(builder: (context) {
        return Scaffold(
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                // Usar BlocBuilder para reconstruir el widget cuando cambie el estado
                BlocBuilder<CourseVisibilityCubit, CourseVisibilityState>(
                  builder: (context, state) {
                    return WeeklyScheduleWidget(
                      courses: enrolledCourses,
                      onEventTap: (event) => _showCourseDetails(context, event),
                    );
                  },
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
      }),
    );
  }

  void _showCourseDetails(
      BuildContext context, WeeklyScheduleWidgetItem event) {
    // Usar el Cubit existente en lugar de crear uno nuevo
    final cubit = BlocProvider.of<CourseVisibilityCubit>(context);

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        // Reutilizar el mismo Cubit para el diálogo
        return BlocProvider.value(
          value: cubit,
          child: CourseDetailsDialog(
            event: event,
          ),
        );
      },
    );
  }
}
