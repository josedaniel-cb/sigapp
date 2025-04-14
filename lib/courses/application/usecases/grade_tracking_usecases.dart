import 'package:injectable/injectable.dart';
import 'package:sigapp/courses/domain/entities/grade_tracking.dart';
import 'package:sigapp/courses/domain/repositories/local_grade_tracking_repository.dart';

@lazySingleton
class GradeTrackingUseCases {
  final LocalGradeTrackingRepository _repository;

  GradeTrackingUseCases(this._repository);

  // Métodos de gestión de cursos
  Future<List<CourseTracking>> getAllCourses() {
    return _repository.getAllCourses();
  }

  Future<CourseTracking?> getCourseById(String courseId) {
    return _repository.getCourseById(courseId);
  }

  Future<CourseTracking?> getCourseTracking() {
    return _repository.get();
  }

  Future<CourseTracking> createEmptyCourseTracking(String courseName) {
    return _repository.createEmpty(courseName);
  }

  /// Crea un curso con categorías y notas predeterminadas
  Future<CourseTracking> createCourseTrackingWithDefaults(
      String courseId, String courseName) async {
    // Utiliza el método implementado en el repositorio que a su vez usa
    // la lógica en la entidad CourseTracking
    return _repository.createWithDefaults(courseId, courseName);
  }

  Future<void> deleteCourse(String courseId) {
    return _repository.deleteCourse(courseId);
  }

  Future<CourseTracking> updateCourseName(String courseId, String newName) {
    return _repository.updateCourseName(courseId, newName);
  }

  // Métodos para categorías
  Future<CourseTracking> addCategory(
    String courseId,
    String categoryName,
    double weight,
  ) {
    return _repository.addCategory(courseId, categoryName, weight);
  }

  Future<CourseTracking> updateCategory(
    String courseId,
    String categoryId,
    String newName,
    double newWeight,
  ) {
    return _repository.updateCategory(courseId, categoryId, newName, newWeight);
  }

  Future<CourseTracking> removeCategory(
    String courseId,
    String categoryId,
  ) {
    return _repository.deleteCategory(courseId, categoryId);
  }

  // Métodos para notas
  Future<CourseTracking> addGrade(
    String courseId,
    String categoryId,
    String gradeName,
    double score,
  ) {
    return _repository.addGrade(courseId, categoryId, gradeName, score);
  }

  Future<CourseTracking> updateGrade(
    String courseId,
    String categoryId,
    String gradeId,
    String newName,
    double newScore,
  ) {
    return _repository.updateGrade(
        courseId, categoryId, gradeId, newName, newScore);
  }

  Future<CourseTracking> removeGrade(
    String courseId,
    String categoryId,
    String gradeId,
  ) {
    return _repository.deleteGrade(courseId, categoryId, gradeId);
  }

  Future<CourseTracking> toggleGradeEnabled(
    String courseId,
    String categoryId,
    String gradeId,
    bool enabled,
  ) {
    return _repository.toggleGradeEnabled(
      courseId,
      categoryId,
      gradeId,
      enabled,
    );
  }

  // Método para limpiar datos al cerrar sesión
  Future<void> clearAllData() {
    return _repository.clearAllData();
  }
}
