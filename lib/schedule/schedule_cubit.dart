import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:sigapp/student/entities/student_semester_schedule.dart';
import 'package:sigapp/student/student_service.dart';

part 'schedule_cubit.freezed.dart';

@freezed
abstract class ScheduleState with _$ScheduleState {
  const factory ScheduleState.loading() = LoadingState;
  const factory ScheduleState.success(
    StudentSemesterSchedule schedule,
  ) = SuccessState;
  const factory ScheduleState.error(String message) = ErrorState;
}

@injectable
class ScheduleCubit extends Cubit<ScheduleState> {
  final StudentService _studentService;

  ScheduleCubit(
    this._studentService,
  ) : super(const ScheduleState.loading());

  Future<void> setup() async {
    emit(const ScheduleState.loading());
    try {
      final studentSemesterSchedule =
          await _studentService.getDefaultClassSchedule();

      emit(ScheduleState.success(studentSemesterSchedule));
    } catch (e, s) {
      if (kDebugMode) {
        print(e);
        print(s);
      }
      emit(ScheduleState.error(e.toString()));
    }
  }
}
