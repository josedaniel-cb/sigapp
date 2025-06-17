import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:sigapp/student/domain/entities/student_academic_report.dart';
import 'package:sigapp/student/domain/services/academic_info_service.dart';

part 'student_cubit.freezed.dart';

@freezed
sealed class StudentPageViewState with _$StudentPageViewState {
  const factory StudentPageViewState.loading() = LoadingState;
  const factory StudentPageViewState.success(AcademicReport academicReport) =
      SuccessState;
  const factory StudentPageViewState.error(Object error) = ErrorState;
}

@injectable
class StudentPageViewCubit extends Cubit<StudentPageViewState> {
  final AcademicInfoService _sessionInfoService;
  final Logger _logger;

  StudentPageViewCubit(this._sessionInfoService, this._logger)
    : super(const StudentPageViewState.loading());

  Future<void> setup() async {
    emit(const StudentPageViewState.loading());
    try {
      final sessionInfo = await _sessionInfoService.getSessionInfo();
      emit(StudentPageViewState.success(sessionInfo.academicReport));
    } catch (e, s) {
      _logger.e('[UI] Error setting up Student Page', error: e, stackTrace: s);
      emit(StudentPageViewState.error(e));
    }
  }
}
