import 'dart:async';

import 'package:SIGApp/app/urls.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:SIGApp/app/app.dart';
import 'package:SIGApp/blocs/informe_bloc/bloc.dart';
import 'package:SIGApp/models/informe_model.dart';
import 'package:SIGApp/widgets/simple_loading_body_widget.dart';

class InformePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => InformePageState();
}

class InformePageState extends State<InformePage>{
  InformeBloc _informeBloc;

  static const double _fontSize = 15;

  final TextStyle _azulGrandeStyle = TextStyle(
    color: Color(0xFF005b96),
    fontSize: _fontSize*1.3,
    fontWeight: FontWeight.w500,
  );
  final TextStyle _normalStyle = TextStyle(
    fontSize: _fontSize,
  );
  final TextStyle _negritaStyle = TextStyle(
    fontSize: _fontSize,
    fontWeight: FontWeight.w700,
  );


  final TextStyle _defaultTextSpanStyle = TextStyle(
    color: Colors.black,
    fontFamily: 'ProductSans',
    fontSize: _fontSize*1.1,
  );
  final TextStyle _normalTextSpanStyle = TextStyle(    
  );
  final TextStyle _negritaTextSpanStyle = TextStyle(
    fontWeight: FontWeight.w700,
  );
  final TextStyle _grisTextSpanStyle = TextStyle(
    color: Colors.black54,
    fontWeight: FontWeight.w500,
  );  

  final double _margen = 10;
  
  double _credObligPorcentaje, _credElectPorcentaje, _restantePorcentaje, _credTotalPorcentaje;

  @override
  void initState() {
    super.initState();
    _informeBloc = BlocProvider.of<InformeBloc>(context);
    App.browserController.informeBloc = _informeBloc;
    App.browserController.informeSolicitarInformeAcademico();
  }

