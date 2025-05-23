// import 'package:injectable/injectable.dart';
// import 'package:sigapp/core/infrastructure/database/sqlite_client_manager.dart';
// import 'package:sigapp/courses/domain/entities/grade_tracking.dart';
// import 'package:sigapp/courses/domain/repositories/grade_tracking_repository.dart';
// import 'package:uuid/uuid.dart';

// // @LazySingleton(as: GradeTrackingRepository)
// class LocalGradeTrackingRepositoryImpl implements GradeTrackingRepository {
//   final SQLiteClientManager _databaseService;
//   final _uuid = const Uuid();

//   LocalGradeTrackingRepositoryImpl(this._databaseService);

//   @override
//   Future<List<CourseTracking>> getAllCourses(
//       {required String studentCode}) async {
//     final db = await _databaseService.database;

//     final List<Map<String, dynamic>> courseTrackingMaps = await db.query(
//       'course_tracking',
//       orderBy: 'course_name ASC',
//     );

//     if (courseTrackingMaps.isEmpty) {
//       return [];
//     }

//     List<CourseTracking> courses = [];

//     for (final courseTracking in courseTrackingMaps) {
//       final String courseTrackingId = courseTracking['id'];
//       final String courseName = courseTracking['course_name'];

//       final categories = await _getCategoriesForCourse(courseTrackingId);

//       courses.add(CourseTracking(
//         courseCode: courseTrackingId,
//         studentCode: courseName,
//         categories: categories,
//       ));
//     }

//     return courses;
//   }

//   @override
//   Future<CourseTracking?> getCourseByCourseCode(
//       {required String studentCode, required String courseCode}) async {
//     final db = await _databaseService.database;

//     final List<Map<String, dynamic>> courseTrackingMaps = await db.query(
//       'course_tracking',
//       where: 'id = ?',
//       whereArgs: [courseCode],
//       limit: 1,
//     );

//     if (courseTrackingMaps.isEmpty) {
//       return null;
//     }

//     final courseTracking = courseTrackingMaps.first;
//     final String courseTrackingId = courseTracking['id'];
//     final String courseName = courseTracking['course_name'];

//     final categories = await _getCategoriesForCourse(courseTrackingId);

//     return CourseTracking(
//       courseCode: courseTrackingId,
//       studentCode: courseName,
//       categories: categories,
//     );
//   }

//   // Convenience method to maintain compatibility with previous code
//   @override
//   Future<CourseTracking?> get({required String studentCode}) async {
//     // Get the most recent course (assuming there could be several)
//     final courses = await getAllCourses(studentCode: studentCode);
//     if (courses.isEmpty) {
//       return null;
//     }
//     return courses.first;
//   }

//   Future<List<GradeCategory>> _getCategoriesForCourse(String courseId) async {
//     final db = await _databaseService.database;

//     final List<Map<String, dynamic>> categoryMaps = await db.query(
//       'grade_categories',
//       where: 'course_tracking_id = ?',
//       whereArgs: [courseId],
//       orderBy: 'name ASC',
//     );

//     final List<GradeCategory> categories = [];

//     for (final categoryMap in categoryMaps) {
//       final String categoryId = categoryMap['id'];
//       final grades = await _getGradesForCategory(categoryId);

//       categories.add(
//         GradeCategory(
//           id: categoryId,
//           name: categoryMap['name'],
//           weight: categoryMap['weight'],
//           grades: grades,
//         ),
//       );
//     }

//     return categories;
//   }

//   Future<List<Grade>> _getGradesForCategory(String categoryId) async {
//     final db = await _databaseService.database;

//     final List<Map<String, dynamic>> gradeMaps = await db.query(
//       'grades',
//       where: 'category_id = ?',
//       whereArgs: [categoryId],
//       orderBy: 'name ASC',
//     );

//     return gradeMaps.map((gradeMap) {
//       return Grade(
//         id: gradeMap['id'],
//         name: gradeMap['name'],
//         score: gradeMap['score'],
//         enabled: gradeMap['enabled'] == 1, // Convertir INTEGER a bool
//       );
//     }).toList();
//   }

//   @override
//   Future<void> save(
//       {required String studentCode, required CourseTracking data}) async {
//     final db = await _databaseService.database;

//     // Using a transaction to ensure data integrity
//     await db.transaction((txn) async {
//       // Check if the course already exists
//       final List<Map<String, dynamic>> existingCourse = await txn.query(
//         'course_tracking',
//         where: 'id = ?',
//         whereArgs: [data.courseCode],
//       );

