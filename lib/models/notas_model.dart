import 'package:SIGApp/models/curso_model/curso_model.dart';

class NotasModel{
  final List<CriterioEvaluacionNotasModel> criterios;
  // final int asistenciasTotalClases;
  // final int asistenciasTotalAsistencias;
  // final int asistenciasTotalFaltas;

  final CursoModel? curso;
  final String? estadoLabel;
  final String? notaFinalLabel;
  final double? notaSustitutorio;
  final double? notaFinal;

  String? error;

  NotasModel({
    required this.criterios, 
    // this.asistenciasTotalClases, 
    // this.asistenciasTotalAsistencias, 
    // this.asistenciasTotalFaltas,
    this.curso, 
    this.estadoLabel, 
    this.notaSustitutorio,
    this.notaFinal,
    this.error,
    this.notaFinalLabel
  });
}

class CriterioEvaluacionNotasModel{
  final String titulo;
  final double notaPromedio;
  final int porcentaje;
  final String mensaje;
  final List<ExamenNotasModel> examenes;

  CriterioEvaluacionNotasModel({
    required this.titulo, 
    required this.notaPromedio, 
    required this.porcentaje, 
    required this.mensaje, 
    required this.examenes
  });
}

class ExamenNotasModel{
  final String fechaExamen;
  final String? fechaRegistro;
  final double nota;

  ExamenNotasModel(this.fechaExamen, this.fechaRegistro, this.nota);
}