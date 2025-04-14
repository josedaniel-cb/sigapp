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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Seguimiento de notas',
                    style: textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 8),
                  _buildHelpButton(context),
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
      empty: (_) => _buildEmptyState(context),
      loading: (_) => _buildLoadingState(),
      ready: (readyState) =>
          _buildReadyState(context, readyState.courseTracking),
      error: (errorState) => _buildErrorState(context, errorState.message),
      orElse: () => const SizedBox.shrink(),
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(32.0),
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String? errorMessage) {
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
                errorMessage,
                textAlign: TextAlign.center,
                style: textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
            ],
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                _cubit.retry();
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Reintentar'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Aún no has configurado el seguimiento de notas para este curso.',
            style: textTheme.bodyLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'El seguimiento te permite registrar tus evaluaciones y calcular tu nota final según los pesos de cada categoría.',
            style: textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          Center(
            child: ElevatedButton.icon(
              onPressed: () {
                _cubit.createCourseTracking(
                  courseName: widget.enrolledCourse.data.courseName,
                );
              },
              icon: const Icon(Icons.add),
              label: const Text('Iniciar seguimiento'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReadyState(BuildContext context, CourseTracking tracking) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFinalGradeCard(context, tracking),
        const SizedBox(height: 8),
        ...tracking.categories.map((category) {
          return _buildCategoryCard(context, category);
        }),
        const SizedBox(height: 8),
        _buildAddCategoryButton(context),
      ],
    );
  }

  Widget _buildFinalGradeCard(BuildContext context, CourseTracking tracking) {
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
                  'Nota final estimada',
                  style: textTheme.titleMedium,
                ),
                Text(
                  tracking.finalGrade.toStringAsFixed(2),
                  style: textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: _getColorForGrade(tracking.finalGrade),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, GradeCategory category) {
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
                _buildCategoryPopupMenu(context, category),
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
                return _buildGradeItem(context, category.id, grade);
              }),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Promedio: ${category.averagePercentage.toStringAsFixed(2)}',
                  style: textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                OutlinedButton.icon(
                  onPressed: () {
                    _showAddGradeDialog(context, category.id);
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

  Widget _buildGradeItem(BuildContext context, String categoryId, Grade grade) {
    final textTheme = Theme.of(context).textTheme;

    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(grade.name, style: textTheme.bodyLarge),
      subtitle: grade.enabled
          ? null
          : Text('Desactivada',
              style: textTheme.bodyMedium?.copyWith(
                fontStyle: FontStyle.italic,
                color: Colors.grey[600],
              )),
      leading: Switch(
        value: grade.enabled,
        onChanged: (value) {
          _cubit.toggleGradeEnabled(
            categoryId: categoryId,
            gradeId: grade.id,
            enabled: value,
          );
        },
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            grade.score.toStringAsFixed(2),
            style: textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w500,
              color:
                  grade.enabled ? _getColorForGrade(grade.score) : Colors.grey,
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.edit, size: 20),
            onPressed: () {
              _showEditGradeDialog(context, categoryId, grade);
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete, size: 20),
            onPressed: () {
              _showDeleteGradeDialog(context, categoryId, grade);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryPopupMenu(BuildContext context, GradeCategory category) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert),
      onSelected: (value) {
        if (value == 'edit') {
          _showEditCategoryDialog(context, category);
        } else if (value == 'delete') {
          _showDeleteCategoryDialog(context, category);
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

  Widget _buildAddCategoryButton(BuildContext context) {
    return Center(
      child: TextButton.icon(
        onPressed: () {
          _showAddCategoryDialog(context);
        },
        icon: const Icon(Icons.add),
        label: const Text('Añadir categoría'),
      ),
    );
  }

  void _showAddCategoryDialog(BuildContext context) {
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
                  _cubit.addCategory(
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

  void _showEditCategoryDialog(BuildContext context, GradeCategory category) {
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
                  _cubit.updateCategory(
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

  void _showDeleteCategoryDialog(BuildContext context, GradeCategory category) {
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
            ElevatedButton(
              onPressed: () {
                _cubit.deleteCategory(
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

  void _showAddGradeDialog(BuildContext context, String categoryId) {
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
                  _cubit.addGrade(
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

  void _showEditGradeDialog(
      BuildContext context, String categoryId, Grade grade) {
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
                  _cubit.updateGrade(
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

  void _showDeleteGradeDialog(
      BuildContext context, String categoryId, Grade grade) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Eliminar nota'),
          content: Text(
              '¿Estás seguro que deseas eliminar la nota "${grade.name}"?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                _cubit.deleteGrade(
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

  IconButton _buildHelpButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.help_outline),
      color: Theme.of(context).colorScheme.primary,
      onPressed: () {
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
                    'El seguimiento de notas te permite:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                      '• Registrar notas por categorías (exámenes, trabajos, etc.)'),
                  Text('• Asignar pesos a cada categoría'),
                  Text('• Activar/desactivar notas específicas'),
                  Text('• Ver tu promedio estimado en tiempo real'),
                  SizedBox(height: 16),
                  Text(
                    'Cada categoría tiene un peso porcentual que indica cuánto influye en tu nota final. La suma de los pesos debería ser 100%.',
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
      },
    );
  }

  Color _getColorForGrade(double grade) {
    if (grade >= 14) {
      return Colors.green;
    } else if (grade >= 11) {
      return Colors.amber.shade800;
    } else {
      return Colors.red;
    }
  }
}
