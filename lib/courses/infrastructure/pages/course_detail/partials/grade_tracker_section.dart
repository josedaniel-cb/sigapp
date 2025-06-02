import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigapp/core/infrastructure/ui/widgets/error_state.dart';
import 'package:sigapp/core/infrastructure/ui/widgets/loading_state.dart';
import 'package:sigapp/courses/domain/entities/grade_tracking.dart';
import 'package:sigapp/courses/infrastructure/pages/course_detail/partials/grade_tracker_section/widgets.dart';
import 'package:sigapp/courses/infrastructure/pages/course_detail/partials/grade_tracker_section_cubit.dart';
import 'package:sigapp/student/domain/value_objects/enrolled_course.dart';

class GradeTrackerSectionWidget extends StatefulWidget {
  const GradeTrackerSectionWidget({super.key, required this.enrolledCourse});

  final EnrolledCourse enrolledCourse;

  @override
  State<GradeTrackerSectionWidget> createState() =>
      _GradeTrackerSectionWidgetState();
}

class _GradeTrackerSectionWidgetState extends State<GradeTrackerSectionWidget> {
  bool _initialized = false;
  late final GradeTrackerSectionCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of<GradeTrackerSectionCubit>(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_initialized) {
        context.read<GradeTrackerSectionCubit>().init(
          courseId: widget.enrolledCourse.data.courseCode,
        );
        _initialized = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BlocConsumer<GradeTrackerSectionCubit, GradeTrackerSectionState>(
      listener: (context, state) {
        switch (state) {
          case GradeTrackerSectionErrorState(error: final error):
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(error.toString()),
                duration: const Duration(seconds: 3),
              ),
            );
          default:
            break;
        }
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 16),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Simulador de notas',
                        style: textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 8),
                      HelpButtonWidget(),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            _buildContent(context, state),
          ],
        );
      },
    );
  }

  Widget _buildContent(BuildContext context, GradeTrackerSectionState state) {
    return switch (state) {
      GradeTrackerSectionEmptyState() => _EmptyStateView(
        enrolledCourse: widget.enrolledCourse,
        cubit: _cubit,
      ),
      GradeTrackerSectionLoadingState() => const LoadingStateWidget(),
      GradeTrackerSectionReadyState(courseTracking: final tracking) =>
        _ReadyStateView(tracking: tracking, cubit: _cubit),
      GradeTrackerSectionErrorState(error: final error) =>
        ErrorStateWidget.from(error, onRetry: () => _cubit.retry()),
    };
  }
}

class _EmptyStateView extends StatelessWidget {
  const _EmptyStateView({required this.enrolledCourse, required this.cubit});

  final EnrolledCourse enrolledCourse;
  final GradeTrackerSectionCubit cubit;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Registra tus notas y simula tu promedio ponderado final.',
            style: textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          Center(
            child: ElevatedButton.icon(
              onPressed: () {
                cubit.createCourseTracking(
                  courseName: enrolledCourse.data.courseName,
                );
              },
              icon: const Icon(Icons.add),
              label: const Text('Iniciar'),
            ),
          ),
        ],
      ),
    );
  }
}

class _ReadyStateView extends StatelessWidget {
  const _ReadyStateView({required this.tracking, required this.cubit});

  final CourseTracking tracking;
  final GradeTrackerSectionCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FinalGradeCardWidget(tracking: tracking),
        const SizedBox(height: 8),
        ...tracking.categories.map((category) {
          return CategoryCardWidget(category: category, cubit: cubit);
        }),
        // const SizedBox(height: 12),
        // Container(
        //   margin: const EdgeInsets.symmetric(horizontal: 16),
        //   child: Text(
        //     'Recuerda que estos cálculos se borrarán al cerrar sesión.',
        //     style: Theme.of(context).textTheme.bodyMedium?.copyWith(
        //           color: Colors.grey[600],
        //         ),
        //   ),
        // ),
        const SizedBox(height: 8),
        AddCategoryButtonWidget(cubit: cubit),
        const SizedBox(height: 8),
      ],
    );
  }
}
