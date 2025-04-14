import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigapp/courses/domain/entities/grade_tracking.dart';
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
        state.maybeWhen(
          error: (message) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message ??
                    'Error al procesar datos de seguimiento de notas'),
                duration: const Duration(seconds: 3),
              ),
            );
          },
          orElse: () {},
        );
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
                      _HelpButton(),
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
    return state.maybeMap(
      empty: (_) => _EmptyStateView(
        enrolledCourse: widget.enrolledCourse,
        cubit: _cubit,
      ),
      loading: (_) => const _LoadingStateView(),
      ready: (readyState) => _ReadyStateView(
        tracking: readyState.courseTracking,
        cubit: _cubit,
      ),
      error: (errorState) => _ErrorStateView(
        errorMessage: errorState.message,
        onRetry: () => _cubit.retry(),
      ),
      orElse: () => const SizedBox.shrink(),
    );
  }
}

// Componentes privados extraídos

class _LoadingStateView extends StatelessWidget {
  const _LoadingStateView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(32.0),
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class _ErrorStateView extends StatelessWidget {
  const _ErrorStateView({
    required this.errorMessage,
    required this.onRetry,
  });

  final String? errorMessage;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 48,
            ),
            const SizedBox(height: 16),
            Text(
              'Ocurrió un error al cargar el seguimiento de notas',
              textAlign: TextAlign.center,
              style: textTheme.bodyLarge,
            ),
            if (errorMessage != null) ...[
              const SizedBox(height: 8),
              Text(
                errorMessage!,
                textAlign: TextAlign.center,
                style: textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
            ],
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Reintentar'),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyStateView extends StatelessWidget {
  const _EmptyStateView({
    required this.enrolledCourse,
    required this.cubit,
  });

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
  const _ReadyStateView({
    required this.tracking,
    required this.cubit,
  });

  final CourseTracking tracking;
  final GradeTrackerSectionCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _FinalGradeCard(tracking: tracking),
        const SizedBox(height: 8),
        ...tracking.categories.map((category) {
          return _CategoryCard(
            category: category,
            cubit: cubit,
          );
        }),
        const SizedBox(height: 12),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Recuerda que estos cálculos se borrarán al cerrar sesión.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                ),
          ),
        ),
        const SizedBox(height: 8),
        _AddCategoryButton(cubit: cubit),
        const SizedBox(height: 8),
      ],
    );
  }
}

class _FinalGradeCard extends StatelessWidget {
  const _FinalGradeCard({
    required this.tracking,
  });

  final CourseTracking tracking;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Promedio ponderado',
                  style: textTheme.titleMedium,
                ),
                Text(
                  tracking.finalGrade.toStringAsFixed(2),
                  style: textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: _getColorForGrade(tracking.finalGrade),
                  ),
                ),
              ],
            ),
            if (!tracking.isWeightValid) ...[
              SizedBox(height: 8),
              Text(
                '${tracking.weightDifference > 0 ? 'Falta ${tracking.weightDifference.toStringAsFixed(2)}% para completar los pesos ponderados' : ' Los pesos ponderados exceden el 100% en ${tracking.weightDifference.abs().toStringAsFixed(2)}%'}. El cálculo no es correcto.',
                style: textTheme.bodyMedium,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({
    required this.category,
    required this.cubit,
  });

  final GradeCategory category;
  final GradeTrackerSectionCubit cubit;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    category.name,
                    style: textTheme.titleMedium,
                  ),
                ),
                Text(
                  'Peso: ${category.weight.toStringAsFixed(0)}%',
                  style: textTheme.bodyMedium,
                ),
                const SizedBox(width: 8),
                _CategoryPopupMenu(
                  category: category,
                  cubit: cubit,
                ),
              ],
            ),
            const Divider(),
            if (category.grades.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text('No hay notas registradas'),
              )
            else
              ...category.grades.map((grade) {
                return _GradeItem(
                  categoryId: category.id,
                  grade: grade,
                  cubit: cubit,
                );
              }),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    style: textTheme.titleMedium,
                    children: [
                      TextSpan(text: 'Promedio: '),
                      TextSpan(
                        text: category.averagePercentage.toStringAsFixed(2),
                        style: TextStyle(
                          color: _getColorForGrade(category.averagePercentage),
                        ),
                      ),
                    ],
                  ),
                ),
                OutlinedButton.icon(
                  onPressed: () {
                    _showAddGradeDialog(context, category.id, cubit);
                  },
                  icon: const Icon(Icons.add, size: 16),
                  label: const Text('Añadir nota'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _GradeItem extends StatelessWidget {
  const _GradeItem({
    required this.categoryId,
    required this.grade,
    required this.cubit,
  });

  final String categoryId;
  final Grade grade;
  final GradeTrackerSectionCubit cubit;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(grade.name, style: textTheme.bodyLarge),
      subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          grade.score.toStringAsFixed(2),
          style: textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w500,
            color: grade.enabled ? _getColorForGrade(grade.score) : Colors.grey,
          ),
        ),
        const SizedBox(height: 8),
        if (!grade.enabled)
          Text('No considerar',
              style: textTheme.bodyMedium?.copyWith(
                fontStyle: FontStyle.italic,
                color: Colors.grey[600],
              ))
      ]),
      leading: Switch(
        value: grade.enabled,
        onChanged: (value) {
          cubit.toggleGradeEnabled(
            categoryId: categoryId,
            gradeId: grade.id,
            enabled: value,
          );
        },
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.edit, size: 20),
            onPressed: () {
              _showEditGradeDialog(context, categoryId, grade, cubit);
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete, size: 20),
            onPressed: () {
              _showDeleteGradeDialog(context, categoryId, grade, cubit);
            },
          ),
        ],
      ),
    );
  }
}

