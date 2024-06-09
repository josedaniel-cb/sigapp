import 'package:flutter/material.dart';

class NadaQueMostrarWidget extends StatelessWidget{
  // final _mensajeDefault = "Puede que no tengas cursos inscritos en este semestre";
  // final mensajePersonalizado;
  final mensaje;

  // const NadaQueMostrarWidget({this.mensajePersonalizado});
  // const NadaQueMostrarWidget({this.mensaje = 'Puede que no tengas cursos inscritos en este semestre'});
  const NadaQueMostrarWidget({super.key, this.mensaje = 'Nada que mostrar'});
    
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "¡Ups!",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black26,
                fontSize: 25,
                fontWeight: FontWeight.w600
              ),
            ),
            const SizedBox(height: 5,),
            Text(
              // mensajePersonalizado ?? _mensajeDefault,
              mensaje,
              // 'jaja',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black26,
                fontSize: 15,
                fontWeight: FontWeight.w600
              ),
            ),
            const SizedBox(height: 5,),
            const Text(
              "🤥",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black26,
                fontSize:80,
                fontWeight: FontWeight.w600
              ),
            ),
          ],
        ),
      ),
    );
  }

}