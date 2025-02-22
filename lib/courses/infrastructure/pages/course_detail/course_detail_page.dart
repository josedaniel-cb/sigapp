import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigapp/courses/infrastructure/pages/course_detail/course_detail_cubit.dart';

class CourseDetailPageWidget extends StatefulWidget {
  const CourseDetailPageWidget({super.key});

  @override
  State<CourseDetailPageWidget> createState() => _CourseDetailPageWidgetState();
}

class _CourseDetailPageWidgetState extends State<CourseDetailPageWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CourseDetailCubit, CourseDetailState>(
      builder: (context, state) {
        // return Scaffold(
        //   appBar: AppBar(
        //     title: const Text('Detalle del curso'),
        //   ),
        //   body: Center(
        //     child: Text(state.toString()),
        //   ),
        // );
        return state.map(
          empty: (_) => Container(),
          ready: (state) => Scaffold(
            appBar: AppBar(
              title: Text('Detalle de; curso'),
            ),
            body: Center(
              child: Text(state.course.toString()),
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
