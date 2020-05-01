import 'package:SIGApp/models/curso_model/curso_model.dart';

class PlanModel{
  String etiqueta;
  List<CicloPlanModel> ciclos;

  PlanModel(this.etiqueta){
    ciclos = List<CicloPlanModel>();
  }
}

class CicloPlanModel{
  String etiqueta;
  List<CursoPlanModel> cursos;

  CicloPlanModel(this.etiqueta){
    cursos = List<CursoPlanModel>();
  }
}

class CursoPlanModel extends CursoModel{
  List<RequisitoCursoPlanModel> requisitos;

  CursoPlanModel(String curso, String codigo) : super(curso, codigo){
    requisitos = List<RequisitoCursoPlanModel>();
  }

  String get requisitosData => caracteristicas[0].contenido;
  String get tipo => caracteristicas[1].contenido;
  String get creditos => caracteristicas[2].contenido;
  
}

class RequisitoCursoPlanModel{
  final int cicloIndex;
  final int cursoIndex;

  RequisitoCursoPlanModel(this.cicloIndex, this.cursoIndex);
}

