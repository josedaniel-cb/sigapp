import 'package:sigapp/courses/application/value-objects/student_session_info.dart';

abstract class StudentSessionService {
  Future<StudentSessionInfo> getInfo([bool? refresh]);
}
