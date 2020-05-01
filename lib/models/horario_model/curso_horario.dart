import 'package:flutter/material.dart';

class CursoHorario{
  final String curso;
  final String aula;
  final Color colorTexto;
  final Color colorFondo;

  CursoHorario(this.curso, this.aula, this.colorTexto, this.colorFondo);

  @override
  String toString(){
    return '''
    curso: $curso,\taula: $aula,\tcolorTexto:\t${colorTexto.value},\tcolorFondo: ${colorFondo.value}
    ''';
  }
}