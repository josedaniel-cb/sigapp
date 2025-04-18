import 'package:sigapp/courses/domain/entities/grade_tracking.dart';

abstract class GradeTrackingRepository {
  Future<List<CourseTracking>> getAllCourses({required String studentCode});
  Future<CourseTracking?> getCourseById(
      {required String studentCode, required String courseId});
  Future<CourseTracking?> get({required String studentCode});
  Future<void> save(
      {required String studentCode, required CourseTracking data});
  Future<CourseTracking> createEmpty(
      {required String studentCode, required String courseName});
  Future<CourseTracking> createWithDefaults(
      {required String studentCode,
      required String courseId,
      required String courseName});
  Future<void> deleteCourse(
      {required String studentCode, required String courseId});
  Future<CourseTracking> addCategory({
    required String studentCode,
    required String courseId,
    required String categoryName,
    required double weight,
  });
  Future<CourseTracking> addGrade({
    required String studentCode,
    required String courseId,
    required String categoryId,
    required String gradeName,
    required double score,
  });
  Future<CourseTracking> deleteCategory({
    required String studentCode,
    required String courseId,
    required String categoryId,
  });
  Future<CourseTracking> deleteGrade({
    required String studentCode,
    required String courseId,
    required String categoryId,
    required String gradeId,
  });
  Future<void> clearAllData({required String studentCode});
  Future<CourseTracking> updateCourseName(
      {required String studentCode,
      required String courseId,
      required String newName});
  Future<CourseTracking> updateCategory({
    required String studentCode,
    required String courseId,
    required String categoryId,
    required String newName,
    required double newWeight,
  });
  Future<CourseTracking> updateGrade({
    required String studentCode,
    required String courseId,
    required String categoryId,
    required String gradeId,
    required String newName,
    required double newScore,
  });
  Future<CourseTracking> toggleGradeEnabled({
    required String studentCode,
    required String courseId,
    required String categoryId,
    required String gradeId,
    required bool enabled,
  });
}
