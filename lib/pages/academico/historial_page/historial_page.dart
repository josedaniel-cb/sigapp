import 'package:SIGApp/app/urls.dart';
import 'package:SIGApp/browser/gestor_firebase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:SIGApp/app/app.dart';
import 'package:SIGApp/blocs/historial_bloc/bloc.dart';
import 'package:SIGApp/models/historial_model.dart';
import 'package:SIGApp/widgets/charts/historial_ppa_chart.dart';
import 'package:SIGApp/widgets/lista_semestres_widget.dart';
import 'package:SIGApp/widgets/simple_loading_body_widget.dart';

import 'lista_cursos_historial_page.dart';

class HistorialPage extends StatefulWidget{
  @override
  State<HistorialPage> createState() => HistorialPageState();
}

class HistorialPageState extends State<HistorialPage>{
  HistorialBloc? _bloc;
  TipoPonderado? _tipoPonderado;
  // int _groupValue;

  @override
  void initState() {
    super.initState();
    _tipoPonderado = TipoPonderado.PPSemestral;
    // _groupValue = 0;
    _bloc = BlocProvider.of<HistorialBloc>(context);
    App.browserController.historialBloc = _bloc;
    App.browserController.historialSolicitarHistorialAcademico();
  }

  @override
  void dispose() {
    _bloc!.close();
    App.browserController.solicitudActiva = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistorialBloc, HistorialState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Historial académico'),
          ),
          body: state is Ready ? _buildHistorial() : SimpleLoadingBodyWidget(),
        );
      },
    );
  }

  Widget _buildHistorial(){
    return ListaSemestresWidget(
      leyenda: _bloc!.modelo!.ciclos.length > 0 ?_buildCabecera() : null,
      icono: Icon(
        Icons.assessment,
        color: Colors.green,
      ),
      // nadaQueMostrarMensaje: 'No se encontró información en la web. '
      //   'Probablemente los datos del sistema se encuentran en mantenimiento.',
      nadaQueMostrarMensaje: 'La web del Siga no dispone de tus datos en este momento. '
        'Puedes comprobarlo visitando ${Urls.LOGIN}',
      children: List.generate(_bloc!.modelo!.ciclos.length, (int i){
        return ElementoListaSemestresWidget(
          numero: _bloc!.modelo!.ciclos[i].cursos.length,
          onPressed: () => _lanzarCicloPage(i),
          // titulo: _bloc.modelo.ciclos[i].etiqueta,
          titulo: _customizarCicloEtiqueta(_bloc!.modelo!.ciclos[i].etiqueta!),
        );
      }),
    );
  }

  String _customizarCicloEtiqueta(String etiqueta){
    // Finalidad: Pasar de "Semestre: 2019-0" a "Veranito: 2019-0"
    if(!etiqueta.endsWith('0')){
      return etiqueta;
    } else {
      return 'Veranito:\t\t' + etiqueta.substring(etiqueta.length - 6, etiqueta.length);
    }
  }

  Widget _buildCabecera(){
    double margen = 13;
    return 
    Container(
      margin: EdgeInsets.only(
        bottom: margen*0.6,
        left: margen,
        right: margen,
        top: margen,
      ),
      child: Column(
        children: <Widget>[
          _buildMenu(),
          HistorialPPAChart(_bloc!.modelo, _tipoPonderado),
        ],
      ),
    )
    ;
  }

  Widget _buildMenu(){
    String? labelPP, semestrePrimero, semestreUltimo;

    switch(_tipoPonderado){
      case TipoPonderado.PPSemestral:
        labelPP = CicloHistorialModel.PPS;
        break;
      case TipoPonderado.PPSemestralAprobado:
        labelPP = CicloHistorialModel.PPS_Aprob;
        break;
      case TipoPonderado.PPAcumulado:
        labelPP = CicloHistorialModel.PPA;
        break;
      case TipoPonderado.PPAcumuladoAprobado:
        labelPP = CicloHistorialModel.PPA_Aprob;
        break;
    }

    semestrePrimero = _bloc!.modelo!.ciclosRegulares[0].etiqueta!.split(':')[1].trim();
    semestreUltimo = _bloc!.modelo!.ciclosRegulares[_bloc!.modelo!.ciclosRegulares.length - 1].etiqueta!.split(':')[1].trim();

    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              color: const Color(0xff08465E)
            ),
            // padding: EdgeInsets.all(17),
            padding: EdgeInsets.only(
              bottom: 17,
              left: 17,
              right: 17,
              top: 8,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(bottom: 5),
                        child: Text(
                          'Estadísticas',
                          // 'Un vistazo a',
                          style: TextStyle(
                            color: const Color(0xffCADEE8),
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      // color: Colors.red,
                      child: _buildSeleccionPPButton(),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 5),
                  child: Text(
                    '$labelPP\nDesde $semestrePrimero hasta $semestreUltimo',
                    style: TextStyle(
                      color: const Color(0xffCADEE8),
                      // fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),          
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSeleccionPPButton(){
    List<String> criterios = const[
      'PPS',
      'PPS Aprob.',
      'PPA',
      'PPA Aprob.',
    ];
    return PopupMenuButton<int>(
      icon: Icon(
        Icons.arrow_drop_down,
        color: Colors.white,
      ),
      onSelected: _handleValueChange,
      itemBuilder: (BuildContext context){
        return List.generate(criterios.length, (int i){
          return PopupMenuItem<int>(
            value: i,
            child: Text(criterios[i]),
          );
        });
      },
    );
  }

  // Widget _buildRadioButton(int value, String label){
  //   return Container(
  //     // color: Colors.red,
  //     child: Row(
  //       mainAxisSize: MainAxisSize.min,
  //       children: <Widget>[        
  //         Radio(          
  //           value: value,
  //           groupValue: _groupValue,
  //           onChanged: _handleValueChange,
  //         ),
  //         Text(
  //           label, 
  //           // style: TextStyle(backgroundColor: Colors.white),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  void _handleValueChange(int value){
    App.browserController.gestorFirebase.registrarUso(CasosDeUso.HistorialCambiarGrafico);
    setState(() {
      // _groupValue = value;
      switch(value){
        case 0:
          _tipoPonderado = TipoPonderado.PPSemestral;
          break;
        case 1:
          _tipoPonderado = TipoPonderado.PPSemestralAprobado;
          break;
        case 2:
          _tipoPonderado = TipoPonderado.PPAcumulado;
          break;
        case 3:
          _tipoPonderado = TipoPonderado.PPAcumuladoAprobado;
          break;
      }
    });
  }

  void _lanzarCicloPage(int index){
    App.browserController.gestorFirebase.registrarUso(CasosDeUso.HistorialSeleccionarSemestre);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ListaCursosHistorialPage(
          ciclo: _bloc!.modelo!.ciclos[index],
        )
      ),
    );
  }
}

class LinearPPA{
  final int semestreIndex;
  final double ppa;

  LinearPPA(this.semestreIndex, this.ppa);
}

