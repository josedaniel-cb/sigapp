import 'package:sigapp/student/infrastructure/services/student_info_service.dart';

abstract class SessionInfoService {
  Future<SessionInfoData> getSessionInfo();
  void clearSessionInfo();
}
