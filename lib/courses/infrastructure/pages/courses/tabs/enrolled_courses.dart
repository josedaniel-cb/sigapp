import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigapp/core/widgets/error_state.dart';
import 'package:open_filex/open_filex.dart';
import 'package:sigapp/courses/infrastructure/pages/courses/tabs/enrolled_courses_cubit.dart';
import 'package:sigapp/student/domain/entities/student_semester_schedule.dart';
import 'package:skeletonizer/skeletonizer.dart';

class EnrolledCoursesTabWidget extends StatefulWidget {
  const EnrolledCoursesTabWidget({super.key, required this.semester});

  final SemesterScheduleSemesterMetadata semester;

  @override
  State<EnrolledCoursesTabWidget> createState() =>
      _EnrolledCoursesTabWidgetState();
}

class _EnrolledCoursesTabWidgetState extends State<EnrolledCoursesTabWidget>
    with TickerProviderStateMixin {
  late final EnrolledCoursesTabCubit _cubit;

  @override
  void initState() {
    _cubit = BlocProvider.of<EnrolledCoursesTabCubit>(context);
    _cubit.fetch(widget.semester);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EnrolledCoursesTabCubit, EnrolledCoursesTabState>(
      builder: (context, state) {
        return state.map(
          loading: (_) => _buildSkeleton(),
          error: (state) => ErrorStateWidget(
            message: state.message,
            onRetry: () => _cubit.fetch(widget.semester),
          ),
          success: (state) => _buildSuccessState(state),
        );
      },
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

  Widget _buildSuccessState(EnrolledCoursesTabSuccessState state) {
    if (state.courses.isEmpty) {
      return _buildEmpty();
    }

    return ListView.builder(
      itemCount: state.courses.length,
      itemBuilder: (context, index) {
        final course = state.courses[index];
        return ListTile(
          title: Text(course.data.courseName),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Grupo ${course.data.group}'
                  ' - Sección ${course.data.section}'),
              if (course.syllabusState != null)
                (() {
                  switch (course.syllabusState!) {
                    case SyllabusState.loading:
                      return TextButton.icon(
                        icon: SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 3)),
                        label: Text('Syllabus'),
                        onPressed: null,
                      );
                    case SyllabusState.available:
                      return TextButton.icon(
                        icon: Icon(Icons.book_outlined),
                        label: Text('Syllabus'),
                        onPressed: () {
                          OpenFilex.open(course.syllabusFile!.path);
                        },
                      );
                    case SyllabusState.error:
                      return Text('Error al descargar syllabus');
                    case SyllabusState.notFound:
                      return TextButton.icon(
                        icon: Icon(Icons.book_outlined),
                        label: Text('Syllabus'),
                        onPressed: null,
                      );
                  }
                })()
              else
                TextButton.icon(
                    icon: Icon(Icons.book_outlined),
                    label: Text('Syllabus'),
                    onPressed: null),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.book, size: 80, color: Colors.grey),
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
