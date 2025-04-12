import 'package:injectable/injectable.dart';
import 'package:sigapp/courses/application/value-objects/student_session_info.dart';
import 'package:sigapp/courses/application/repositories/student_session_repository.dart';
import 'package:sigapp/courses/application/services/student_session_service.dart';

@LazySingleton(as: StudentSessionService)
class StudentSessionServiceImpl implements StudentSessionService {
  final StudentSessionRepository _studentSessionRepository;

  StudentSessionInfo? _cachedCredentials;

  StudentSessionServiceImpl(this._studentSessionRepository);

  @override
  Future<StudentSessionInfo> getInfo([bool? refresh]) async {
    if (refresh != true && _cachedCredentials != null) {
      return _cachedCredentials!;
    }
    final value = await _studentSessionRepository.getStudentSessionInfo();
    _cachedCredentials = value;
    return value;
  }
}
