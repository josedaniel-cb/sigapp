import 'package:flutter/material.dart';

class LoadingMaskWidget extends StatelessWidget{
  final String mensaje; 
  final double alto;
  final double ancho;

  const LoadingMaskWidget({super.key, 
    required this.mensaje, 
    required this.alto, 
    required this.ancho
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: alto,
      width: ancho,
      color: const Color(0xcc000000),
      child: SafeArea(
        child: Center(
          child: _buildLoadingMessage(mensaje),
        ),
      ),
    );
  }

  Widget _buildLoadingMessage(String mensaje){
    const double lateralMargins = 20;
    return Container(  
      padding: const EdgeInsets.all(lateralMargins),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(lateralMargins)
        ),
      ),        
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const SizedBox(
            width: 30.0,
            height: 30.0,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              backgroundColor: Colors.white,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: lateralMargins),
            child: Text(
              mensaje,
            ),
          ),
        ],
      ),
    ); 
  }

}