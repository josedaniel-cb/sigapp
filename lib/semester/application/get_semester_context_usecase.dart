import 'package:injectable/injectable.dart';
import 'package:sigapp/courses/domain/repositories/courses_repository.dart';
import 'package:sigapp/semester/domain/value-objects/semester_context.dart';
import 'package:sigapp/student/application/usecases/get_academic_report_usecase.dart';
import 'package:sigapp/student/domain/entities/student_semester_schedule.dart';

@lazySingleton
class GetSemesterContextUsecase {
  final GetAcademicReportUsecase _getAcademicReportUsecase;
  final CoursesRepository _coursesRepository;

  GetSemesterContextUsecase(
      this._getAcademicReportUsecase, this._coursesRepository);

  SemesterContext? _value;

  Future<SemesterContext> execute() async {
    if (_value != null) {
      return _value!;
    }

    // Fetch
    final academicReport = await _getAcademicReportUsecase.execute();
    final firstSemester = SemesterScheduleSemesterMetadata.buildFromId(
        academicReport.enrollmentSemesterId);
    var lastSemester = academicReport.lastSemesterId != null
        ? SemesterScheduleSemesterMetadata.buildFromId(
            academicReport.lastSemesterId!)
        : null;

    // if (lastSemester == null) {
    //   // Try to deduce the last semester id from the student's schedule
    //   final currentSemester = SemesterScheduleSemesterMetadata.buildFromId(
    //       academicReport.currentSemesterId);
    //   if (await _calculateIsCurrentSemesterTheLastOne(currentSemester)) {
    //     lastSemester = currentSemester;
    //   }
    // }

    // Calculate default semester and available semesters
    final isLastSemesterIdKnown = lastSemester != null;
    SemesterScheduleSemesterMetadata defaultSemester;
    var rangeLastSemesterId = '';
    if (isLastSemesterIdKnown) {
      defaultSemester = lastSemester;
      rangeLastSemesterId = lastSemester.id;
    } else {
      defaultSemester = firstSemester;
      rangeLastSemesterId = academicReport.currentSemesterId;
    }

    _value = SemesterContext(
      isLast: isLastSemesterIdKnown,
      defaultSemester: defaultSemester,
      availableSemesters:
          _buildSemesterRange(firstSemester.id, rangeLastSemesterId),
    );

    return execute();
  }

  List<SemesterScheduleSemesterMetadata> _buildSemesterRange(
      String firstSemesterId, String lastSemesterId) {
    List<SemesterScheduleSemesterMetadata> semesters = [];
    final firstSemester =
        SemesterScheduleSemesterMetadata.buildFromId(firstSemesterId);
    final lastSemester =
        SemesterScheduleSemesterMetadata.buildFromId(lastSemesterId);
    for (var year = firstSemester.year; year <= lastSemester.year; year++) {
      var startPeriod = (year == firstSemester.year) ? firstSemester.period : 0;
      var endPeriod = (year == lastSemester.year) ? lastSemester.period : 2;
      for (var yearPeriod = startPeriod;
          yearPeriod <= endPeriod;
          yearPeriod++) {
        semesters.add(
            SemesterScheduleSemesterMetadata.buildFromId('$year$yearPeriod'));
      }
    }
    return semesters;
  }

  // Future<bool> _calculateIsCurrentSemesterTheLastOne(
  //     SemesterScheduleSemesterMetadata currentSemester) async {
  //   final result = await Future.wait([
  //     _coursesRepository.getEnrolledCourses(currentSemester.id),
  //     _coursesRepository.getEnrolledCourses('${currentSemester.year}1'),
  //     _coursesRepository.getEnrolledCourses('${currentSemester.year}1'),
  //   ]);
  //   if (result[0].isNotEmpty && result[1].isEmpty && result[2].isEmpty) {
  //     return true;
  //   }
  //   return false;
  // }
}
