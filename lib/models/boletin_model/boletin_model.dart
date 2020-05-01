import 'package:SIGApp/models/boletin_model/curso_boletin_model.dart';

class BoletinModel{
  List<CursoBoletinModel> cursos;
  int totalCursos;
  int totalCreditos;

  BoletinModel(){
    cursos = List<CursoBoletinModel>();
  }
}