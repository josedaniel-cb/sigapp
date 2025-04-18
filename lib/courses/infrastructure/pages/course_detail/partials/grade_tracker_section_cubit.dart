import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:sigapp/courses/application/usecases/grade_tracking_usecases.dart';
import 'package:sigapp/courses/domain/entities/grade_tracking.dart';

part 'grade_tracker_section_cubit.freezed.dart';

@freezed
class GradeTrackerSectionState with _$GradeTrackerSectionState {
  const factory GradeTrackerSectionState.empty() =
      GradeTrackerSectionEmptyState;

  const factory GradeTrackerSectionState.loading() =
      GradeTrackerSectionLoadingState;

  const factory GradeTrackerSectionState.ready({
    required CourseTracking courseTracking,
  }) = GradeTrackerSectionReadyState;

  const factory GradeTrackerSectionState.error({
    String? message,
  }) = GradeTrackerSectionErrorState;
}

@injectable
class GradeTrackerSectionCubit extends Cubit<GradeTrackerSectionState> {
  final GradeTrackingUseCases _gradeTrackingUseCases;
  String? _courseId;

  GradeTrackerSectionCubit(this._gradeTrackingUseCases)
      : super(const GradeTrackerSectionState.empty());

  Future<void> init({required String courseId}) async {
    _courseId = courseId;

    await _loadData();
  }

  Future<void> _loadData() async {
    try {
      emit(const GradeTrackerSectionState.loading());

      // Intentamos obtener el seguimiento existente
      CourseTracking? tracking;

      if (_courseId != null) {
        tracking = await _gradeTrackingUseCases.getCourseById(
          courseId: _courseId!,
        );
      }

      if (tracking != null) {
        emit(GradeTrackerSectionState.ready(courseTracking: tracking));
      } else {
        // Si no existe, mantenemos el estado vacío
        emit(const GradeTrackerSectionState.empty());
      }
    } catch (e, s) {
      if (kDebugMode) {
        print(e);
        print(s);
      }
      emit(GradeTrackerSectionState.error(
        message: "Error al cargar el seguimiento de notas: ${e.toString()}",
      ));
    }
  }

  Future<void> retry() async {
    await _loadData();
  }

  Future<void> createCourseTracking({required String courseName}) async {
    try {
      emit(const GradeTrackerSectionState.loading());

      // Usamos el courseId guardado durante la inicialización como identificador
      // para asegurarnos de que siempre recuperemos el mismo curso
      if (_courseId == null) {
        emit(GradeTrackerSectionState.error(
          message: "Error: No se pudo identificar el curso",
        ));
        return;
      }

      // Primero verificamos si ya existe un curso con este ID
      CourseTracking? existingTracking =
          await _gradeTrackingUseCases.getCourseById(
        courseId: _courseId!,
      );

      if (existingTracking != null) {
        // Si ya existe, simplemente lo cargamos
        emit(GradeTrackerSectionState.ready(courseTracking: existingTracking));
        return;
      }

      // Crear un seguimiento de curso con categorías y notas predeterminadas
      // Pasamos el _courseId como identificador único
      final tracking =
          await _gradeTrackingUseCases.createCourseTrackingWithDefaults(
        courseId: _courseId!,
        courseName: courseName,
      );

      emit(GradeTrackerSectionState.ready(courseTracking: tracking));
    } catch (e, s) {
      if (kDebugMode) {
        print(e);
        print(s);
      }
      emit(GradeTrackerSectionState.error(
        message: "Error al crear el seguimiento de notas: ${e.toString()}",
      ));
    }
  }

  // Métodos para gestionar categorías
  Future<void> addCategory(
      {required String name, required double weight}) async {
    final currentState = state;
    if (currentState is GradeTrackerSectionReadyState) {
      try {
        final courseId = currentState.courseTracking.id;
        final updatedTracking = await _gradeTrackingUseCases.addCategory(
          courseId: courseId,
          categoryName: name,
          weight: weight,
        );
        emit(GradeTrackerSectionState.ready(courseTracking: updatedTracking));
      } catch (e, s) {
        if (kDebugMode) {
          print(e);
          print(s);
        }
        emit(GradeTrackerSectionState.error(
          message: "Error al añadir categoría: ${e.toString()}",
        ));
      }
    }
  }

