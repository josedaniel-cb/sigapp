import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:sigapp/student/entities/student_semester_schedule.dart';
import 'package:sigapp/student/models/get_academic_report.dart';
import 'package:sigapp/student/models/get_class_schedule.dart';
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
      final academicReport = await _studentService.getAcademicReport();
      final lastSemester = academicReport.UltSemestre;
      final firstSemester = academicReport.SemestreIngreso;

      // String semesterToFetch = lastSemester ?? '';
      String? semester;
      List<GetClassScheduleModel>? rawSchedule;

      if (lastSemester != null) {
        semester = lastSemester;
        rawSchedule = await _studentService.getClassSchedule(semester);
      }

      if (rawSchedule == null || rawSchedule.isEmpty) {
        // Assume getCurrentSemester() and getPreviousSemester(semester) are available
        var currentSemester = getLastPossibleSemester();
        var attempts = 0;
        const maxAttempts = 10;
        while (rawSchedule == null || rawSchedule.isEmpty) {
          if (attempts >= maxAttempts || currentSemester == firstSemester) {
            semester = firstSemester;
            rawSchedule = await _studentService.getClassSchedule(semester);
            break;
          }
          currentSemester = getPreviousSemester(currentSemester);

          // Perform attempt
          semester = currentSemester;
          rawSchedule = await _studentService.getClassSchedule(semester);

          attempts++;
        }
      }

      // print(rawSchedule);

      emit(ScheduleState.success(
        StudentSemesterSchedule(
          semester: semester!,
          rawSchedule: rawSchedule,
        ),
      ));
    } catch (e, s) {
      if (kDebugMode) {
        print(e);
        print(s);
      }
      emit(ScheduleState.error(e.toString()));
    }
  }

  // Helper methods (assuming these need to be implemented or are provided)
  String getLastPossibleSemester() {
    final DateTime now = DateTime.now();
    final int year = now.year;
    return '${year}2';
  }

  String getPreviousSemester(String semester) {
    // Implementation to calculate the previous semester based on the given semester
    // This is a simplified example and may need to be adjusted based on the actual semester naming convention
    int year = int.parse(semester.substring(0, 4));
    String period = semester.substring(4);
    if (period == '2') {
      return '${year}1';
    } else {
      year -= 1;
      return '${year}2';
    }
  }
}
