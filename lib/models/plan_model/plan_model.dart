import 'package:sigapp/models/curso_model/curso_model.dart';

class PlanModel {
  String etiqueta;
  late List<CicloPlanModel?> ciclos;

  PlanModel(this.etiqueta) {
    ciclos = [];
  }
}

class CicloPlanModel {
  String etiqueta;
  List<CursoPlanModel>? cursos;

  CicloPlanModel(this.etiqueta) {
    cursos = [];
  }
}

class CursoPlanModel extends CursoModel {
  List<RequisitoCursoPlanModel>? requisitos;

  CursoPlanModel(super.curso, super.codigo) {
    requisitos = [];
  }

  String get requisitosData => caracteristicas[0].contenido;
  String get tipo => caracteristicas[1].contenido;
  String get creditos => caracteristicas[2].contenido;
}

class RequisitoCursoPlanModel {
  final int? cicloIndex;
  final int? cursoIndex;

  RequisitoCursoPlanModel(this.cicloIndex, this.cursoIndex);
}
