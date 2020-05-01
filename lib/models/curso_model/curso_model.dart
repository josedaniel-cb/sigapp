import 'curso_caracteristica.dart';

class CursoModel{
  String nombre;
  String codigo;
  List<CursoCaracteristica> caracteristicas;

  CursoModel(this.nombre, this.codigo){
    caracteristicas = List<CursoCaracteristica>();
  }
}