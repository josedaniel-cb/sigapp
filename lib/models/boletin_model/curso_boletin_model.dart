import 'package:SIGApp/models/curso_model/curso_model.dart';

class CursoBoletinModel extends CursoModel{
  late String silaboUrl;
  // String notasUrl;

  CursoBoletinModel(String curso, String codigo) : super(curso, codigo);

  String get creditos => caracteristicas[0].contenido;
  String get clave => caracteristicas[1].contenido;
  String get profesor => caracteristicas[2].contenido;
  String get seccion => caracteristicas[3].contenido;
  String get aula => caracteristicas[4].contenido;
  String get grupo => caracteristicas[5].contenido;
  String get fechaInscripcion => caracteristicas[6].contenido;
  String get acta => caracteristicas[7].contenido;
}