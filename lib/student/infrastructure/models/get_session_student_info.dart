import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_session_student_info.freezed.dart';

@freezed
class GetSessionStudentInfoModel with _$GetSessionStudentInfoModel {
  factory GetSessionStudentInfoModel({
    required String currentSemesterId,
    required String schoolName,
  }) = _GetSessionStudentInfoModel;
}
