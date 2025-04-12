import 'package:sigapp/student/infrastructure/services/academic_info_service.dart';

abstract class AcademicInfoService {
  Future<AcademicInfoData> getSessionInfo();
  void clearSessionInfo();
}