  Future<void> updateCategory({
    required String categoryId,
    required String newName,
    required double newWeight,
  }) async {
    final currentState = state;
    if (currentState is GradeTrackerSectionReadyState) {
      try {
        final courseId = currentState.courseTracking.id;
        final updatedTracking = await _gradeTrackingUseCases.updateCategory(
          courseId: courseId,
          categoryId: categoryId,
          newName: newName,
          newWeight: newWeight,
        );
        emit(GradeTrackerSectionState.ready(courseTracking: updatedTracking));
      } catch (e, s) {
        if (kDebugMode) {
          print(e);
          print(s);
        }
        emit(GradeTrackerSectionState.error(
          message: "Error al actualizar categoría: ${e.toString()}",
        ));
      }
    }
  }

  Future<void> deleteCategory({required String categoryId}) async {
    final currentState = state;
    if (currentState is GradeTrackerSectionReadyState) {
      try {
        final courseId = currentState.courseTracking.id;
        final updatedTracking = await _gradeTrackingUseCases.removeCategory(
          courseId: courseId,
          categoryId: categoryId,
        );
        emit(GradeTrackerSectionState.ready(courseTracking: updatedTracking));
      } catch (e, s) {
        if (kDebugMode) {
          print(e);
          print(s);
        }
        emit(GradeTrackerSectionState.error(
          message: "Error al eliminar categoría: ${e.toString()}",
        ));
      }
    }
  }

  // Métodos para gestionar notas
  Future<void> addGrade({
    required String categoryId,
    required String name,
    required double score,
  }) async {
    final currentState = state;
    if (currentState is GradeTrackerSectionReadyState) {
      try {
        final courseId = currentState.courseTracking.id;
        final updatedTracking = await _gradeTrackingUseCases.addGrade(
          courseId: courseId,
          categoryId: categoryId,
          gradeName: name,
          score: score,
        );
        emit(GradeTrackerSectionState.ready(courseTracking: updatedTracking));
      } catch (e, s) {
        if (kDebugMode) {
          print(e);
          print(s);
        }
        emit(GradeTrackerSectionState.error(
          message: "Error al añadir nota: ${e.toString()}",
        ));
      }
    }
  }

  Future<void> updateGrade({
    required String categoryId,
    required String gradeId,
    required String newName,
    required double newScore,
  }) async {
    final currentState = state;
    if (currentState is GradeTrackerSectionReadyState) {
      try {
        final courseId = currentState.courseTracking.id;
        final updatedTracking = await _gradeTrackingUseCases.updateGrade(
          courseId: courseId,
          categoryId: categoryId,
          gradeId: gradeId,
          newName: newName,
          newScore: newScore,
        );
        emit(GradeTrackerSectionState.ready(courseTracking: updatedTracking));
      } catch (e, s) {
        if (kDebugMode) {
          print(e);
          print(s);
        }
        emit(GradeTrackerSectionState.error(
          message: "Error al actualizar nota: ${e.toString()}",
        ));
      }
    }
  }

  Future<void> toggleGradeEnabled({
    required String categoryId,
    required String gradeId,
    required bool enabled,
  }) async {
    final currentState = state;
    if (currentState is GradeTrackerSectionReadyState) {
      try {
        final courseId = currentState.courseTracking.id;
        final updatedTracking = await _gradeTrackingUseCases.toggleGradeEnabled(
          courseId: courseId,
          categoryId: categoryId,
          gradeId: gradeId,
          enabled: enabled,
        );
        emit(GradeTrackerSectionState.ready(courseTracking: updatedTracking));
      } catch (e, s) {
        if (kDebugMode) {
          print(e);
          print(s);
        }
        emit(GradeTrackerSectionState.error(
          message: "Error al cambiar estado de nota: ${e.toString()}",
        ));
      }
    }
  }

  Future<void> deleteGrade({
    required String categoryId,
    required String gradeId,
  }) async {
    final currentState = state;
    if (currentState is GradeTrackerSectionReadyState) {
      try {
        final courseId = currentState.courseTracking.id;
        final updatedTracking = await _gradeTrackingUseCases.removeGrade(
          courseId: courseId,
          categoryId: categoryId,
          gradeId: gradeId,
        );
        emit(GradeTrackerSectionState.ready(courseTracking: updatedTracking));
      } catch (e, s) {
        if (kDebugMode) {
          print(e);
          print(s);
        }
        emit(GradeTrackerSectionState.error(
          message: "Error al eliminar nota: ${e.toString()}",
        ));
      }
    }
  }
}
