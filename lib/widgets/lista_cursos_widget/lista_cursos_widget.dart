import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../nada_que_mostrar_widget.dart';
import 'curso_widget.dart';

class ListaCursosWidget extends StatelessWidget{  
  final List<CursoWidget> cursos;
  final Widget leyenda;
  final String nadaQueMostrarMensaje;

  // final Color _background = Colors.black12;    
  final Color _background = Color(0xFFd1d1d1);    
  final double _margen = 10;

  ListaCursosWidget({
    @required this.cursos,
    this.leyenda,
    this.nadaQueMostrarMensaje,
  }) : assert(cursos != null);

  @override
  Widget build(BuildContext context) {
    if(cursos.length != 0){
      return _buildBody(
        contenido: List.generate(cursos.length, (int i){
          return Container(
            margin: EdgeInsets.only(top: _margen),
            child: cursos[i],
          );
        }),
      );
    } else {
      if(nadaQueMostrarMensaje != null){
        return NadaQueMostrarWidget(
          mensaje: nadaQueMostrarMensaje,
        );
      } else {
        return NadaQueMostrarWidget();
      }
    }
  }

  Widget _buildBody({@required List<Widget> contenido}){
    if(leyenda != null){
      contenido.insert(0, _buildLeyenda());
    }
    
    return Container(
      color: _background,
      child: Scrollbar(
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                bottom: _margen + 4,
                left: _margen,
                right: _margen,
                top: 4,
              ),
              child:  FadeInUp(
                child: Column(
                  children: contenido,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // Widget _buildLeyenda(){
  //   return Container(
  //     color: _background,
  //     padding: EdgeInsets.only(
  //       top: _margen,
  //     ),
  //     child: leyenda,
  //   );
  // }

  Widget _buildLeyenda(){
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            // color: _background,
            // color: Colors.green,
            padding: EdgeInsets.only(
              top: _margen,
            ),
            child: leyenda,
          ),
        ),
      ],
    );
  }

}