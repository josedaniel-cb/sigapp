// import 'dart:developer' as developer;
// import 'package:injectable/injectable.dart';
// import 'package:sigapp/core/infrastructure/database/supabase_client_manager.dart';
// import 'package:sigapp/courses/domain/entities/grade_tracking.dart';
// import 'package:sigapp/courses/domain/repositories/grade_tracking_repository.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// @LazySingleton(as: GradeTrackingRepository)
// class RemoteGradeTrackingRepositoryImpl implements GradeTrackingRepository {
//   final SupabaseClientManager _supabaseClientManager;

//   RemoteGradeTrackingRepositoryImpl(this._supabaseClientManager);

//   // Helper to get the Supabase client
//   SupabaseClient get _client => _supabaseClientManager.client;

//   @override
//   Future<CourseTracking?> getCourseTracking(
//       {required String studentCode, required String courseCode}) async {
//     try {
//       final response = await _client
//           .from('gt_course_tracking')
//           .select('*, gt_grade_categories(*, gt_grades(*))')
//           .eq('student_code', studentCode)
//           .eq('course_code', courseCode)
//           .maybeSingle();
//       if (response == null) {
//         return null;
//       }

//       // Transform categories data
//       final List<Map<String, dynamic>> categoriesData =
//           (response['gt_grade_categories'] as List)
//               .cast<Map<String, dynamic>>();

//       final categories = categoriesData.map<GradeCategory>((categoryData) {
//         final List<Map<String, dynamic>> gradesData =
//             (categoryData['gt_grades'] as List).cast<Map<String, dynamic>>();

//         // Transform grades data
//         final grades = gradesData.map<Grade>((gradeData) {
//           return Grade(
//             id: gradeData['id'],
//             name: gradeData['name'],
//             score: gradeData['score'],
//             enabled: gradeData['enabled'],
//           );
//         }).toList();

//         return GradeCategory(
//           id: categoryData['id'],
//           name: categoryData['name'],
//           weight: categoryData['weight'],
//           grades: grades,
//         );
//       }).toList();

//       return CourseTracking(
//         id: response['id'],
//         courseCode: response['course_code'],
//         studentCode: response['student_code'],
//         categories: categories,
//       );
//     } catch (e, s) {
//       developer.log(
//         'Error en getCourseTracking',
//         name: 'RemoteGradeTrackingRepositoryImpl',
//         error: e,
//         stackTrace: s,
//       );
//       return null;
//     }
//   }

//   @override
//   Future<void> save(
//       {required String studentCode, required CourseTracking data}) async {
//     try {
//       // Start a transaction (Supabase doesn't have direct transaction support)
//       // but we can execute operations sequentially and handle errors

//       // 1. Insert/Update course tracking record
//       final Map<String, dynamic> courseData = {
//         'student_code': studentCode,
//         'course_code': data.courseCode,
//       };

//       // Include the ID if it exists
//       if (data.id != null) {
//         courseData['id'] = data.id;
//       }

//       final courseResponse = await _client
//           .from('gt_course_tracking')
//           .upsert(courseData)
//           .select()
//           .single();

//       final String courseTrackingId = courseResponse['id'];

//       // 2. Delete existing categories for this course (cascade will handle grades)
//       if (data.categories.isNotEmpty) {
//         await _client
//             .from('gt_grade_categories')
//             .delete()
//             .eq('course_tracking_id', courseTrackingId);
//       }

//       // 3. Insert categories
//       for (final category in data.categories) {
//         final categoryResponse = await _client
//             .from('gt_grade_categories')
//             .insert({
//               'course_tracking_id': courseTrackingId,
//               'name': category.name,
//               'weight': category.weight,
//             })
//             .select()
//             .single();

//         final String categoryId = categoryResponse['id'];

//         // 4. Insert grades for each category
//         for (final grade in category.grades) {
//           await _client.from('gt_grades').insert({
//             'category_id': categoryId,
//             'name': grade.name,
//             'score': grade.score,
//             'enabled': grade.enabled,
//           });
//         }
//       }
//     } catch (e, s) {
//       developer.log(
//         'Error en save',
//         name: 'RemoteGradeTrackingRepositoryImpl',
//         error: e,
//         stackTrace: s,
//       );
//       throw Exception('Failed to save course tracking data: $e');
//     }
//   }

//   @override
//   Future<CourseTracking> createWithDefaults({
//     required String studentCode,
//     required String courseCode,
//     required String courseName,
//   }) async {
//     try {
//       // Create course tracking entry in database
//       await _client
//           .from('gt_course_tracking')
//           .insert({
//             'student_code': studentCode,
//             'course_code': courseCode,
//           })
//           .select()
//           .single();

//       // Create the domain entity with default structure
//       final courseTracking = CourseTracking.createWithDefaults(
//         courseCode: courseCode,
//         studentCode: studentCode,
//       );

//       // Save all the default categories and grades
//       await save(studentCode: studentCode, data: courseTracking);

