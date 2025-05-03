import 'package:freezed_annotation/freezed_annotation.dart';

part 'session_exception.freezed.dart';

/// Base exception class for all (auth) session-related exceptions
@freezed
class SessionException with _$SessionException implements Exception {
  const factory SessionException.networkError({
    required String message,
    required dynamic originalError,
  }) = NetworkSessionException;

  const factory SessionException.refreshError({
    required String message,
    required dynamic originalError,
  }) = RefreshSessionException;

  const factory SessionException.authenticationError({
    required String message,
    required dynamic originalError,
  }) = AuthenticationSessionException;

  const factory SessionException.studentInfoError({
    required String message,
    required dynamic originalError,
  }) = StudentInfoSessionException;

  const factory SessionException.pendingSurveyError({
    required String message,
    required dynamic originalError,
  }) = PendingSurveySessionException;

  /// Unknown errors
  const factory SessionException.unknownError({
    required String message,
    required dynamic originalError,
  }) = UnknownSessionException;
}