//       if (existingCourse.isEmpty) {
//         // Course doesn't exist, insert it
//         await txn.insert(
//           'course_tracking',
//           {
//             'id': data.courseCode,
//             'course_name': data.studentCode,
//           },
//         );
//       } else {
//         // Course exists, update it
//         await txn.update(
//           'course_tracking',
//           {'course_name': data.studentCode},
//           where: 'id = ?',
//           whereArgs: [data.courseCode],
//         );
//       }

//       // First, let's check existing categories and grades to avoid ID conflicts
//       // Get all existing category IDs for this course
//       final List<Map<String, dynamic>> existingCategories = await txn.query(
//         'grade_categories',
//         columns: ['id'],
//         where: 'course_tracking_id = ?',
//         whereArgs: [data.courseCode],
//       );
//       final existingCategoryIds =
//           existingCategories.map((c) => c['id'] as String).toSet();

//       // For each existing category, get its grades
//       final Map<String, Set<String>> existingGradeIds = {};
//       for (final categoryId in existingCategoryIds) {
//         final List<Map<String, dynamic>> existingGrades = await txn.query(
//           'grades',
//           columns: ['id'],
//           where: 'category_id = ?',
//           whereArgs: [categoryId],
//         );
//         existingGradeIds[categoryId] =
//             existingGrades.map((g) => g['id'] as String).toSet();
//       }

//       // Now delete existing categories (cascade will handle grades)
//       await txn.delete(
//         'grade_categories',
//         where: 'course_tracking_id = ?',
//         whereArgs: [data.courseCode],
//       );

//       // Insert categories
//       for (final category in data.categories) {
//         await txn.insert(
//           'grade_categories',
//           {
//             'id': category.id,
//             'course_tracking_id': data.courseCode,
//             'name': category.name,
//             'weight': category.weight,
//           },
//         );

//         // Insert grades for each category, generating new IDs if they'd conflict
//         for (final grade in category.grades) {
//           // Check if this grade ID would conflict
//           final categoryExisted = existingCategoryIds.contains(category.id);
//           final gradeConflict = categoryExisted &&
//               existingGradeIds[category.id]?.contains(grade.id) == true;

//           // If there would be a conflict, generate a new ID
//           final gradeId = gradeConflict ? _uuid.v4() : grade.id;

//           await txn.insert(
//             'grades',
//             {
//               'id': gradeId,
//               'category_id': category.id,
//               'name': grade.name,
//               'score': grade.score,
//               'enabled': grade.enabled ? 1 : 0,
//             },
//           );
//         }
//       }
//     });
//   }

//   // Creates a new empty course tracking
//   @override
//   Future<CourseTracking> createEmpty(
//       {required String studentCode, required String courseName}) async {
//     final courseId = _uuid.v4();

//     final courseTracking = CourseTracking(
//       courseCode: courseId,
//       studentCode: courseName,
//       categories: [],
//     );

//     await save(studentCode: studentCode, data: courseTracking);
//     return courseTracking;
//   }

//   // Creates a new course tracking with default categories and grades
//   @override
//   Future<CourseTracking> createWithDefaults(
//       {required String studentCode,
//       required String courseCode,
//       required String courseName}) async {
//     // Usar el courseId directamente como identificador del curso
//     // Esto garantiza que siempre usemos el mismo ID para el mismo curso

//     // Usar el método estático de la entidad para crear con valores predeterminados
//     final courseTracking = CourseTracking.createWithDefaults(
//       id: courseCode,
//       courseName: courseName,
//       generateId: () => _uuid
//           .v4(), // Pasar la función de generación de IDs para las categorías y notas
//     );

//     await save(studentCode: studentCode, data: courseTracking);
//     return courseTracking;
//   }

//   // Deletes a course and all its associated data
//   @override
//   Future<void> deleteCourse(
//       {required String studentCode, required String courseCode}) async {
//     final db = await _databaseService.database;

//     await db.delete(
//       'course_tracking',
//       where: 'id = ?',
//       whereArgs: [courseCode],
//     );
//   }

//   // Adds a new category to the grade tracking
//   @override
//   Future<CourseTracking> addCategory({
//     required String studentCode,
//     required String courseCode,
//     required String categoryName,
//     required double weight,
//   }) async {
//     final course = await getCourseByCourseCode(
//         studentCode: studentCode, courseCode: courseCode);
//     if (course == null) {
//       throw Exception('Course not found');
//     }

