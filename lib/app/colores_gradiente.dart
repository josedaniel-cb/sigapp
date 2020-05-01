import 'package:flutter/material.dart';

class ColoresGradiente{
  static List<Color> blueDefault = [
    Colors.blue[300],
    Colors.blue[500],
    Colors.blue[700],
    Colors.blue[900],
  ];

  static List<Color> teal = [
    Colors.teal[300],
    Colors.teal[500],
    Colors.teal[700],
    Colors.teal[900],
  ];

  static List<Color> amber = [
    Colors.amber[600],
    Colors.amber[700],
    Colors.amber[900],
    Colors.amber[900],
  ];

  static List<Color> blueGrey = [
    Colors.blueGrey[300],
    Colors.blueGrey[500],
    Colors.blueGrey[700],
    Colors.blueGrey[900],
  ];

  static List<Color> indigo = [
    Colors.indigo[300],
    Colors.indigo[500],
    Colors.indigo[700],
    Colors.indigo[900],
  ];

  static List<Color> lime = [
    Colors.lime[600],
    Colors.lime[700],
    Colors.lime[800],
    Colors.lime[900],
  ];

  static List<Color> grey = [
    Colors.grey[500],
    Colors.grey[700],
    Colors.grey[800],
    Colors.grey[900],
  ];

  static List<Color> red = [
    Colors.red[300],
    Colors.red[600],
    Colors.red[700],
    Colors.red[900],
  ];

  static List<Color> cyan = [
    Colors.cyan[300],
    Colors.cyan[700],
    Colors.cyan[800],
    Colors.cyan[900],
  ];

  static List<Color> brown = [
    Colors.brown[300],
    Colors.brown[500],
    Colors.brown[700],
    Colors.brown[800],
  ];

  static List<Color> deepOrange = [
    Colors.deepOrange[300],
    Colors.deepOrange[500],
    Colors.deepOrange[700],
    Colors.deepOrange[900],
  ];

  static List<Color> orange = [
    Colors.orange[500],
    Colors.orange[700],
    Colors.orange[800],
    Colors.orange[900],
  ];

  static List<Color> green = [
    Colors.green[300],
    Colors.green[500],
    Colors.green[700],
    Colors.green[900],
  ];

  static List<Color> generarColores(String iniciales){
    int i1, i2, suma;
    List<Color> colores;

    i1 = iniciales[0].codeUnitAt(0);
    if (iniciales.length >= 2) {
      i2 = iniciales[1].codeUnitAt(0);
    } else {
      i2 = i1;
    }

    suma = i1 + i2;
    if (suma < 135) {
      colores = lime;
    } else if (suma < 139) {
      colores = green;
    } else if (suma < 143) {
      colores = blueGrey;
    } else if (suma < 147) {
      colores = brown;
    } else if (suma < 151) {
      colores = teal;
    } else if (suma < 156) {
      colores = cyan;
    } else if (suma < 160) {
      colores = indigo;
    } else if (suma < 164) {
      colores = grey;
    } else if (suma < 168) {
      colores = red;
    } else if (suma < 172) {
      colores = deepOrange;
    } else if (suma < 176) {
      colores = orange;
    } else if (suma >= 176) {
      colores = amber;
    }
    
    return colores;
  }

  
}