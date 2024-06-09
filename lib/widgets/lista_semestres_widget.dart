import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:sigapp/app/app.dart';

import 'nada_que_mostrar_widget.dart';

class ListaSemestresWidget extends StatelessWidget{
  final List<ElementoListaSemestresWidget> children;
  final Widget? leyenda;
  final String? nadaQueMostrarMensaje;
  final Icon icono;

  final double _margen = 15;

  const ListaSemestresWidget({super.key, 
    required this.children,
    required this.icono,
    this.leyenda,
    this.nadaQueMostrarMensaje,
  });

  @override
  Widget build(BuildContext context) {
    if(children.isNotEmpty){
      return ElasticInUp(
        child: _buildBody(),
      );
    } else {
      if(nadaQueMostrarMensaje != null){
        return NadaQueMostrarWidget(
          mensaje: nadaQueMostrarMensaje,
        );
      } else {
        return const NadaQueMostrarWidget();
      }
    }
  }

  Widget _buildBody(){
    List<Widget> contenido;

    contenido = List.generate(children.length, (int i){
      return ListTile(
        leading: icono,
        title: Text(
          children[i].titulo,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black54,
          ),
        ),
        trailing: SizedBox(
          height: 20,
          width: 20,            
          child: Container(
            decoration: BoxDecoration(
              color: App.blueColor,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              '${children[i].numero}',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 12,
              ),
            ),
          ),
        ),
        onTap: children[i].onPressed as void Function()?,
      );
    });

    if(leyenda != null){
      contenido.insert(0, _buildLeyenda());
    }

    return ListView(
      children: contenido,
    );
  }

  Widget _buildLeyenda(){
    return Container(
      // margin: EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(
                // top: _margen,
              ),
              child: leyenda,
            ),
          ),
        ],
      ),
    );
  }

}

class ElementoListaSemestresWidget{
  final String titulo;
  final int numero;
  final Function onPressed;

  ElementoListaSemestresWidget({
    required this.titulo, 
    required this.numero, 
    required this.onPressed
  });
}