import 'package:injectable/injectable.dart';
import 'package:sigapp/student/domain/entities/student_academic_report.dart';
import 'package:sigapp/student/domain/entities/student_semester_schedule.dart';
import 'package:sigapp/student/domain/repositories/student_repository.dart';

@lazySingleton
class GetAcademicReportUsecase {
  final StudentRepository _studentRepository;

  GetAcademicReportUsecase(this._studentRepository);

  Future<AcademicReport> execute() async {
    final academicReportModel =
        await _studentRepository.getAcademicReport().then(
              (value) => value.copyWith(
                lastSemesterId: value.lastSemesterId?.trim(),
                curriculumSemesterId: value.curriculumSemesterId.trim(),
                enrollmentSemesterId: value.enrollmentSemesterId.trim(),
              ),
            );
    final sessionStudentInfoModel =
        await _studentRepository.getSessionStudentInfo();

    final studentInfoParts = academicReportModel.studentName.split(' - ');
    studentInfoParts.replaceRange(1, 2, studentInfoParts[1].split(', '));
    return AcademicReport(
      faculty: academicReportModel.faculty,
      school: sessionStudentInfoModel.schoolName,
      firstName: studentInfoParts[2],
      lastName: studentInfoParts[1],
      code: studentInfoParts[0],
      cohort: academicReportModel.cohort,
      enrollmentSemesterId: academicReportModel.enrollmentSemesterId,
      curriculumSemesterId: academicReportModel.curriculumSemesterId,
      lastSemesterId: academicReportModel.lastSemesterId,
      cumulativeWeightedAverage: academicReportModel.cumulativeWeightedAverage,
      cumulativeWeightedAverageOfPassedCourses:
          academicReportModel.cumulativeWeightedAverageOfPassedCourses,
      lastCumulativeWeightedAverage:
          academicReportModel.lastCumulativeWeightedAverage,
      curriculumMandatoryCredits:
          academicReportModel.curriculumMandatoryCredits,
      curriculumElectiveCredits: academicReportModel.curriculumElectiveCredits,
      totalCreditsOfPassedCourses:
          academicReportModel.totalCreditsOfPassedCourses,
      mandatoryCreditsOfPassedCourses:
          academicReportModel.mandatoryCreditsOfPassedCourses,
      electiveCreditsOfPassedCourses:
          academicReportModel.electiveCreditsOfPassedCourses,
      currentSemesterId: SemesterScheduleSemesterMetadata.getIdFromName(
          sessionStudentInfoModel.currentSemesterName),
    );
  }
}
