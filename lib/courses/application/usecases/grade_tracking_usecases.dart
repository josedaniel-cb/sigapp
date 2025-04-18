import 'package:injectable/injectable.dart';
import 'package:sigapp/courses/application/services/student_session_service.dart';
import 'package:sigapp/courses/domain/entities/grade_tracking.dart';
import 'package:sigapp/courses/domain/repositories/grade_tracking_repository.dart';

@lazySingleton
class GradeTrackingUseCases {
  final GradeTrackingRepository _repository;
  final StudentSessionService _studentSessionService;

  GradeTrackingUseCases(this._repository, this._studentSessionService);

  // Métodos de gestión de cursos
  Future<List<CourseTracking>> getAllCourses() async {
    return _repository.getAllCourses(studentCode: await _getStudentCode());
  }

  Future<CourseTracking?> getCourseById({required String courseId}) async {
    return _repository.getCourseById(
        studentCode: await _getStudentCode(), courseId: courseId);
  }

  Future<CourseTracking?> getCourseTracking() async {
    return _repository.get(studentCode: await _getStudentCode());
  }

  Future<CourseTracking> createEmptyCourseTracking(
      {required String courseName}) async {
    return _repository.createEmpty(
        studentCode: await _getStudentCode(), courseName: courseName);
  }

  /// Crea un curso con categorías y notas predeterminadas
  Future<CourseTracking> createCourseTrackingWithDefaults(
      {required String courseId, required String courseName}) async {
    // Utiliza el método implementado en el repositorio que a su vez usa
    // la lógica en la entidad CourseTracking
    return _repository.createWithDefaults(
      studentCode: await _getStudentCode(),
      courseId: courseId,
      courseName: courseName,
    );
  }

  Future<void> deleteCourse({required String courseId}) async {
    return _repository.deleteCourse(
        studentCode: await _getStudentCode(), courseId: courseId);
  }

  Future<CourseTracking> updateCourseName(
      {required String courseId, required String newName}) async {
    return _repository.updateCourseName(
      studentCode: await _getStudentCode(),
      courseId: courseId,
      newName: newName,
    );
  }

  // Métodos para categorías
  Future<CourseTracking> addCategory(
      {required String courseId,
      required String categoryName,
      required double weight}) async {
    return _repository.addCategory(
      studentCode: await _getStudentCode(),
      courseId: courseId,
      categoryName: categoryName,
      weight: weight,
    );
  }

  Future<CourseTracking> updateCategory(
      {required String courseId,
      required String categoryId,
      required String newName,
      required double newWeight}) async {
    return _repository.updateCategory(
      studentCode: await _getStudentCode(),
      courseId: courseId,
      categoryId: categoryId,
      newName: newName,
      newWeight: newWeight,
    );
  }

  Future<CourseTracking> removeCategory(
      {required String courseId, required String categoryId}) async {
    return _repository.deleteCategory(
      studentCode: await _getStudentCode(),
      courseId: courseId,
      categoryId: categoryId,
    );
  }

  // Métodos para notas
  Future<CourseTracking> addGrade(
      {required String courseId,
      required String categoryId,
      required String gradeName,
      required double score}) async {
    return _repository.addGrade(
      studentCode: await _getStudentCode(),
      courseId: courseId,
      categoryId: categoryId,
      gradeName: gradeName,
      score: score,
    );
  }

  Future<CourseTracking> updateGrade(
      {required String courseId,
      required String categoryId,
      required String gradeId,
      required String newName,
      required double newScore}) async {
    return _repository.updateGrade(
      studentCode: await _getStudentCode(),
      courseId: courseId,
      categoryId: categoryId,
      gradeId: gradeId,
      newName: newName,
      newScore: newScore,
    );
  }

  Future<CourseTracking> removeGrade(
      {required String courseId,
      required String categoryId,
      required String gradeId}) async {
    return _repository.deleteGrade(
      studentCode: await _getStudentCode(),
      courseId: courseId,
      categoryId: categoryId,
      gradeId: gradeId,
    );
  }

  Future<CourseTracking> toggleGradeEnabled(
      {required String courseId,
      required String categoryId,
      required String gradeId,
      required bool enabled}) async {
    return _repository.toggleGradeEnabled(
      studentCode: await _getStudentCode(),
      courseId: courseId,
      categoryId: categoryId,
      gradeId: gradeId,
      enabled: enabled,
    );
  }

  // Método para limpiar datos al cerrar sesión
  Future<void> clearAllData() async {
    return _repository.clearAllData(studentCode: await _getStudentCode());
  }

  // Helper method to get student code
  Future<String> _getStudentCode() async {
    final info = await _studentSessionService.getInfo();
    return info.studentCode;
  }
}
