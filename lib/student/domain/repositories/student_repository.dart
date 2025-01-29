import 'package:sigapp/student/domain/value_objects/raw_academic_report.dart';
import 'package:sigapp/student/domain/value_objects/student_session_info.dart';

abstract class StudentRepository {
  Future<StudentSessionInfo> getSessionStudentInfo();

  Future<RawAcademicReport> getAcademicReport();
}