  @override
  void dispose() {
    _informeBloc.close();
    App.browserController.solicitudActiva = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Informe Académico'),
      ),
      body: BlocBuilder<InformeBloc, InformeState>(
        builder: (context, state) {
          if(state is Loading){
            return SimpleLoadingBodyWidget();
          // } else if (state is Ready){
          } else {
            // Para DEMO
            // _informeBloc.modelo.requisitos[0][1] = '166';
            // _informeBloc.modelo.requisitos[1][1] = '7';
            // _informeBloc.modelo.requisitos[2][1] = '173';
            // _informeBloc.modelo.ppUltimo = '15.8';
            // _informeBloc.modelo.ppAcumulado = '14.7';
            // _informeBloc.modelo.ppAprobado = '14.7';
            // _informeBloc.modelo.creditosAprobados = _informeBloc.modelo.requisitos[2][1];
            // _informeBloc.modelo.fechaActualizacionInforme = 'Informe actualizado hasta el semestre 2019-2';
            // Fin DEMO

            double nroCreditosTotales = double.parse(_informeBloc.modelo.requisitos[2][0]);
            _credObligPorcentaje = double.parse(_informeBloc.modelo.requisitos[0][1]) / nroCreditosTotales * 100;            
            _credElectPorcentaje = double.parse(_informeBloc.modelo.requisitos[1][1]) / nroCreditosTotales * 100;            
            _credTotalPorcentaje = double.parse(_informeBloc.modelo.requisitos[2][1]) / nroCreditosTotales * 100;
            // _credObligPorcentaje = 170 / nroCreditosTotales * 100;
            // _credElectPorcentaje = 10 / nroCreditosTotales * 100;
            // _credTotalPorcentaje = 180 / nroCreditosTotales * 100;            

            _restantePorcentaje = 100 - (_credObligPorcentaje + _credElectPorcentaje);
            // return _buildBody();
            if(_informeBloc.modelo.fechaActualizacionInforme.endsWith('-') || _restantePorcentaje == 100){
              int duracionToastSeg = 2; 
              App.showToast('La web del Siga no dispone de tus datos en este momento', duracionSegundos: duracionToastSeg);
              Timer(Duration(milliseconds: duracionToastSeg*1000 + 500, ), (){
                App.showToast('Puedes comprobarlo visitando ${Urls.LOGIN}', duracionSegundos: duracionToastSeg);
              });
            }

            return BounceInUp(
              child: _buildBody(),
            );
          }
        },
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _buildAlumno(),
            _buildDivisor(),
            _buildInforme(),
            _buildDivisor(),
            _buildRequisitosCreditos(),
            _buildGrafico(),
          ],
        ),
      ),
    );
  }

  Widget _buildAlumno() {
    List<String> codigoNombres = _informeBloc.modelo.alumno.split('-');
    String codigo = codigoNombres[0].trim();
    String nombresApellidos = codigoNombres[1].trim();

    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 4),
            child: Text(
              codigo,
              style: _azulGrandeStyle,
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 12),
            child: Text(
              nombresApellidos,
              style: _azulGrandeStyle,
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: _margen),
            child: RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                style: _defaultTextSpanStyle,
                children: <TextSpan>[
                  TextSpan(
                    text: "Alumno de la Facultad de ",
                    style: _normalTextSpanStyle,
                  ),
                  TextSpan(
                    text: _informeBloc.modelo.facultad,
                    style: _negritaTextSpanStyle,
                  ),
                  TextSpan(
                    text: "de la Universidad Nacional de Piura",
                    style: _normalTextSpanStyle,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivisor() {
    return Divider(
      color: Colors.black87,
      height: 0.6,
    );
  }

  Widget _buildInforme() {
    return Container(
      margin: EdgeInsets.only(top: _margen),
      child: Column(
        children: List.generate(InformeModel.titulos.length, (int i) {
          return Row(children: [
            Flexible(
              flex: 4,
              fit: FlexFit.tight,
              child: Container(
                //color: Colors.cyanAccent,
                margin: EdgeInsets.only(bottom: _margen, right: 20),
                child: _descripcionItemInfo(i),
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                //color: Colors.greenAccent,
                margin: EdgeInsets.only(bottom: _margen),
                child: Text(
                  _informeBloc.modelo.contenidoAt(i),
                  style: _negritaStyle,
                  textAlign: TextAlign.left,
                  maxLines: 1,
                  overflow: TextOverflow.clip,
                ),
              ),
            ),
          ]);
        }),
      ),
    );
  }

  Widget _descripcionItemInfo(int i) {
    String text1, text2, text3;
    switch (i) {
      case 0:
        text1 = "";
        text2 = "Ingresó";
        text3 = " a la Universidad Nacional de Piura en el semetre:";
        break;
      case 1:
        text1 = "Pertenece a la ";
        text2 = "promoción";
        text3 = ":";
        break;
      case 2:
        text1 = "Su ";
        text2 = "Plan de Estudios";
        text3 = " correspondiente es:";
        break;
      case 3:
        text1 = "Su último ";
        text2 = "Promedio Semestral";
        text3 = " es:";
        break;
      case 4:
        text1 = "Su ";
        text2 = "Promedio Ponderado Acumulado";
        text3 = " es:";
        break;
      case 5:
        text1 = "Su ";
        text2 = "Promedio Ponderado Aprobado";
        text3 = " es:";
        break;
      case 6:
        text1 = "La cantidad de ";
        text2 = "créditos aprobados";
        text3 = " en su historial académico es:";
        break;
    }
    return RichText(
      textAlign: TextAlign.left,
      text: TextSpan(
        style: _defaultTextSpanStyle,
        children: <TextSpan>[
          TextSpan(
            text: text1,
            style: _normalTextSpanStyle,
          ),
          TextSpan(
            text: text2,
            style: _negritaTextSpanStyle,
          ),
          TextSpan(
            text: text3,
            style: _normalTextSpanStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildRequisitosCreditos() {
    return Container(
      margin: EdgeInsets.only(top: _margen),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Flexible(
                fit: FlexFit.tight,
                child: Container(
                  child: Text(
                    // "Debe cumplir los siguientes requisitos de graduación:",
                    'Número de créditos aprobados requeridos para graduación:',
                    style: _normalStyle,
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
            ],
          ),
          _buildItemRequisitos(
            // "Número de créditos obligatorios:",
            "Créditos obligatorios",
            _informeBloc.modelo.requisitos[0][0],
            _informeBloc.modelo.requisitos[0][1],
            _informeBloc.modelo.requisitos[0][2],
          ),
          _buildItemRequisitos(
            "Créditos electivos",
            _informeBloc.modelo.requisitos[1][0],
            _informeBloc.modelo.requisitos[1][1],
            _informeBloc.modelo.requisitos[1][2],
          ),
          _buildItemRequisitos(
            "Total",
            _informeBloc.modelo.requisitos[2][0],
            _informeBloc.modelo.requisitos[2][1],
            _informeBloc.modelo.requisitos[2][2],
          ),
        ],
      ),
    );
  }

  Widget _buildItemRequisitos(String concepto, String n1, String n2, String n3) {
    return Container(
      margin: EdgeInsets.only(
        top: _margen,
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Flexible(
                flex: 5,
                fit: FlexFit.tight,
                child: Container(
                  //color: Colors.cyanAccent,
                  child: Text(
                    '✅\t' + concepto,
                    style: _negritaStyle,
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: Container(
                  //color: Colors.indigoAccent,
                  child: Text(
                    // n1.toString(),
                    '$n2 de $n1',
                    style: _negritaStyle,
                    // style: _normalStyle,
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGrafico(){
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // _buildChart(),
              // _buildLeyenda(),              
              // Expanded(
              //   child: _buildLeyenda(),
              // ),
              Flexible(child: _buildChart(), flex: 1,),
              Flexible(child: _buildLeyenda(), flex: 1,),
            ],
          ),
          Container(
            // color: Colors.green,
            margin: EdgeInsets.only(top: 10),
            child: Text(              
              _informeBloc.modelo.fechaActualizacionInforme.endsWith('-') ?
                _informeBloc.modelo.fechaActualizacionInforme + ' ¿?' :
                _informeBloc.modelo.fechaActualizacionInforme,
              // style: _normalStyle,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 13,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChart() {
    double longitud = (MediaQuery.of(context).size.width - _margen * 2) / 2;
  
    return Container(
      margin: EdgeInsets.only(top: _margen),
      child: SizedBox(
        width: longitud,
        height: longitud,
        child: PieChart(
          PieChartData(
            sectionsSpace: 0,
            centerSpaceRadius: longitud / 2,
            sections: [
              PieChartSectionData(
                color: Colors.blueAccent,
                value: _credObligPorcentaje,
                title: '${(_credObligPorcentaje).toStringAsFixed(1)}%',
              ),
              PieChartSectionData(
                color: Colors.cyan,
                value: _credElectPorcentaje,
                title: '${(_credElectPorcentaje).toStringAsFixed(1)}%',
              ),
              PieChartSectionData(
                color: Color(0x1A000000),
                value: _restantePorcentaje,
                title: '${(_restantePorcentaje).toStringAsFixed(1)}%',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLeyenda(){
    return Container(
      // color: Colors.brown,
      // margin: EdgeInsets.only(left: _margen),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _buildLeyendaItem(Colors.blueAccent, "Obligatorios\t${_credObligPorcentaje.toStringAsFixed(2)}%"),
          _buildLeyendaItem(Colors.cyan, "Electivos\t${_credElectPorcentaje.toStringAsFixed(2)}%"),
          _buildLeyendaItem(Color(0x1A000000), "Restante\t${_restantePorcentaje.toStringAsFixed(2)}%"),
        ],
      ),
    );
  }

  // Widget _buildLeyendaItem(Color color, String nombre){
  //   return Container(
  //     child: Wrap(
  //       spacing: _margen*0.8,
  //       children: <Widget>[
  //         Container(
  //           margin: EdgeInsets.only(top: 4),
  //           height: 10,
  //           width: 10,
  //           color: color,
  //         ),
  //         Text(nombre),
  //         // Flexible(child: Text(nombre)),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildLeyendaItem(Color color, String nombre){
    return Container(
      child: Wrap(
        // crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 4, right: 5, bottom: 2),
            height: 10,
            width: 10,
            color: color,
          ),
          Text(
            nombre,
          ),
        ],
      ),
    );
  }
}