//       return courseTracking;
//     } catch (e, s) {
//       developer.log(
//         'Error en createWithDefaults',
//         name: 'RemoteGradeTrackingRepositoryImpl',
//         error: e,
//         stackTrace: s,
//       );
//       throw Exception('Failed to create course with defaults: $e');
//     }
//   }

//   @override
//   Future<CourseTracking> addCategory({
//     required String studentCode,
//     required String courseCode,
//     required String categoryName,
//     required double weight,
//   }) async {
//     final course = await getCourseTracking(
//         studentCode: studentCode, courseCode: courseCode);
//     if (course == null) {
//       throw Exception('Course not found');
//     }

//     try {
//       final categoryResponse = await _client
//           .from('gt_grade_categories')
//           .insert({
//             'course_tracking_id': course.id,
//             'name': categoryName,
//             'weight': weight,
//           })
//           .select()
//           .single();

//       final String categoryId = categoryResponse['id'];

//       final newCategory = GradeCategory(
//         id: categoryId,
//         name: categoryName,
//         weight: weight,
//         grades: [],
//       );

//       final updatedCategories = [...course.categories, newCategory];
//       final updatedTracking = CourseTracking(
//         id: course.id,
//         courseCode: course.courseCode,
//         studentCode: course.studentCode,
//         categories: updatedCategories,
//       );

//       return updatedTracking;
//     } catch (e, s) {
//       developer.log(
//         'Error en addCategory',
//         name: 'RemoteGradeTrackingRepositoryImpl',
//         error: e,
//         stackTrace: s,
//       );
//       throw Exception('Failed to add category: $e');
//     }
//   }

//   @override
//   Future<CourseTracking> addGrade({
//     required String studentCode,
//     required String courseCode,
//     required String categoryId,
//     required String gradeName,
//     required double score,
//   }) async {
//     final course = await getCourseTracking(
//         studentCode: studentCode, courseCode: courseCode);
//     if (course == null) {
//       throw Exception('Course not found');
//     }

//     try {
//       final gradeResponse = await _client
//           .from('gt_grades')
//           .insert({
//             'category_id': categoryId,
//             'name': gradeName,
//             'score': score,
//             'enabled': true,
//           })
//           .select()
//           .single();

//       final String gradeId = gradeResponse['id'];

//       final newGrade = Grade(
//         id: gradeId,
//         name: gradeName,
//         score: score,
//       );

//       final updatedCategories = course.categories.map((category) {
//         if (category.id == categoryId) {
//           return GradeCategory(
//             id: category.id,
//             name: category.name,
//             weight: category.weight,
//             grades: [...category.grades, newGrade],
//           );
//         }
//         return category;
//       }).toList();

//       final updatedTracking = CourseTracking(
//         id: course.id,
//         courseCode: course.courseCode,
//         studentCode: course.studentCode,
//         categories: updatedCategories,
//       );

//       return updatedTracking;
//     } catch (e, s) {
//       developer.log(
//         'Error en addGrade',
//         name: 'RemoteGradeTrackingRepositoryImpl',
//         error: e,
//         stackTrace: s,
//       );
//       throw Exception('Failed to add grade: $e');
//     }
//   }

//   @override
//   Future<CourseTracking> deleteCategory({
//     required String studentCode,
//     required String courseCode,
//     required String categoryId,
//   }) async {
//     final course = await getCourseTracking(
//         studentCode: studentCode, courseCode: courseCode);
//     if (course == null) {
//       throw Exception('Course not found');
//     }

//     try {
//       await _client
//           .from('gt_grade_categories')
//           .delete()
//           .eq('id', categoryId)
//           .eq('course_tracking_id', course.id!);

//       final updatedCategories = course.categories
//           .where((category) => category.id != categoryId)
//           .toList();

//       final updatedTracking = CourseTracking(
//         id: course.id,
//         courseCode: course.courseCode,
//         studentCode: course.studentCode,
//         categories: updatedCategories,
//       );

//       return updatedTracking;
//     } catch (e, s) {
//       developer.log(
//         'Error en deleteCategory',
//         name: 'RemoteGradeTrackingRepositoryImpl',
//         error: e,
//         stackTrace: s,
//       );
//       throw Exception('Failed to delete category: $e');
//     }
//   }

//   @override
//   Future<CourseTracking> deleteGrade({
//     required String studentCode,
//     required String courseCode,
//     required String categoryId,
//     required String gradeId,
//   }) async {
//     final course = await getCourseTracking(
//         studentCode: studentCode, courseCode: courseCode);
//     if (course == null) {
//       throw Exception('Course not found');
//     }

//     try {
//       await _client
//           .from('gt_grades')
//           .delete()
//           .eq('id', gradeId)
//           .eq('category_id', categoryId);

//       final updatedCategories = course.categories.map((category) {
//         if (category.id == categoryId) {
//           final updatedGrades =
//               category.grades.where((grade) => grade.id != gradeId).toList();

//           return GradeCategory(
//             id: category.id,
//             name: category.name,
//             weight: category.weight,
//             grades: updatedGrades,
//           );
//         }
//         return category;
//       }).toList();

