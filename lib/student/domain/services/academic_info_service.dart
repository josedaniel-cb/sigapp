import 'package:sigapp/student/domain/value_objects/academic_info_data.dart';

abstract class AcademicInfoService {
  Future<AcademicInfoData> getSessionInfo();
  void clearSessionInfo();
}
