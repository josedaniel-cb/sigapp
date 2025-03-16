import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:sigapp/student/domain/entities/student_academic_report.dart';
import 'package:sigapp/student/domain/services/student_info_service.dart';

part 'student_cubit.freezed.dart';

@freezed
abstract class StudentPageViewState with _$StudentPageViewState {
  const factory StudentPageViewState.loading() = LoadingState;
  const factory StudentPageViewState.success(
    AcademicReport academicReport,
  ) = SuccessState;
  const factory StudentPageViewState.error(String message) = ErrorState;
}

@injectable
class StudentPageViewCubit extends Cubit<StudentPageViewState> {
  final SessionInfoService _sessionInfoService;

  StudentPageViewCubit(
    this._sessionInfoService,
  ) : super(const StudentPageViewState.loading());

  Future<void> setup() async {
    emit(const StudentPageViewState.loading());
    try {
      final sessionInfo = await _sessionInfoService.getSessionInfo();
      emit(StudentPageViewState.success(sessionInfo.academicReport));
    } catch (e, s) {
      if (kDebugMode) {
        print(e);
        print(s);
      }
      emit(StudentPageViewState.error(e.toString()));
    }
  }
}
