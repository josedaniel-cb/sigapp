import 'package:sigapp/courses/domain/value-objects/syllabus_download_data.dart';

abstract class RegevaRepository {
  String buildGradesUrl({
    required String scheduledCourseId,
    required String token1,
    required String token2,
    required String studentCode,
  });

  /// Necessary to download Regeva files
  Future<void> authenticate({
    required String sigaToken1,
    required String sigaToken2,
    required String studentCode,
  });

  Future<SyllabusDownloadData?> downloadSyllabus(String scheduledCourseId);

  Future<void> disposeCookies();
}
