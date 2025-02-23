// import 'package:injectable/injectable.dart';
// import 'package:sigapp/semester/application/get_semester_context_usecase.dart';
// import 'package:sigapp/student/application/usecases/get_academic_report_usecase.dart';
// import 'package:sigapp/courses/application/usecases/get_class_schedule_usecase.dart';
// import 'package:sigapp/student/domain/entities/student_semester_schedule.dart';

// // TODO: REMOVE
// @lazySingleton
// class GetDefaultClassScheduleUsecase {
//   final GetAcademicReportUsecase _getAcademicReportUsecase;
//   final GetSemesterContextUsecase _getDefaultSemesterUsecase;
//   final GetClassScheduleUsecase _getClassScheduleUsecase;

//   GetDefaultClassScheduleUsecase(
//     this._getAcademicReportUsecase,
//     this._getDefaultSemesterUsecase,
//     this._getClassScheduleUsecase,
//   );

//   Future<SemesterSchedule> execute() async {
//     final defaultSemester = await _getDefaultSemesterUsecase.execute();

//     return SemesterSchedule(
//       studentAcademicReport: await _getAcademicReportUsecase.execute(),
//       semester: defaultSemester.defaultSemester,
//       semesterList: defaultSemester.availableSemesters,
//       weeklyEvents: await _getClassScheduleUsecase
//           .execute(defaultSemester.defaultSemester.id),
//     );
//   }
// }
