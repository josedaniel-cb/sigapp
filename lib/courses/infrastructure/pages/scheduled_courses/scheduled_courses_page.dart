import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigapp/core/infrastructure/ui/widgets/error_state.dart';
import 'package:sigapp/courses/domain/entities/scheduled_course.dart';
import 'package:sigapp/courses/infrastructure/pages/scheduled_courses/scheduled_courses_cubit.dart';

class ScheduledCoursesPage extends StatelessWidget {
  static const String route = '/courses/scheduled';

  const ScheduledCoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScheduledCoursesPageCubit, ScheduledCoursesPageState>(
      builder: (context, state) {
        return switch (state) {
          CoursesPageLoadingState() => Scaffold(
            body: Center(child: CircularProgressIndicator()),
          ),
          ScheduledCoursesPageSuccessState() => _buildSuccess(context, state),
          CoursesPageErrorState(:final error) => Scaffold(
            body: ErrorStateWidget.from(
              error,
              onRetry: () {
                BlocProvider.of<ScheduledCoursesPageCubit>(context).setup();
              },
            ),
          ),
        };
      },
    );
  }

  Widget _buildSuccess(
    BuildContext context,
    ScheduledCoursesPageSuccessState state,
  ) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Programación académica',
          style: textTheme.titleLarge?.copyWith(
            fontSize:
                textTheme.titleLarge?.fontSize != null
                    ? textTheme.titleLarge!.fontSize! * 0.85
                    : null,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  decoration: const InputDecoration(
                    labelText: 'Buscar cursos',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                    hintText: 'Ingresa código, nombre, profesor, etc.',
                    filled: true,
                    isDense: true,
                  ),
                  onChanged: (query) {
                    context.read<ScheduledCoursesPageCubit>().searchCourses(
                      query,
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total: ${state.filteredCourses.length} cursos',
                      style: textTheme.titleSmall,
                    ),
                    if (state.searchQuery.isNotEmpty)
                      Text(
                        'Filtrados de ${state.scheduledCourses.length}',
                        style: textTheme.titleSmall,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body:
          state.filteredCourses.isEmpty
              ? Center(
                child: Text(
                  state.searchQuery.isEmpty
                      ? 'No hay cursos disponibles'
                      : 'No se encontraron resultados para "${state.searchQuery}"',
                  style: const TextStyle(fontSize: 16),
                ),
              )
              : ListView.builder(
                itemCount: state.filteredCourses.length,
                itemBuilder: (context, index) {
                  final course = state.filteredCourses[index];
                  return Column(
                    children: [
                      const Divider(),
                      _CourseListTile(course: course),
                    ],
                  );
                },
              ),
    );
  }
}

class _CourseListTile extends StatelessWidget {
  final ScheduledCourse course;

  const _CourseListTile({required this.course});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ListTile(
      title: Row(
        children: [
          Expanded(
            child: Text(
              course.courseCode,
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          _buildCustomChip(
            context,
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            text: 'Grupo ${course.groupCode.trim()}',
          ),
          const SizedBox(width: 4),
          _buildCustomChip(
            context,
            backgroundColor: Theme.of(
              context,
            ).colorScheme.secondary.withValues(alpha: 0.4),
            text: 'Sección ${course.section}',
          ),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          Text(
            course.courseDescription,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.person, size: 16),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  'Teoría: ${course.theoryTeacher}',
                  style: textTheme.bodyMedium,
                ),
              ),
            ],
          ),
          if (course.practiceTeacher != course.theoryTeacher)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Row(
                children: [
                  const Icon(Icons.person, size: 16),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      'Práctica: ${course.practiceTeacher}',
                      style: textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.room, size: 16),
              const SizedBox(width: 4),
              Text(
                'Aula: ${course.classroomDescription}',
                style: textTheme.bodyMedium,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Clave: ${course.courseKey}', style: textTheme.bodySmall),
              Text(
                'Capacidad: ${course.enrollmentCapacity}',
                style: textTheme.bodySmall,
              ),
            ],
          ),
        ],
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    );
  }

  Container _buildCustomChip(
    BuildContext context, {
    required Color backgroundColor,
    required String text,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: backgroundColor,
      ),
      child: Text(text),
    );
  }
}
