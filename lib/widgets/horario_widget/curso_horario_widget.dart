import 'package:flutter/cupertino.dart';
import 'package:sigapp/models/horario_model/casillero_horario.dart';
import 'package:sigapp/models/horario_model/curso_horario.dart';

import 'horario_widget.dart';

class CursoHorarioWidget extends StatelessWidget {
  final CasilleroHorario casilleroHorario;

  const CursoHorarioWidget(this.casilleroHorario, {super.key});

  @override
  Widget build(BuildContext context) {
    // _print('Construyendo CasilleroWidget con ' + (casilleroHorario.curso2 == null ? 1.toString() : 2.toString()) + 'cursos');
    return casilleroHorario.curso2 == null ? _buildSingle() : _buildDouble();
  }

  Widget _buildSingle() {
    return _buildCurso(
      curso: casilleroHorario.curso1,
      borderRadius: BorderRadius.circular(8),
      height: HorarioWidgetConsts.cursoHeight,
      width: HorarioWidgetConsts.cursoWidth,
      margin: const EdgeInsets.all(HorarioWidgetConsts.margen),
      maxLinesCurso: 3,
      maxLinesAula: 1,
    );
  }

  Widget _buildDouble() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _buildCurso(
          curso: casilleroHorario.curso1,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
          height: HorarioWidgetConsts.cursoHeight / 2,
          width: HorarioWidgetConsts.cursoWidth,
          margin: const EdgeInsets.only(
            top: HorarioWidgetConsts.margen,
            left: HorarioWidgetConsts.margen,
            right: HorarioWidgetConsts.margen,
          ),
          maxLinesCurso: 1,
          maxLinesAula: 1,
        ),
        _buildCurso(
          curso: casilleroHorario.curso2,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(8),
            bottomRight: Radius.circular(8),
          ),
          height: HorarioWidgetConsts.cursoHeight / 2,
          width: HorarioWidgetConsts.cursoWidth,
          margin: const EdgeInsets.only(
            bottom: HorarioWidgetConsts.margen,
            left: HorarioWidgetConsts.margen,
            right: HorarioWidgetConsts.margen,
          ),
          maxLinesCurso: 1,
          maxLinesAula: 1,
        )
      ],
    );
  }

  Widget _buildCurso({
    required EdgeInsetsGeometry margin,
    required BorderRadiusGeometry borderRadius,
    required double width,
    required double height,
    required CursoHorario? curso,
    required int maxLinesCurso,
    required int maxLinesAula,
  }) {
    double fs = 12;
    return Container(
      padding: const EdgeInsets.all(5),
      alignment: const Alignment(0, 0),
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        color: curso != null
            ? curso.colorFondo
            : const Color.fromRGBO(0, 0, 0, .1),
        borderRadius: borderRadius,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            curso != null ? curso.curso : '',
            overflow: TextOverflow.ellipsis,
            maxLines: maxLinesCurso,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: curso != null
                  ? curso.colorTexto
                  : const Color.fromRGBO(0, 0, 0, .1),
              fontWeight: FontWeight.w600,
              fontSize: fs,
            ),
          ),
          Text(
            curso != null ? curso.aula : '',
            overflow: TextOverflow.ellipsis,
            maxLines: maxLinesAula,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: curso != null
                  ? curso.colorTexto
                  : const Color.fromRGBO(0, 0, 0, .1),
              fontWeight: FontWeight.w600,
              fontSize: fs,
            ),
          )
        ],
      ),
    );
  }

  void _print(Object mensaje) {
    print('CasilleroWidget: $mensaje');
  }
}
