import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigapp/core/injection/get_it.dart';
import 'package:sigapp/core/infrastructure/ui/utils/colors_utils.dart';
import 'package:sigapp/core/infrastructure/ui/widgets/error_state.dart';
import 'package:sigapp/courses/infrastructure/pages/course_detail/course_detail_cubit.dart';
import 'package:sigapp/courses/infrastructure/pages/enrolled_courses/enrolled_courses_page_cubit.dart';
import 'package:sigapp/courses/infrastructure/pages/enrolled_courses/partials/empty_courses.dart';
import 'package:sigapp/courses/infrastructure/pages/enrolled_courses/tabs/enrolled_courses_tab/course_item.dart';
import 'package:skeletonizer/skeletonizer.dart';

class EnrolledCoursesTabWidget extends StatelessWidget {
  const EnrolledCoursesTabWidget(
      {super.key, required this.enrolledCourses, required this.onRetry});

  final EnrolledCoursesState enrolledCourses;
  final void Function() onRetry;

  @override
  Widget build(BuildContext context) {
    return enrolledCourses.map(
      loading: (_) => _buildSkeleton(),
      error: (state) => ErrorStateWidget(
        message: state.message,
        onRetry: onRetry,
      ),
      success: (state) => _buildSuccessState(state),
    );
  }

  Widget _buildSkeleton() {
    return Skeletonizer.zone(
      child: ListView.builder(
        itemCount: 4,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, i) {
          return Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Bone.text(width: MediaQuery.of(context).size.width * 0.7),
                  SizedBox(height: 8),
                  Bone.text(width: MediaQuery.of(context).size.width * 0.8),
                  SizedBox(height: 8),
                  Bone.text(width: MediaQuery.of(context).size.width * 0.2),
                  SizedBox(height: 32),
                ],
              )
            ],
          );
        },
      ),
    );
  }

  Widget _buildSuccessState(EnrolledCoursesSuccessState state) {
    final courses = state.value;

    if (courses.isEmpty) {
      return EmptyCoursesWidget();
    }

    return ListView.builder(
      padding: const EdgeInsets.only(top: 16),
      itemCount: courses.length,
      itemBuilder: (context, index) {
        final course = courses[index];

        return BlocProvider(
          create: (_) {
            final newCubit = getIt<CourseDetailCubit>();
            newCubit.init(
              course: course,
              regevaScheduledCourseId: course.data.regevaScheduledCourseId,
            );
            return newCubit;
          },
          child: CourseItemWidget(
            color: ColorsUtils.getColorByIndex(index),
          ),
        );
      },
    );
  }
}
