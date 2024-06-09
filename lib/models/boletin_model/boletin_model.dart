import 'package:sigapp/models/boletin_model/curso_boletin_model.dart';

class BoletinModel {
  late List<CursoBoletinModel> cursos;
  int? totalCursos;
  int? totalCreditos;

  BoletinModel() {
    cursos = [];
  }
}
