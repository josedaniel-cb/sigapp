import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigapp/core/widgets/error_state.dart';
import 'package:sigapp/core/widgets/loading_state.dart';
import 'package:sigapp/courses/infrastructure/pages/courses/courses_page_cubit.dart';
import 'package:open_filex/open_filex.dart';
import 'package:skeletonizer/skeletonizer.dart';

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
      builder: (context, state) {
        return state.map(
          loading: (_) => Skeletonizer.zone(
            child: _buildLoadingState(),
          ),
          error: (state) => ErrorStateWidget(
            message: state.message,
            onRetry: () => BlocProvider.of<CoursesPageCubit>(context).init(),
          ),
          success: (state) => _buildSuccessState(state),
        );
      },
    );
  }

  Widget _buildLoadingState() {
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
                  SizedBox(height: 16 * 2),
                ],
              )
            ],
          );
        },
      ),
    );
  }

  Widget _buildSuccessState(CoursesPageSuccessState state) {
    return ListView.builder(
      itemCount: state.courses.length,
      itemBuilder: (context, index) {
        final course = state.courses[index];
        return ListTile(
          title: Text(course.data.courseName),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(course.courseCode),
              // Text(course.teacher),
              Text(
                'Grupo ${course.data.group}'
                ' - '
                'Sección ${course.data.section}',
              ),
              if (course.syllabusState != null)
                (() {
                  switch (course.syllabusState) {
                    case SyllabusState.loading:
                      return TextButton.icon(
                        icon: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 3),
                        ),
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
                    default:
                      return Container();
                  }
                })()
              else
                TextButton.icon(
                  icon: Icon(Icons.book_outlined),
                  label: Text('Syllabus'),
                  onPressed: null,
                ),
            ],
          ),
        );
      },
    );
  }
}
