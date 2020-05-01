import 'package:SIGApp/models/horario_model/hora_horario.dart';

import 'casillero_horario.dart';

class FilaHorario{
  HoraHorario inicio;
  HoraHorario fin;
  List<CasilleroHorario> cursos;

  FilaHorario(this.inicio, this.fin){
    cursos = List<CasilleroHorario>();
  }

  // get lunes => cursos[0];  

  // get martes => cursos[1];

  // get miercoles => cursos[2];

  // get jueves => cursos[3];

  // get viernes => cursos[4];

  // set lunes(CasilleroHorario ch){
  //   cursos[0] = ch;
  // }
  
  // set martes(CasilleroHorario ch){
  //   cursos[1] = ch;
  // }
  
  // set miercoles(CasilleroHorario ch){
  //   cursos[2] = ch;
  // }
  
  // set jueves(CasilleroHorario ch){
  //   cursos[3] = ch;
  // }
  
  // set viernes(CasilleroHorario ch){
  //   cursos[4] = ch;
  // }
  
}