//     final categoryId = _uuid.v4();

//     final newCategory = GradeCategory(
//       id: categoryId,
//       name: categoryName,
//       weight: weight,
//       grades: [],
//     );

//     final updatedCategories = [...course.categories, newCategory];
//     final updatedTracking = CourseTracking(
//       courseCode: course.courseCode,
//       studentCode: course.studentCode,
//       categories: updatedCategories,
//     );

//     await save(studentCode: studentCode, data: updatedTracking);
//     return updatedTracking;
//   }

//   // Adds a new grade to a category
//   @override
//   Future<CourseTracking> addGrade({
//     required String studentCode,
//     required String courseCode,
//     required String categoryId,
//     required String gradeName,
//     required double score,
//   }) async {
//     final course = await getCourseByCourseCode(
//         studentCode: studentCode, courseCode: courseCode);
//     if (course == null) {
//       throw Exception('Course not found');
//     }

//     final gradeId = _uuid.v4();
//     final newGrade = Grade(
//       id: gradeId,
//       name: gradeName,
//       score: score,
//     );

//     final updatedCategories = course.categories.map((category) {
//       if (category.id == categoryId) {
//         return GradeCategory(
//           id: category.id,
//           name: category.name,
//           weight: category.weight,
//           grades: [...category.grades, newGrade],
//         );
//       }
//       return category;
//     }).toList();

//     final updatedTracking = CourseTracking(
//       courseCode: course.courseCode,
//       studentCode: course.studentCode,
//       categories: updatedCategories,
//     );

//     await save(studentCode: studentCode, data: updatedTracking);
//     return updatedTracking;
//   }

//   // Deletes a category and all its grades
//   @override
//   Future<CourseTracking> deleteCategory({
//     required String studentCode,
//     required String courseCode,
//     required String categoryId,
//   }) async {
//     final course = await getCourseByCourseCode(
//         studentCode: studentCode, courseCode: courseCode);
//     if (course == null) {
//       throw Exception('Course not found');
//     }

//     final db = await _databaseService.database;

//     await db.transaction((txn) async {
//       // First delete the grades for this category
//       await txn.delete(
//         'grades',
//         where: 'category_id = ?',
//         whereArgs: [categoryId],
//       );

//       // Then delete the category
//       await txn.delete(
//         'grade_categories',
//         where: 'id = ?',
//         whereArgs: [categoryId],
//       );
//     });

//     final updatedCategories = course.categories
//         .where((category) => category.id != categoryId)
//         .toList();

//     final updatedTracking = CourseTracking(
//       courseCode: course.courseCode,
//       studentCode: course.studentCode,
//       categories: updatedCategories,
//     );

//     return updatedTracking;
//   }

//   // Deletes a specific grade
//   @override
//   Future<CourseTracking> deleteGrade({
//     required String studentCode,
//     required String courseCode,
//     required String categoryId,
//     required String gradeId,
//   }) async {
//     final course = await getCourseByCourseCode(
//         studentCode: studentCode, courseCode: courseCode);
//     if (course == null) {
//       throw Exception('Course not found');
//     }

//     final db = await _databaseService.database;

//     await db.delete(
//       'grades',
//       where: 'id = ?',
//       whereArgs: [gradeId],
//     );

//     final updatedCategories = course.categories.map((category) {
//       if (category.id == categoryId) {
//         final updatedGrades =
//             category.grades.where((grade) => grade.id != gradeId).toList();

//         return GradeCategory(
//           id: category.id,
//           name: category.name,
//           weight: category.weight,
//           grades: updatedGrades,
//         );
//       }
//       return category;
//     }).toList();

//     final updatedTracking = CourseTracking(
//       courseCode: course.courseCode,
//       studentCode: course.studentCode,
//       categories: updatedCategories,
//     );

//     return updatedTracking;
//   }

//   // Clears all data when user logs out
//   @override
//   Future<void> clearAllData({required String studentCode}) async {
//     final db = await _databaseService.database;

//     await db.transaction((txn) async {
//       // Delete all grades
//       await txn.delete('grades');

//       // Delete all categories
//       await txn.delete('grade_categories');

//       // Delete all courses
//       await txn.delete('course_tracking');
//     });
//   }

