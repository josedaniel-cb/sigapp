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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cursos programados'),
      ),
      body: BlocBuilder<ScheduledCoursesPageCubit, ScheduledCoursesPageState>(
        builder: (context, state) {
          return state.map(
            loading: (_) => const Center(
              child: CircularProgressIndicator(),
            ),
            success: (state) => _buildSuccess(context, state),
            error: (state) => ErrorStateWidget(
              message: state.message,
              onRetry: () {
                context.read<ScheduledCoursesPageCubit>().setup();
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildSuccess(
      BuildContext context, ScheduledCoursesPageSuccessState state) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            decoration: const InputDecoration(
                labelText: 'Buscar cursos',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
                hintText: 'Ingresa código, nombre, profesor, etc.'),
            onChanged: (query) {
              context.read<ScheduledCoursesPageCubit>().searchCourses(query);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total: ${state.filteredCourses.length} cursos',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              if (state.searchQuery.isNotEmpty)
                Text(
                  'Filtrados de ${state.scheduledCourses.length}',
                  style: const TextStyle(fontStyle: FontStyle.italic),
                ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: state.filteredCourses.isEmpty
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
                    return _CourseCard(course: course);
                  },
                ),
        ),
      ],
    );
  }
}

class _CourseCard extends StatelessWidget {
  final ScheduledCourse course;

  const _CourseCard({required this.course});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  course.courseCode,
                  style: theme.textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: theme.colorScheme.primaryContainer,
                  ),
                  child: Text('Grupo ${course.groupCode.trim()}'),
                ),
              ],
            ),
            const SizedBox(height: 8),
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
                    style: theme.textTheme.bodyMedium,
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
                        style: theme.textTheme.bodyMedium,
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
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Cupos: ${course.availableSlots}/${course.enrollmentCapacity}',
                  style: theme.textTheme.bodySmall,
                ),
                Text(
                  'Inscritos: ${course.enrolledStudents}',
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
