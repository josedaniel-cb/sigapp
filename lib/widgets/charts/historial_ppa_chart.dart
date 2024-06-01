import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:SIGApp/models/historial_model.dart';

class HistorialPPAChart extends StatelessWidget {
  final HistorialModel? model;
  final TipoPonderado? criterio;

  // final List<Color> gradientColors = [
  //   const Color(0xff23b6e6),
  //   const Color(0xff02d39a),
  // ];
  final List<Color> gradientColors = [
    // const Color(0xffFFDD00),
    // const Color(0xffFF8800),
    // const Color(0xffFF0000),

    // const Color(0xff00FF9D),
    // const Color(0xffFF0062),

    const Color(0xff00AEFF),
    const Color(0xffFF00AE),
  ];

  HistorialPPAChart(this.model, this.criterio);

  // @override
  // Widget build(BuildContext context) {
  //   return Container(
  //     height: 300,
  //     color: Colors.red,
  //     child: LineChart(
  //       _mainData(),
  //       swapAnimationDuration: Duration(milliseconds: 700),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    double margen = 15;
    return AspectRatio(
      aspectRatio: 1.3,
      child: Container(
        decoration: BoxDecoration(
            // borderRadius: const BorderRadius.all(
            //   Radius.circular(15),
            // ),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
            color: const Color(0xff08465E)),
        // color: Colors.lightBlueAccent,
        child: Padding(
          padding: EdgeInsets.only(
              right: margen * 1.5,
              left: margen,
              // top: margen*1.5,
              bottom: margen * 0.8),
          child: LineChart(
            _mainData(),
            swapAnimationDuration: Duration(milliseconds: 700),
          ),
        ),
      ),
    );
  }

  LineChartData _mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            // color: Color(0xFF92C4DE),
            color: Color(0xFF729AB0),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: Color(0xff3C5D75),
            strokeWidth: 1,
          );
        },
      ),
      // titlesData: FlTitlesData(
      //   // show: true,
      //   bottomTitles: SideTitles(
      //     showTitles: true,
      //     reservedSize: 20,
      //     textStyle: TextStyle(
      //         color: const Color(0xffCADEE8),
      //         fontWeight: FontWeight.bold,
      //         fontSize: 14),
      //     getTitles: (values) => xAxisGetLabels(values),
      //     margin: 10,
      //   ),
      //   leftTitles: SideTitles(
      //     showTitles: true,
      //     textStyle: TextStyle(
      //       color: const Color(0xffCADEE8),
      //       fontWeight: FontWeight.bold,
      //       fontSize: 12,
      //     ),
      //     getTitles: (values) => yAxisGetLabels(values),
      //     reservedSize: 28,
      //     margin: 12,
      //   ),
      // ),
      titlesData: FlTitlesData(
        // show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 20,
            // textStyle: TextStyle(
            //     color: const Color(0xffCADEE8),
            //     fontWeight: FontWeight.bold,
            //     fontSize: 14),
            // getTitles: (values) => xAxisGetLabels(values),
            // margin: 10,
            getTitlesWidget: (value, meta) => Container(
              margin: EdgeInsets.only(top: 10),
              child: Text(
                xAxisGetLabels(value),
                style: TextStyle(
                  color: const Color(0xffCADEE8),
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
        // leftTitles: AxisTitles(
        //   showTitles: true,
        //   textStyle: TextStyle(
        //     color: const Color(0xffCADEE8),
        //     fontWeight: FontWeight.bold,
        //     fontSize: 12,
        //   ),
        //   getTitles: (values) => yAxisGetLabels(values),
        //   reservedSize: 28,
        //   margin: 12,
        // ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 28,
            getTitlesWidget: (value, meta) => Container(
              margin: EdgeInsets.only(left: 10),
              child: Text(
                yAxisGetLabels(value),
                style: TextStyle(
                  color: const Color(0xffCADEE8),
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),  
            ),
          ),
        ),
      ),
      // borderData: FlBorderData(
      //   show: true,
      //   border: Border.all(
      //     color: const Color(0xff37434d),
      //     width: 1,
      //   )
      // ),
      minX: 1,
      maxX: model!.ciclosRegulares.length.toDouble(),
      minY: 10,
      maxY: 20,
      lineBarsData: [
        LineChartBarData(
          spots: _getSpots(),
          // colors: gradientColors,
          gradient: LinearGradient(
            colors: gradientColors,
            stops: [0.0, 1.0],
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            // dotColor: Colors.white,
            show: true,
            // show: false,
            getDotPainter: (spot, percent, barData, index) =>
                FlDotCirclePainter(
              radius: 5,
              color: Colors.white,
            ),
          ),
          belowBarData: BarAreaData(
            show: true,
            // colors:
            //     gradientColors.map((color) => color.withOpacity(0.3)).toList(),
            gradient: LinearGradient(
              colors: gradientColors.map((color) => color.withOpacity(0.3)).toList(),
              stops: [0.0, 1.0],
            ),
          ),
        ),
      ],
    );
  }

  // String xAxisGetLabels(double value){
  //   String label;
  //   int n;

  //   label = '';
  //   n = value.toInt();

  //   if(model.ciclosRegulares.length == 1){
  //     label = model.ciclos[n - 1].etiqueta.split(':')[1].trim();
  //   } else if(model.ciclosRegulares.length % 2 == 0){ // cantidad par
  //     if(n == 1 || n == model.ciclosRegulares.length){
  //       label = model.ciclos[n - 1].etiqueta.split(':')[1].trim();
  //     }
  //   } else { // cantidad impar
  //     if(n == 1 || n == model.ciclosRegulares.length || n == (model.ciclosRegulares.length / 2 + 1)){
  //       label = model.ciclos[n - 1].etiqueta.split(':')[1].trim();
  //     }
  //   }

  //   return label;
  // }

  String xAxisGetLabels(double value) {
    String label;
    int n;

    label = '';
    n = value.toInt();
    const List<String> romanos = [
      'I',
      'II',
      'III',
      'IV',
      'V',
      'VI',
      'VII',
      'VIII',
      'IX',
      'X'
    ];

    // if(model.ciclosRegulares.length == 1){
    //   if(n <= 10){
    //     label = romanos[n - 1];
    //   } else {
    //     label = n.toString();
    //   }
    // } else if(model.ciclosRegulares.length % 2 == 0){ // cantidad par
    //   if(n == 1 || n == model.ciclosRegulares.length){
    //     if(n <= 10){
    //       label = romanos[n - 1];
    //     } else {
    //       label = n.toString();
    //     }
    //   }
    // } else { // cantidad impar
    //   if(n == 1 || n == model.ciclosRegulares.length || n == (model.ciclosRegulares.length / 2 + 1)){
    //     if(n <= 10){
    //       label = romanos[n - 1];
    //     } else {
    //       label = n.toString();
    //     }
    //   }
    // }

    if (n <= 10) {
      label = romanos[n - 1];
    } else {
      label = n.toString();
    }

    return label;
  }

  String yAxisGetLabels(double value) {
    String label;

    switch (value.toInt()) {
      case 10:
        label = '10.0';
        break;
      case 12:
        label = '12.0';
        break;
      case 14:
        label = '14.0';
        break;
      case 16:
        label = '16.0';
        break;
      case 18:
        label = '18.0';
        break;
      case 20:
        label = '20.0';
        break;
      default:
        label = '';
        break;
    }

    return label;
  }

  List<FlSpot> _getSpots() {
    List<FlSpot> puntos = [];
    double contador = 1;
    late double pp;

    for (int i = 0; i < model!.ciclos.length; i++) {
      if (model!.ciclos[i].matrizInformacion != null) {
        switch (criterio) {
          case TipoPonderado.PPSemestral:
            pp = model!.ciclos[i].pps;
            break;
          case TipoPonderado.PPSemestralAprobado:
            pp = model!.ciclos[i].ppsAprob;
            break;
          case TipoPonderado.PPAcumulado:
            pp = model!.ciclos[i].ppa;
            break;
          case TipoPonderado.PPAcumuladoAprobado:
            pp = model!.ciclos[i].ppaAprob;
            break;
        }
        puntos.add(FlSpot(contador, pp));
        contador++;
      }
    }
    return puntos;
  }
}

enum TipoPonderado {
  PPSemestral,
  PPSemestralAprobado,
  PPAcumulado,
  PPAcumuladoAprobado,
}
