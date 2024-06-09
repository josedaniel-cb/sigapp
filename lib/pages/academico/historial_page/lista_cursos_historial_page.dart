import 'package:flutter/material.dart';
import 'package:sigapp/app/app.dart';
// import 'package:sigapp/models/curso_model/curso_model.dart';
import 'package:sigapp/models/historial_model.dart';
import 'package:sigapp/widgets/lista_cursos_widget/curso_widget.dart';
import 'package:sigapp/widgets/lista_cursos_widget/lista_cursos_widget.dart';

class ListaCursosHistorialPage extends StatelessWidget {
  // final String title;
  // final List<CursoModel> cursos;
  final CicloHistorialModel ciclo;

  const ListaCursosHistorialPage({super.key, 
    required this.ciclo,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ciclo.etiqueta!),
      ),
      body: ListaCursosWidget(
        leyenda: ciclo.matrizInformacion != null ? _buildCabecera() : null,
        cursos: List.generate(ciclo.cursos.length, (int i) {
          return CursoWidget(
            cursoModel: ciclo.cursos[i],
            index: i + 1,
          );
        }),
      ),
    );
  }

  Widget _buildCabecera() {
    const double relleno = 9;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(
            top: 2,
            bottom: 13,
            left: 5,
            right: 5,
          ),
          decoration: BoxDecoration(
              border: Border.all(
                color: App.blueColor,
                width: 2,
                style: BorderStyle.solid,
              ),
              color: Colors.white),
          padding: const EdgeInsets.only(
              top: relleno + 3,
              left: relleno,
              right: relleno,
              bottom: relleno * 0.3),
          child: Column(
            children: <Widget>[
              _buildInfo(
                titulo: 'Promedio Ponderado',
                datos: <Dupla>[
                  Dupla('Semestral (PPS)', ciclo.pps.toString(),
                      destacar: true),
                  Dupla('Acumulado (PPA)', ciclo.ppa.toString(),
                      destacar: true),
                  Dupla('Semestral Aprobado', ciclo.ppsAprob.toString()),
                  Dupla('Acumulado Aprobado', ciclo.ppaAprob.toString()),
                ],
              ),
              _buildInfo(
                titulo: 'Créditos en el semestre',
                datos: <Dupla>[
                  Dupla('Obligatorios llevados', ciclo.creOblLlev.toString()),
                  Dupla('Obligatorios aprobados', ciclo.creOblApr.toString(),
                      destacar: true),
                  Dupla(
                      'Obligatorios convalidados', ciclo.creOblConv.toString()),
                  Dupla('Electivos llevados', ciclo.creElLlev.toString()),
                  Dupla('Electivos aprobados', ciclo.creElApr.toString(),
                      destacar: true),
                  Dupla('Electivos convalidados', ciclo.creElConv.toString()),
                ],
              ),
              _buildInfo(
                titulo: 'Total créditos',
                datos: <Dupla>[
                  Dupla('Obligatorios llevados',
                      ciclo.totalCredOblLlev.toString()),
                  Dupla('Obligatorios aprobados',
                      ciclo.totalCredOblAprob.toString(),
                      destacar: true),
                  Dupla('Obligatorios convalidados',
                      ciclo.totalCredOblConv.toString()),
                  Dupla('Electivos llevados', ciclo.totalCredElLlev.toString()),
                  Dupla(
                      'Electivos aprobados', ciclo.totalCredElAprob.toString(),
                      destacar: true),
                ],
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 4),
          child: Text('Total cursos:\t${ciclo.cursos.length}'),
        ),
      ],
    );
  }

  Widget _buildInfo({required String titulo, required List<Dupla> datos}) {
    const double margen = 5;
    return Container(
      margin: const EdgeInsets.only(
        bottom: margen * 2,
        left: margen,
        right: margen,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            titulo,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              // color: App.blueColor,
              color: Colors.blueGrey,
            ),
          ),
          Divider(
            // color: Colors.black26,
            color: App.blueColor,
            height: 17,
            thickness: 1.5,
          ),
          Column(
            children: List.generate(datos.length, (int i) {
              return _buildInfoDupla(datos[i]);
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoDupla(Dupla dupla) {
    TextStyle style;

    if (dupla.destacar) {
      style = const TextStyle(fontWeight: FontWeight.bold);
    } else {
      style = const TextStyle();
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 3),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              dupla.etiqueta,
              style: style,
            ),
          ),
          Text(
            dupla.contenido,
            style: style,
          ),
        ],
      ),
    );
  }
}

class Dupla {
  final String etiqueta;
  final String contenido;
  final bool destacar;

  Dupla(this.etiqueta, this.contenido, {this.destacar = false});
}
