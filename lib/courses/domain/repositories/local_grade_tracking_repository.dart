import 'package:sigapp/courses/domain/entities/grade_tracking.dart';

abstract class LocalGradeTrackingRepository {
  Future<List<CourseTracking>> getAllCourses();
  Future<CourseTracking?> getCourseById(String courseId);
  Future<CourseTracking?> get();
  Future<void> save(CourseTracking data);
  Future<CourseTracking> createEmpty(String courseName);
  Future<CourseTracking> createWithDefaults(String courseId, String courseName);
  Future<void> deleteCourse(String courseId);
  Future<CourseTracking> addCategory(
      String courseId, String categoryName, double weight);
  Future<CourseTracking> addGrade(
      String courseId, String categoryId, String gradeName, double score);
  Future<CourseTracking> deleteCategory(
    String courseId,
    String categoryId,
  );
  Future<CourseTracking> deleteGrade(
    String courseId,
    String categoryId,
    String gradeId,
  );
  Future<void> clearAllData();
  Future<CourseTracking> updateCourseName(String courseId, String newName);
  Future<CourseTracking> updateCategory(
    String courseId,
    String categoryId,
    String newName,
    double newWeight,
  );
  Future<CourseTracking> updateGrade(
    String courseId,
    String categoryId,
    String gradeId,
    String newName,
    double newScore,
  );
  Future<CourseTracking> toggleGradeEnabled(
    String courseId,
    String categoryId,
    String gradeId,
    bool enabled,
  );
}
