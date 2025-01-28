import 'package:freezed_annotation/freezed_annotation.dart';

part 'student_session_info.freezed.dart';

@freezed
class StudentSessionInfo with _$StudentSessionInfo {
  factory StudentSessionInfo({
    required String currentSemesterId,
    required String schoolName,
  }) = _StudentSessionInfo;
}
