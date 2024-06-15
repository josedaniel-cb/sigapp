import 'package:sigapp/widgets/sigapp_info/sigapp_logotipo_widget.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:sigapp/app/app.dart';
import 'package:sigapp/models/horario_model/horario_model.dart';

import '../nada_que_mostrar_widget.dart';
import 'curso_horario_widget.dart';

class HorarioWidget extends StatelessWidget {
  final HorarioModel? horarioModel;
  final String semestre;
  final ScreenshotController _screenshotController;

  const HorarioWidget(
    this.horarioModel,
    this._screenshotController,
    this.semestre, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return horarioModel!.filas.isNotEmpty
        ? FadeInRight(child: _buildHorario())
        : const NadaQueMostrarWidget();
  }

  Widget _buildHorario() {
    double altura, ancho, alturaAdicionalTexto;

    alturaAdicionalTexto = 33;
    altura =
        (HorarioWidgetConsts.cursoHeight + HorarioWidgetConsts.margen * 2) *
                (horarioModel!
                    .filas.length) + //longitud altura de casilleros normales
            (HorarioWidgetConsts.tituloHeight +
                HorarioWidgetConsts.margen *
                    2) + //longitud altura de casilleros titulo
            alturaAdicionalTexto + // altura de titulo
            HorarioWidgetConsts.margen * 2; //margen vertical
    ancho = (HorarioWidgetConsts.cursoWidth + HorarioWidgetConsts.margen * 2) *
            (horarioModel!.filas[0].cursos.length) + //longitud ancho de cursos
        (HorarioWidgetConsts.horasWidth +
            HorarioWidgetConsts.margen *
                2) + //longitud ancho de casilleros hora
        HorarioWidgetConsts.margen * 2; //margen horizontal

    return Container(
      // height: altura,
      // width: ancho,
      // height: 100,
      // width: 200,
      // color: Colors.amber,
      child: InteractiveViewer(
        // boundaryMargin: const EdgeInsets.all(20.0),
        minScale: 0.5,
        maxScale: 2.0,
        constrained: false,
        child: SizedBox(
          // height: altura,
          // width: ancho,
          child: Screenshot(
            controller: _screenshotController,
            child: Container(
              color: Colors.white,
              height: altura,
              width: ancho,
              padding: const EdgeInsets.all(HorarioWidgetConsts.margen),
              child: Column(
                children: <Widget>[
                  _buildTitulosSuperiores(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                      horarioModel!.filas.length,
                      (int i) {
                        return Row(
                          children: List.generate(
                              horarioModel!.filas[i].cursos.length, (int j) {
                            return CursoHorarioWidget(
                                horarioModel!.filas[i].cursos[j]);
                          })
                            ..insert(
                              0,
                              _buildCasilleroTitulo(
                                text:
                                    "${horarioModel!.filas[i].inicio.toString()}\n▫\n${horarioModel!.filas[i].fin.toString()}",
                                height: HorarioWidgetConsts.cursoHeight,
                                width: HorarioWidgetConsts.horasWidth,
                                color: Colors.grey,
                              ),
                            ),
                        );
                      },
                    ),
                  ),
                  _buildInfo(alturaAdicionalTexto),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitulosSuperiores() {
    Color azulito = const Color.fromRGBO(37, 142, 232, 1);

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        _buildCasilleroTitulo(
          // text: "Horas",
          text: "🕒",
          height: HorarioWidgetConsts.tituloHeight,
          width: HorarioWidgetConsts.horasWidth,
          color: azulito,
        ),
        _buildCasilleroTitulo(
          text: "Lunes",
          height: HorarioWidgetConsts.tituloHeight,
          width: HorarioWidgetConsts.cursoWidth,
          color: azulito,
        ),
        _buildCasilleroTitulo(
          text: "Martes",
          height: HorarioWidgetConsts.tituloHeight,
          width: HorarioWidgetConsts.cursoWidth,
          color: azulito,
        ),
        _buildCasilleroTitulo(
          text: "Miercoles",
          height: HorarioWidgetConsts.tituloHeight,
          width: HorarioWidgetConsts.cursoWidth,
          color: azulito,
        ),
        _buildCasilleroTitulo(
          text: "Jueves",
          height: HorarioWidgetConsts.tituloHeight,
          width: HorarioWidgetConsts.cursoWidth,
          color: azulito,
        ),
        _buildCasilleroTitulo(
          text: "Viernes",
          height: HorarioWidgetConsts.tituloHeight,
          width: HorarioWidgetConsts.cursoWidth,
          color: azulito,
        ),
      ],
    );
  }

  Widget _buildCasilleroTitulo(
      {required String text, double? height, double? width, Color? color}) {
    return Container(
      padding: const EdgeInsets.all(5),
      alignment: const Alignment(0, 0),
      width: width,
      height: height,
      margin: const EdgeInsets.all(HorarioWidgetConsts.margen),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildInfo(double alturaAsignada) {
    String alumnnoNombrApell =
        App.browserController.homeBloc!.homeModel.apellidosNombres;
    double textSize = alturaAsignada - HorarioWidgetConsts.margen * 4;
    final TextStyle semestreStyle = TextStyle(
      fontSize: textSize,
      color: Colors.black,
      fontWeight: FontWeight.bold,
    );
    // final TextStyle _nombrApellStyle = TextStyle(
    //   fontSize: textSize,
    //   color: Colors.black54,
    //   fontWeight: FontWeight.bold,
    // );

    return Container(
      height: alturaAsignada - HorarioWidgetConsts.margen * 3,
      margin: const EdgeInsets.only(
        top: HorarioWidgetConsts.margen,
        bottom: HorarioWidgetConsts.margen * 2,
        left: HorarioWidgetConsts.margen * 2,
        right: HorarioWidgetConsts.margen * 2,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
              // color: Colors.red,
              height: alturaAsignada,
              alignment: Alignment.centerLeft,
              child: SigappLogotipoWidget(
                fontSize: textSize + 2,
              ),
            ),
          ),
          SizedBox(
            height: alturaAsignada,
            child: Text(
              "$alumnnoNombrApell | $semestre",
              style: semestreStyle,
            ),
          ),
        ],
      ),
    );
  }

  void _print(Object mensaje) {
    print("HorarioWidget: $mensaje");
  }
}

class HorarioWidgetConsts {
  static const double cursoHeight = 100;
  static const double cursoWidth = 120;
  static const double cursoTitleHeight = 30;
  // static const double cursoHourWidth = 60;
  static const double margen = 4;

  static const double tituloHeight = cursoHeight * 0.3;

  static const double horasWidth = cursoWidth * 0.7;
}
