import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:sigapp/courses/application/exceptions/regeva_authentication_exception.dart';
import 'package:sigapp/courses/domain/repositories/courses_repository.dart';
import 'package:sigapp/courses/domain/repositories/local_syllabus_repository.dart';
import 'package:sigapp/courses/domain/repositories/regeva_repository.dart';
import 'package:sigapp/courses/domain/value-objects/syllabus_download_data.dart';

@lazySingleton
class GetSyllabusFileUsecase {
  final RegevaRepository _regevaRepository;
  final CoursesRepository _coursesRepository;
  final LocalSyllabusRepository _localSyllabusRepository;

  GetSyllabusFileUsecase(this._regevaRepository, this._coursesRepository,
      this._localSyllabusRepository);

  Future<File?> execute(String scheduledCourseId, {bool? forceDownload}) async {
    File? cached;

    if (forceDownload != true) {
      // Try to get the syllabus file from the local repository
      cached = await _localSyllabusRepository.get(scheduledCourseId);
      if (cached != null) return cached;
    }

    // If the file is not cached, download it
    final downloadedFile = await _downloadFile(scheduledCourseId);
    if (downloadedFile == null) return null;

    // Save the downloaded file
    cached = await _localSyllabusRepository.replaceOrCreate(
      scheduledCourseId,
      downloadedFile.data,
      downloadedFile.contentType!,
    );

    return cached;
  }

  Future<SyllabusDownloadData?> _downloadFile(String scheduledCourseId) async {
    // Try to get the syllabus file
    try {
      return await _regevaRepository.downloadSyllabus(scheduledCourseId);
    } catch (e, s) {
      if (kDebugMode) {
        print(e);
        print(s);
      }
      if (e is! RegevaAuthenticationException) rethrow;
    }

    // If the user is not authenticated, authenticate and try again
    final [studentCode, token1, token2] =
        await _coursesRepository.getStudentCodeAndRegevaTokens();
    await _regevaRepository.authenticate(
      sigaToken1: token1,
      sigaToken2: token2,
      studentCode: studentCode,
    );
    return await _regevaRepository.downloadSyllabus(scheduledCourseId);
  }
}
