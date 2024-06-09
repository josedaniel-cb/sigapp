import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:sigapp/app/app.dart';
import 'package:sigapp/models/notas_model.dart';
import 'package:sigapp/widgets/nada_que_mostrar_widget.dart';

class NotasPage extends StatelessWidget {
  final NotasModel? model;

  const NotasPage(this.model, {super.key});

  final double _margen = 20;
  final double _tamFuente = 13;
  final Color _colorAzulFondo = const Color(0xFFEDF4FA);
  // final Color _colorAzulTexto = Color(0xFF7DB4D8);
  final Color _colorAzulTexto = Colors.blue;
  final Color _colorNegro = Colors.black87;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text('REGEVA'),
      ),
      body: model!.error == null
          ? _buildBody()
          : NadaQueMostrarWidget(
              mensaje: model!.error,
            ),
    );
  }

  Widget _buildBody() {
    return Container(
      color: Colors.white,
      child: Scrollbar(
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(_margen),
              child: Column(
                children: <Widget>[
                  _buildCurso(),
                  // _buildNotas(),
                  FadeIn(
                    child: _buildNotas(),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCurso() {
    return Container(
      // color: Colors.red,
      // margin: EdgeInsets.symmetric(vertical: _margen),
      margin: EdgeInsets.only(bottom: _margen),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
              bottom: _margen,
              top: _margen * .5,
            ),
            // color: Colors.red,
            child: Text(
              model!.curso!.nombre,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: _colorNegro,
                fontSize: _tamFuente * 1.7,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Row(
          //   children: <Widget>[
          //     Expanded(
          //       child: _buildCursoCaracteristica(0),
          //     )
          //   ],
          // ),
          _buildCursoCaracteristica(0),
          Wrap(
            // tambi[en prueba] con Row Spacebetween
            // direction: AxisD,
            spacing: _margen,
            children: <Widget>[
              _buildCursoCaracteristica(1),
              _buildCursoCaracteristica(2),
              _buildCursoCaracteristica(3),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildCursoCaracteristica(int indexCaracteristicaCurso) {
    return _buildCaracteristica(
      texto: model!.curso!.caracteristicas[indexCaracteristicaCurso].nombre,
      contenido: Text(
        model!.curso!.caracteristicas[indexCaracteristicaCurso].contenido,
        style: TextStyle(
          color: _colorAzulTexto,
          fontSize: _tamFuente,
        ),
      ),
    );
  }

  Widget _buildNotas() {
    return Container(
      // margin: EdgeInsets.symmetric(vertical: _margen),
      // margin: EdgeInsets.only(bottom: _margen),
      decoration: BoxDecoration(
        border: Border.all(
          color: App.blueColor,
          width: 2,
          style: BorderStyle.solid,
        ),
      ),
      child: Column(
        children: List.generate(model!.criterios.length,
            (int indexCriterio) => _buildCriterio(indexCriterio))
          ..add(_buildNotaFinal()),
      ),
    );
  }

  Widget _buildCriterio(int indexCriterio) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _buildCabecera(indexCriterio),
        Container(
          padding: EdgeInsets.all(_margen * .8),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
                model!.criterios[indexCriterio].examenes.length,
                (int indexExamen) => _buildExamen(indexCriterio, indexExamen))
              ..insert(
                0,
                // Text(
                //   '${model.criterios[indexCriterio].mensaje}',
                //   style: TextStyle(
                //     fontSize: _tamFuente * 1.1,
                //   ),
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        model!.criterios[indexCriterio].mensaje,
                        style: TextStyle(
                          fontSize: _tamFuente * 1.1,
                        ),
                      ),
                    )
                  ],
                ),
              ),
          ),
        ),
      ],
    );
  }

  Widget _buildCabecera(int indexCriterio) {
    return Container(
      // color: Colors.greenAccent,
      color: _colorAzulFondo,
      padding: EdgeInsets.all(_margen * 0.5),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              model!.criterios[indexCriterio].titulo,
              style: TextStyle(
                color: App.blueColor,
                fontSize: _tamFuente,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.start,
            ),
          ),
          _buildInfoTipo1(
              color: Colors.green,
              texto: '${model!.criterios[indexCriterio].notaPromedio}'),
          // SizedBox(width: _margen*0.3,),
          _buildInfoTipo3(
              color: Colors.blueGrey,
              texto: '${model!.criterios[indexCriterio].porcentaje} %'),
        ],
      ),
    );
  }

  Widget _buildInfo({
    required Color color,
    required String texto,
    required BoxDecoration decoration,
    double? fontSize,
  }) {
    return Container(
      decoration: decoration,
      padding: const EdgeInsets.all(4),
      // margin: EdgeInsets.only(left: 10),
      child: Text(
        texto,
        style: TextStyle(
          color: Colors.white,
          fontSize: fontSize ?? _tamFuente * 0.85,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildInfoTipo1({required Color color, required String texto}) {
    // double x = 25;
    // double y = 15;
    return _buildInfo(
      color: color,
      texto: texto,
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          bottomLeft: Radius.circular(20.0),
          // topLeft: Radius.elliptical(x, y),
          // bottomLeft: Radius.elliptical(x, y),
        ),
      ),
    );
  }

  Widget _buildInfoTipo3({required Color color, required String texto}) {
    return _buildInfo(
      color: color,
      texto: texto,
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
      ),
    );
  }

  Widget _buildCaracteristica({
    required String texto,
    required Widget contenido,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      // crossAxisAlignment: CrossAxisAlignment.baseline,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '$texto:',
          style: TextStyle(
            color: _colorNegro,
            fontSize: _tamFuente,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          width: _margen * 0.3,
        ),
        // contenido,
        Flexible(child: contenido),
      ],
    );
  }

  Widget _buildExamen(int indexCriterio, int indexExamen) {
    Color colorNota;
    String mensajeFechaRegistro;

    if (model!.criterios[indexCriterio].examenes[indexExamen].fechaRegistro !=
        null) {
      if (model!.criterios[indexCriterio].examenes[indexExamen].nota >= 11) {
        colorNota = Colors.green;
      } else {
        colorNota = Colors.red;
      }
    } else {
      colorNota = Colors.grey;
    }

    if (model!.criterios[indexCriterio].examenes[indexExamen].fechaRegistro !=
        null) {
      mensajeFechaRegistro =
          '📌 Registrado en ${model!.criterios[indexCriterio].examenes[indexExamen].fechaRegistro}';
    } else {
      mensajeFechaRegistro = '⏳ No se ha registrado';
    }

    return Container(
      // color: Colors.black12,
      margin: EdgeInsets.only(
          // left: _margen,
          // right: _margen,
          // bottom: _margen,
          top: _margen * .8),
      child: Wrap(
        spacing: _margen * 0.8,
        runSpacing: _margen * 0.2,
        children: <Widget>[
          _buildCaracteristica(
            texto: 'Fecha',
            contenido: _buildInfoTipo2(
              texto:
                  model!.criterios[indexCriterio].examenes[indexExamen].fechaExamen,
              // color: App.blueColor,
              color: Colors.black26,
            ),
          ),
          _buildCaracteristica(
            texto: 'Nota',
            contenido: _buildInfoTipo2(
              texto:
                  '${model!.criterios[indexCriterio].examenes[indexExamen].nota}', // .toStringAsFixed(2)
              color: colorNota,
            ),
          ),
          Text(
            mensajeFechaRegistro,
            style: TextStyle(
              fontWeight: FontWeight.w100,
              fontSize: _tamFuente * 0.94,
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildInfoTipo2({
    required Color color,
    required String texto,
    double? fontSize,
  }) {
    return _buildInfo(
      color: color,
      texto: texto,
      fontSize: fontSize,
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
    );
  }

  Widget _buildNotaFinal() {
    double margenEspaciado = 8;
    List<Widget> contenido = [
      _buildCaracteristicaNotaFinal(
        // label: 'Nota final',
        label: model!.notaFinalLabel,
        nota: model!.notaFinal,
        // labelColor: Colors.white,
      ),
      // SizedBox(height: margenEspaciado,),
      // _buildInfoTipo2(
      //   texto: model.estadoLabel,
      //   // texto: ' ${model.notaLabel} ',
      //   color: model.estadoLabel == 'Aprobado' ? Colors.green : Colors.red,
      //   fontSize: _tamFuente,
      // ),
    ];

    if (model!.estadoLabel != null) {
      contenido.addAll([
        SizedBox(
          height: margenEspaciado,
        ),
        _buildInfoTipo2(
          texto: model!.estadoLabel!,
          // texto: ' ${model.notaLabel} ',
          color: model!.estadoLabel == 'Aprobado' ? Colors.green : Colors.red,
          fontSize: _tamFuente,
        ),
      ]);
    }

    if (model!.notaSustitutorio != null) {
      contenido.insert(
          0,
          Column(
            children: <Widget>[
              _buildCaracteristicaNotaFinal(
                label: 'Nota sustitutorio',
                nota: model!.notaSustitutorio,
                fontSize: _tamFuente,
                // labelColor: Colors.white,
              ),
              SizedBox(
                height: margenEspaciado,
              ),
            ],
          ));
    }

    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            // color: Colors.black12,
            // color: App.blueColor,
            color: _colorAzulFondo,
            padding: EdgeInsets.all(_margen),
            child: Column(
              children: contenido,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCaracteristicaNotaFinal({
    required String? label,
    required double? nota,
    double? fontSize,
    Color labelColor = Colors.black,
  }) {
    fontSize ??= _tamFuente;
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            '$label:\t',
            style: TextStyle(
              color: labelColor,
              // color: Colors.white,
              fontSize: fontSize * 1.3,
              fontWeight: FontWeight.bold,
            ),
          ),
          _buildInfoTipo2(
            texto: '$nota',
            color: model!.notaFinal! >= 11 ? Colors.green : Colors.red,
            fontSize: fontSize,
          )
        ],
      ),
    );
  }
}
