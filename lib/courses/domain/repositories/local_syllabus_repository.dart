import 'dart:io';
import 'dart:typed_data';

abstract class LocalSyllabusRepository {
  Future<File> replaceOrCreate(
    String scheduledCourseId,
    Uint8List file,
    String mimeType,
  );
  Future<File?> get(String scheduledCourseId);
}