class _CategoryPopupMenu extends StatelessWidget {
  const _CategoryPopupMenu({
    required this.category,
    required this.cubit,
  });

  final GradeCategory category;
  final GradeTrackerSectionCubit cubit;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert),
      onSelected: (value) {
        if (value == 'edit') {
          _showEditCategoryDialog(context, category, cubit);
        } else if (value == 'delete') {
          _showDeleteCategoryDialog(context, category, cubit);
        }
      },
      itemBuilder: (context) => [
        const PopupMenuItem<String>(
          value: 'edit',
          child: ListTile(
            leading: Icon(Icons.edit),
            title: Text('Editar'),
            contentPadding: EdgeInsets.zero,
          ),
        ),
        const PopupMenuItem<String>(
          value: 'delete',
          child: ListTile(
            leading: Icon(Icons.delete),
            title: Text('Eliminar'),
            contentPadding: EdgeInsets.zero,
          ),
        ),
      ],
    );
  }
}

class _AddCategoryButton extends StatelessWidget {
  const _AddCategoryButton({
    required this.cubit,
  });

  final GradeTrackerSectionCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton.icon(
        onPressed: () {
          _showAddCategoryDialog(context, cubit);
        },
        icon: const Icon(Icons.add),
        label: const Text('Añadir categoría'),
      ),
    );
  }
}

class _HelpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.help_outline),
      color: Theme.of(context).colorScheme.primary,
      onPressed: () {
        _showHelpDialog(context);
      },
    );
  }
}

// Funciones de diálogo extraídas como funciones privadas independientes

void _showHelpDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('¿Cómo funciona?'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Puedes anticipar tu promedio final en el curso al registrar tus notas y los pesos ponderados de cada categoría:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('• La suma de los pesos ponderados debe ser 100%'),
            Text(
                '• Puedes activar/desactivar notas específicas para simular su impacto en tu promedio'),
            SizedBox(height: 16),
            Text(
              'Este cálculo no tiene validez oficial y es solo una herramienta de referencia.',
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cerrar'),
          ),
        ],
      );
    },
  );
}

void _showAddCategoryDialog(
    BuildContext context, GradeTrackerSectionCubit cubit) {
  final formKey = GlobalKey<FormState>();
  String name = '';
  double weight = 0;
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Añadir categoría'),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa un nombre';
                  }
                  return null;
                },
                onSaved: (value) => name = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Peso (%)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa un peso';
                  }
                  try {
                    final weight = double.parse(value);
                    if (weight <= 0 || weight > 100) {
                      return 'El peso debe estar entre 1 y 100';
                    }
                  } catch (_) {
                    return 'Por favor ingresa un número válido';
                  }
                  return null;
                },
                onSaved: (value) => weight = double.parse(value!),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                formKey.currentState!.save();
                cubit.addCategory(
                  name: name,
                  weight: weight,
                );
                Navigator.pop(context);
              }
            },
            child: const Text('Guardar'),
          ),
        ],
      );
    },
  );
}