//       final updatedTracking = CourseTracking(
//         id: course.id,
//         courseCode: course.courseCode,
//         studentCode: course.studentCode,
//         categories: updatedCategories,
//       );

//       return updatedTracking;
//     } catch (e, s) {
//       developer.log(
//         'Error en deleteGrade',
//         name: 'RemoteGradeTrackingRepositoryImpl',
//         error: e,
//         stackTrace: s,
//       );
//       throw Exception('Failed to delete grade: $e');
//     }
//   }

//   @override
//   Future<CourseTracking> updateCategory({
//     required String studentCode,
//     required String courseCode,
//     required String categoryId,
//     required String newName,
//     required double newWeight,
//   }) async {
//     final course = await getCourseTracking(
//         studentCode: studentCode, courseCode: courseCode);
//     if (course == null) {
//       throw Exception('Course not found');
//     }

//     try {
//       await _client
//           .from('gt_grade_categories')
//           .update({
//             'name': newName,
//             'weight': newWeight,
//           })
//           .eq('id', categoryId)
//           .eq('course_tracking_id', course.id!);

//       final updatedCategories = course.categories.map((category) {
//         if (category.id == categoryId) {
//           return GradeCategory(
//             id: category.id,
//             name: newName,
//             weight: newWeight,
//             grades: category.grades,
//           );
//         }
//         return category;
//       }).toList();

//       final updatedTracking = CourseTracking(
//         id: course.id,
//         courseCode: course.courseCode,
//         studentCode: course.studentCode,
//         categories: updatedCategories,
//       );

//       return updatedTracking;
//     } catch (e, s) {
//       developer.log(
//         'Error en updateCategory',
//         name: 'RemoteGradeTrackingRepositoryImpl',
//         error: e,
//         stackTrace: s,
//       );
//       throw Exception('Failed to update category: $e');
//     }
//   }

//   @override
//   Future<CourseTracking> updateGrade({
//     required String studentCode,
//     required String courseCode,
//     required String categoryId,
//     required String gradeId,
//     required String newName,
//     required double newScore,
//   }) async {
//     final course = await getCourseTracking(
//         studentCode: studentCode, courseCode: courseCode);
//     if (course == null) {
//       throw Exception('Course not found');
//     }

//     try {
//       await _client
//           .from('gt_grades')
//           .update({
//             'name': newName,
//             'score': newScore,
//           })
//           .eq('id', gradeId)
//           .eq('category_id', categoryId);

//       final updatedCategories = course.categories.map((category) {
//         if (category.id == categoryId) {
//           final updatedGrades = category.grades.map((grade) {
//             if (grade.id == gradeId) {
//               return Grade(
//                 id: grade.id,
//                 name: newName,
//                 score: newScore,
//                 enabled: grade.enabled,
//               );
//             }
//             return grade;
//           }).toList();

//           return GradeCategory(
//             id: category.id,
//             name: category.name,
//             weight: category.weight,
//             grades: updatedGrades,
//           );
//         }
//         return category;
//       }).toList();

//       final updatedTracking = CourseTracking(
//         id: course.id,
//         courseCode: course.courseCode,
//         studentCode: course.studentCode,
//         categories: updatedCategories,
//       );

//       return updatedTracking;
//     } catch (e, s) {
//       developer.log(
//         'Error en updateGrade',
//         name: 'RemoteGradeTrackingRepositoryImpl',
//         error: e,
//         stackTrace: s,
//       );
//       throw Exception('Failed to update grade: $e');
//     }
//   }

//   @override
//   Future<CourseTracking> toggleGradeEnabled({
//     required String studentCode,
//     required String courseCode,
//     required String categoryId,
//     required String gradeId,
//     required bool enabled,
//   }) async {
//     final course = await getCourseTracking(
//         studentCode: studentCode, courseCode: courseCode);
//     if (course == null) {
//       throw Exception('Course not found');
//     }

//     try {
//       await _client
//           .from('gt_grades')
//           .update({'enabled': enabled})
//           .eq('id', gradeId)
//           .eq('category_id', categoryId);

//       final updatedCategories = course.categories.map((category) {
//         if (category.id == categoryId) {
//           final updatedGrades = category.grades.map((grade) {
//             if (grade.id == gradeId) {
//               return grade.copyWith(enabled: enabled);
//             }
//             return grade;
//           }).toList();

//           return category.copyWith(grades: updatedGrades);
//         }
//         return category;
//       }).toList();

//       final updatedTracking = CourseTracking(
//         id: course.id,
//         courseCode: course.courseCode,
//         studentCode: course.studentCode,
//         categories: updatedCategories,
//       );

//       return updatedTracking;
//     } catch (e, s) {
//       developer.log(
//         'Error en toggleGradeEnabled',
//         name: 'RemoteGradeTrackingRepositoryImpl',
//         error: e,
//         stackTrace: s,
//       );
//       throw Exception('Failed to toggle grade enabled state: $e');
//     }
//   }
// }
