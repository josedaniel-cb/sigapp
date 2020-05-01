import 'package:SIGApp/browser/gestor_firebase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screenshot/screenshot.dart';
import 'package:SIGApp/app/app.dart';
import 'package:SIGApp/blocs/horario_bloc/bloc.dart';
import 'package:SIGApp/widgets/horario_widget/horario_widget.dart';

class HorarioPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HorarioPageState();
  }
}

class HorarioPageState extends State<StatefulWidget> {
  final ScreenshotController _screenshotController = ScreenshotController(); 
  HorarioBloc _horarioBloc;

  @override
  void initState() {
    super.initState();
    _horarioBloc = BlocProvider.of<HorarioBloc>(context);
    App.browserController.horarioBloc = _horarioBloc;
    App.browserController.horarioSolicitarHorario();
  }

  @override
  void dispose() {
    _horarioBloc.close();
    App.browserController.solicitudActiva = false;
    super.dispose();
  }

  void _print(String mensaje) {
    print("HorarioPage: $mensaje");
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HorarioBloc, HorarioState>(
      builder: (context, state) {        
        if(state is HorarioLoading){
          return _buildLoadingState();
        } else {
          return _buildHorarioState();
        }
      },
    );
  }

  Widget _buildLoadingState(){
    return Scaffold(
      appBar: AppBar(
        title: Text("Horario de clases"),
      ),
      body: _buildLoading(),
    );
  }

  Widget _buildLoading() {
    return Center(
      child: SizedBox(
        width: 30.0,
        height: 30.0,
        child: CircularProgressIndicator(
          strokeWidth: 3,
        ),
      ),
    );
  }

  Widget _buildHorarioState(){
    return Scaffold(
      appBar: AppBar(
        title: Text('Horario ${_horarioBloc.semestres[_horarioBloc.selectedSemestreIndex]}'),
        actions: _buildActions(),
      ),
      body: _buildHorario(),
    );
  }

  List<Widget> _buildActions() {
    List<Widget> acciones = new List<Widget>();
    if(_horarioBloc.currentModel.filas.length > 0){
      acciones.add(_buildShareAction());
    }
    acciones.add(_buildSemestresAction());
    return acciones;
  }

  Widget _buildShareAction(){
    return IconButton(
      icon: Icon(Icons.share),
      onPressed: _compartirImagen,
    );
  }  

  Widget _buildSemestresAction(){
    return PopupMenuButton<int>(
      icon: Icon(Icons.arrow_drop_down),
      onSelected: (selectedIndex){
        _horarioBloc.add(HorarioUserChange(selectedIndex));
        App.browserController.gestorFirebase.registrarUso(CasosDeUso.HorarioSeleccionarSemestre);
      },
      itemBuilder: (BuildContext context){
        return List.generate(_horarioBloc.semestres.length, (int i){
          return PopupMenuItem<int>(
            value: i,
            child: Text(_horarioBloc.semestres[i]),
          );
        });
      },
    );
  }



  Widget _buildHorario() {
    return Column(
      children: <Widget>[
        Expanded(
          child: Container(
            // color: Colors.white,
            // color: App.greenColor,
            // color: App.greenColor,
            color: _horarioBloc.currentModel.filas.length > 0 ? App.greenColor : Colors.white,
            child: HorarioWidget(
              _horarioBloc.currentModel, 
              _screenshotController,
              _horarioBloc.semestres[_horarioBloc.selectedSemestreIndex]
            ),
          ),
        )
      ],
    );
    // return HorarioWidget(
    //   _horarioBloc.currentModel, 
    //   _screenshotController,
    //   _horarioBloc.semestres[_horarioBloc.selectedSemestreIndex]
    // );
  }

  void _compartirImagen(){    
    App.browserController.gestorFirebase.registrarUso(CasosDeUso.HorarioCompartir);
    App.compartirCaptura(
      _screenshotController, 
      'Horario ${_horarioBloc.semestres[_horarioBloc.selectedSemestreIndex]}', 
      'Horario ${_horarioBloc.semestres[_horarioBloc.selectedSemestreIndex]}'
    );
  }
}
