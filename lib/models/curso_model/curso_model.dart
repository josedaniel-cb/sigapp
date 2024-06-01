import 'curso_caracteristica.dart';

class CursoModel{
  String nombre;
  String? codigo;
  late List<CursoCaracteristica> caracteristicas;

  CursoModel(this.nombre, this.codigo){
    caracteristicas = [];
  }
}