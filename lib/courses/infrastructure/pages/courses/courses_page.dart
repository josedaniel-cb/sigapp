import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigapp/core/widgets/error_state.dart';
import 'package:sigapp/core/widgets/loading_state.dart';
import 'package:sigapp/courses/infrastructure/pages/courses/courses_page_cubit.dart';

class CoursesPageWidget extends StatefulWidget {
  const CoursesPageWidget({super.key});

  @override
  State<CoursesPageWidget> createState() => _CoursesPageWidgetState();
}

class _CoursesPageWidgetState extends State<CoursesPageWidget> {
  @override
  void initState() {
    BlocProvider.of<CoursesPageCubit>(context).init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoursesPageCubit, CoursesPageState>(
      builder: (context, state) => state.map(
        loading: (_) => LoadingStateWidget(),
        error: (state) => ErrorStateWidget(
          message: state.message,
          onRetry: () => BlocProvider.of<CoursesPageCubit>(context).init(),
        ),
        success: (state) => _buildSuccessState(state),
      ),
    );
  }

  Widget _buildSuccessState(CoursesPageSuccessState state) {
    return ListView.builder(
      itemCount: state.courses.length,
      itemBuilder: (context, index) {
        final course = state.courses[index];
        return ListTile(
          title: Text(course.courseName),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(course.courseCode),
              // Text(course.teacher),
              Text('Grupo ${course.group} - Sección ${course.section}'),
            ],
          ),
        );
      },
    );
  }
}
