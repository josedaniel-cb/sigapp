class Grade {
  final String id;
  final String name;
  final double score;
  final bool enabled; // Nuevo campo para habilitar/deshabilitar la nota

  Grade({
    required this.id,
    required this.name,
    required this.score,
    this.enabled = true, // Por defecto, las notas están habilitadas
  });

  // Método para crear una copia de la nota con cambios específicos
  Grade copyWith({
    String? id,
    String? name,
    double? score,
    bool? enabled,
  }) {
    return Grade(
      id: id ?? this.id,
      name: name ?? this.name,
      score: score ?? this.score,
      enabled: enabled ?? this.enabled,
    );
  }
}

class GradeCategory {
  final String id;
  final String name;

  /// from 1 to 100
  final double weight;
  final List<Grade> grades;

  GradeCategory({
    required this.id,
    required this.name,
    required this.weight,
    required this.grades,
  });

  double get averagePercentage {
    // Filtrar solo las notas habilitadas
    final enabledGrades = grades.where((g) => g.enabled).toList();
    if (enabledGrades.isEmpty) return 0.0;
    final total = enabledGrades.map((g) => g.score).reduce((a, b) => a + b);
    return total / enabledGrades.length;
  }

  double get weightedContribution {
    return (averagePercentage * (weight / 100));
  }

  // Método para crear una copia de la categoría con cambios específicos
  GradeCategory copyWith({
    String? id,
    String? name,
    double? weight,
    List<Grade>? grades,
  }) {
    return GradeCategory(
      id: id ?? this.id,
      name: name ?? this.name,
      weight: weight ?? this.weight,
      grades: grades ?? this.grades,
    );
  }
}

class CourseTracking {
  final String id;
  final String courseName;
  final List<GradeCategory> categories;

  CourseTracking({
    required this.id,
    required this.courseName,
    required this.categories,
  });

  double get finalGrade {
    if (categories.isEmpty) return 0.0;
    final totalContribution =
        categories.map((c) => c.weightedContribution).reduce((a, b) => a + b);
    return totalContribution;
  }

  /// Crea un curso con categorías y notas predeterminadas
  /// Esta estructura incluye:
  /// - Evaluaciones (con 4 evaluaciones)
  /// - Examen Parcial (con 1 nota)
  /// - Examen Final (con 1 nota)
  /// - Trabajo Final (con 1 nota)
  static CourseTracking createWithDefaults({
    required String id,
    required String courseName,
    required String Function() generateId,
  }) {
    // Definir pesos predeterminados para las categorías
    const evaluacionesWeight = 40.0;
    const examenParcialWeight = 20.0;
    const examenFinalWeight = 20.0;
    const trabajoFinalWeight = 20.0;

    // Crear categorías con sus notas
    List<GradeCategory> defaultCategories = [];

    // 1. Añadir categoría "Evaluaciones"
    final evaluacionesId = generateId();
    List<Grade> evaluacionesGrades = [];

    // Añadir 4 evaluaciones con nota cero por defecto
    for (int i = 1; i <= 4; i++) {
      evaluacionesGrades
          .add(Grade(id: generateId(), name: "Evaluación $i", score: 0.0));
    }

    defaultCategories.add(GradeCategory(
        id: evaluacionesId,
        name: "Evaluaciones",
        weight: evaluacionesWeight,
        grades: evaluacionesGrades));

    // 2. Añadir categoría "Examen Parcial"
    defaultCategories.add(GradeCategory(
        id: generateId(),
        name: "Examen Parcial",
        weight: examenParcialWeight,
        grades: [Grade(id: generateId(), name: "Nota", score: 0.0)]));

    // 3. Añadir categoría "Examen Final"
    defaultCategories.add(GradeCategory(
        id: generateId(),
        name: "Examen Final",
        weight: examenFinalWeight,
        grades: [Grade(id: generateId(), name: "Nota", score: 0.0)]));

    // 4. Añadir categoría "Trabajo Final"
    defaultCategories.add(GradeCategory(
        id: generateId(),
        name: "Trabajo Final",
        weight: trabajoFinalWeight,
        grades: [Grade(id: generateId(), name: "Nota", score: 0.0)]));

    return CourseTracking(
        id: id, courseName: courseName, categories: defaultCategories);
  }
}