//   // Updates a course name
//   @override
//   Future<CourseTracking> updateCourseName(
//       {required String studentCode,
//       required String courseCode,
//       required String newName}) async {
//     final course = await getCourseByCourseCode(
//         studentCode: studentCode, courseCode: courseCode);
//     if (course == null) {
//       throw Exception('Course not found');
//     }

//     final db = await _databaseService.database;

//     await db.update(
//       'course_tracking',
//       {'course_name': newName},
//       where: 'id = ?',
//       whereArgs: [courseCode],
//     );

//     final updatedCourse = CourseTracking(
//       courseCode: courseCode,
//       studentCode: newName,
//       categories: course.categories,
//     );

//     return updatedCourse;
//   }

//   // Updates a category name and weight
//   @override
//   Future<CourseTracking> updateCategory({
//     required String studentCode,
//     required String courseCode,
//     required String categoryId,
//     required String newName,
//     required double newWeight,
//   }) async {
//     final course = await getCourseByCourseCode(
//         studentCode: studentCode, courseCode: courseCode);
//     if (course == null) {
//       throw Exception('Course not found');
//     }

//     final db = await _databaseService.database;

//     await db.update(
//       'grade_categories',
//       {
//         'name': newName,
//         'weight': newWeight,
//       },
//       where: 'id = ?',
//       whereArgs: [categoryId],
//     );

//     final updatedCategories = course.categories.map((category) {
//       if (category.id == categoryId) {
//         return GradeCategory(
//           id: category.id,
//           name: newName,
//           weight: newWeight,
//           grades: category.grades,
//         );
//       }
//       return category;
//     }).toList();

//     final updatedTracking = CourseTracking(
//       courseCode: course.courseCode,
//       studentCode: course.studentCode,
//       categories: updatedCategories,
//     );

//     return updatedTracking;
//   }

//   // Updates a specific grade
//   @override
//   Future<CourseTracking> updateGrade({
//     required String studentCode,
//     required String courseCode,
//     required String categoryId,
//     required String gradeId,
//     required String newName,
//     required double newScore,
//   }) async {
//     final course = await getCourseByCourseCode(
//         studentCode: studentCode, courseCode: courseCode);
//     if (course == null) {
//       throw Exception('Course not found');
//     }

//     final db = await _databaseService.database;

//     await db.update(
//       'grades',
//       {
//         'name': newName,
//         'score': newScore,
//       },
//       where: 'id = ?',
//       whereArgs: [gradeId],
//     );

//     final updatedCategories = course.categories.map((category) {
//       if (category.id == categoryId) {
//         final updatedGrades = category.grades.map((grade) {
//           if (grade.id == gradeId) {
//             return Grade(
//               id: grade.id,
//               name: newName,
//               score: newScore,
//               enabled: grade.enabled,
//             );
//           }
//           return grade;
//         }).toList();

//         return GradeCategory(
//           id: category.id,
//           name: category.name,
//           weight: category.weight,
//           grades: updatedGrades,
//         );
//       }
//       return category;
//     }).toList();

//     final updatedTracking = CourseTracking(
//       courseCode: course.courseCode,
//       studentCode: course.studentCode,
//       categories: updatedCategories,
//     );

//     return updatedTracking;
//   }

//   // Cambia el estado de habilitación de una nota específica
//   @override
//   Future<CourseTracking> toggleGradeEnabled({
//     required String studentCode,
//     required String courseCode,
//     required String categoryId,
//     required String gradeId,
//     required bool enabled,
//   }) async {
//     final course = await getCourseByCourseCode(
//         studentCode: studentCode, courseCode: courseCode);
//     if (course == null) {
//       throw Exception('Course not found');
//     }

//     final db = await _databaseService.database;

//     await db.update(
//       'grades',
//       {
//         'enabled': enabled ? 1 : 0,
//       },
//       where: 'id = ?',
//       whereArgs: [gradeId],
//     );

//     final updatedCategories = course.categories.map((category) {
//       if (category.id == categoryId) {
//         final updatedGrades = category.grades.map((grade) {
//           if (grade.id == gradeId) {
//             return grade.copyWith(enabled: enabled);
//           }
//           return grade;
//         }).toList();

//         return category.copyWith(grades: updatedGrades);
//       }
//       return category;
//     }).toList();

//     final updatedTracking = CourseTracking(
//       courseCode: course.courseCode,
//       studentCode: course.studentCode,
//       categories: updatedCategories,
//     );

//     return updatedTracking;
//   }
// }