void _showEditCategoryDialog(BuildContext context, GradeCategory category,
    GradeTrackerSectionCubit cubit) {
  final formKey = GlobalKey<FormState>();
  String name = category.name;
  double weight = category.weight;
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Editar categoría'),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nombre'),
                initialValue: category.name,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa un nombre';
                  }
                  return null;
                },
                onSaved: (value) => name = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Peso (%)'),
                initialValue: category.weight.toString(),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa un peso';
                  }
                  try {
                    final weight = double.parse(value);
                    if (weight <= 0 || weight > 100) {
                      return 'El peso debe estar entre 1 y 100';
                    }
                  } catch (_) {
                    return 'Por favor ingresa un número válido';
                  }
                  return null;
                },
                onSaved: (value) => weight = double.parse(value!),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                formKey.currentState!.save();
                cubit.updateCategory(
                  categoryId: category.id,
                  newName: name,
                  newWeight: weight,
                );
                Navigator.pop(context);
              }
            },
            child: const Text('Guardar'),
          ),
        ],
      );
    },
  );
}

void _showDeleteCategoryDialog(BuildContext context, GradeCategory category,
    GradeTrackerSectionCubit cubit) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Eliminar categoría'),
        content: Text(
            '¿Estás seguro que deseas eliminar la categoría "${category.name}" y todas sus notas?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () {
              cubit.deleteCategory(
                categoryId: category.id,
              );
              Navigator.pop(context);
            },
            child: const Text('Eliminar'),
          ),
        ],
      );
    },
  );
}

void _showAddGradeDialog(
    BuildContext context, String categoryId, GradeTrackerSectionCubit cubit) {
  final formKey = GlobalKey<FormState>();
  String name = '';
  double score = 0;

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Añadir nota'),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa un nombre';
                  }
                  return null;
                },
                onSaved: (value) => name = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nota (0-20)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa una nota';
                  }
                  try {
                    final score = double.parse(value);
                    if (score < 0 || score > 20) {
                      return 'La nota debe estar entre 0 y 20';
                    }
                  } catch (_) {
                    return 'Por favor ingresa un número válido';
                  }
                  return null;
                },
                onSaved: (value) => score = double.parse(value!),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                formKey.currentState!.save();
                cubit.addGrade(
                  categoryId: categoryId,
                  name: name,
                  score: score,
                );
                Navigator.pop(context);
              }
            },
            child: const Text('Guardar'),
          ),
        ],
      );
    },
  );
}

void _showEditGradeDialog(BuildContext context, String categoryId, Grade grade,
    GradeTrackerSectionCubit cubit) {
  final formKey = GlobalKey<FormState>();
  String name = grade.name;
  double score = grade.score;
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Editar nota'),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nombre'),
                initialValue: grade.name,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa un nombre';
                  }
                  return null;
                },
                onSaved: (value) => name = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nota (0-20)'),
                initialValue: grade.score.toString(),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa una nota';
                  }
                  try {
                    final score = double.parse(value);
                    if (score < 0 || score > 20) {
                      return 'La nota debe estar entre 0 y 20';
                    }
                  } catch (_) {
                    return 'Por favor ingresa un número válido';
                  }
                  return null;
                },
                onSaved: (value) => score = double.parse(value!),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                formKey.currentState!.save();
                cubit.updateGrade(
                  categoryId: categoryId,
                  gradeId: grade.id,
                  newName: name,
                  newScore: score,
                );
                Navigator.pop(context);
              }
            },
            child: const Text('Guardar'),
          ),
        ],
      );
    },
  );
}

void _showDeleteGradeDialog(BuildContext context, String categoryId,
    Grade grade, GradeTrackerSectionCubit cubit) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Eliminar nota'),
        content:
            Text('¿Estás seguro que deseas eliminar la nota "${grade.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () {
              cubit.deleteGrade(
                categoryId: categoryId,
                gradeId: grade.id,
              );
              Navigator.pop(context);
            },
            child: const Text('Eliminar'),
          ),
        ],
      );
    },
  );
}

// Función de utilidad para determinar el color de la nota
Color _getColorForGrade(double grade) {
  if (grade >= 14) {
    return Colors.green;
  } else if (grade >= 11) {
    return Colors.amber.shade800;
  } else {
    return Colors.red;
  }
}
