import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:sigapp/student/models/get_class_schedule.dart';
import 'package:sigapp/student/student_repository.dart';

part 'schedule_cubit.freezed.dart';

@freezed
abstract class ScheduleState with _$ScheduleState {
  const factory ScheduleState.loading() = LoadingState;
  const factory ScheduleState.success(
    List<GetClassScheduleModel> schedule,
  ) = SuccessState;
  const factory ScheduleState.error(String message) = ErrorState;
}

@injectable
class ScheduleCubit extends Cubit<ScheduleState> {
  final StudentRepository _studentRepository;

  ScheduleCubit(
    this._studentRepository,
  ) : super(const ScheduleState.loading());

  Future<void> setup() async {
    emit(const ScheduleState.loading());
    try {
      final result = await _studentRepository.getClassSchedule('20171');
      emit(ScheduleState.success(result));
    } catch (e, s) {
      if (kDebugMode) {
        print(e);
        print(s);
      }
      emit(ScheduleState.error(e.toString()));
    }
  }
}
