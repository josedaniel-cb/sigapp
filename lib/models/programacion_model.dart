import 'curso_model/curso_model.dart';

class ProgramacionModel{
  List<CursoModel> cursos;
  final String semestre;

  ProgramacionModel(this.semestre){
    cursos = List<CursoModel>();
  }
}