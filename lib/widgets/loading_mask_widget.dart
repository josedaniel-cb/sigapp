import 'package:flutter/material.dart';

class LoadingMaskWidget extends StatelessWidget{
  final String mensaje; 
  final double alto;
  final double ancho;

  LoadingMaskWidget({
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
    final double lateralMargins = 20;
    return Container(  
      padding: EdgeInsets.all(lateralMargins),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(lateralMargins)
        ),
      ),        
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            width: 30.0,
            height: 30.0,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              backgroundColor: Colors.white,
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: lateralMargins),
            child: Text(
              mensaje,
            ),
          ),
        ],
      ),
    ); 
  }

}