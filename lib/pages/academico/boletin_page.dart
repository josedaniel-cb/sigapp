import 'package:SIGApp/app/urls.dart';
import 'package:SIGApp/browser/gestor_firebase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:SIGApp/app/app.dart';
import 'package:SIGApp/blocs/boletin_bloc/bloc.dart';
import 'package:SIGApp/pages/academico/notas_page.dart';
import 'package:SIGApp/widgets/lista_cursos_widget/curso_widget.dart';
import 'package:SIGApp/widgets/lista_cursos_widget/lista_cursos_widget.dart';
import 'package:SIGApp/widgets/loading_mask_widget.dart';
import 'package:SIGApp/widgets/simple_loading_body_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:SIGApp/browser/my_pages.dart';

class BoletinPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => BoletinPageState();
}
  
class BoletinPageState extends State<BoletinPage>{
  BoletinBloc _bloc;
  bool _busyForPop;

  @override
  void initState() {
    super.initState();
    _busyForPop = false;
    _bloc = BlocProvider.of<BoletinBloc>(context);
    App.browserController.boletinBloc = _bloc;
    App.browserController.boletinSolicitarBoletin();
  }

  @override
  void dispose() {
    _bloc.close();
    App.browserController.solicitudActiva = false;
    // App.browserController.currentPage = Page.Home;
    App.browserController.currentPage = MyPages.Home;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BoletinBloc, BoletinState>(
      listener: (context, state){
        if(state is BoletinNotasReady){
          _busyForPop = false;
          _lanzarNotasPage();
        }
        else if(state is BoletinLoggedOut){
          Navigator.of(context).pop();
        }
      },
      child: BlocBuilder<BoletinBloc, BoletinState>(
        builder: (context, state) {
          if(state is BoletinLoading){
            return _buildLoadingState();
          } 
          else if(state is BoletinLoadingNotas){
            _busyForPop = true;
            return _buildReadyState(withMask: true);
          }
          else { // Ready
            _busyForPop = false;
            return _buildReadyState();
          }
        },
      ),
    );
  }

  Widget _buildLoadingState(){
    return Scaffold(
      appBar: AppBar(
        title: Text('Boletín de cursos'),
      ),
      body: SimpleLoadingBodyWidget(),
    );
  }

  Widget _buildReadyState({bool withMask = false}){    
    return WillPopScope(
      onWillPop: () => Future.value(!_busyForPop),
      child: Scaffold(        
        appBar: AppBar(
          automaticallyImplyLeading: !withMask,
          title: Text(withMask ? 'Accediendo...' : 'Boletín ${_bloc.semestres[_bloc.selectedSemestreIndex]}'),
          actions: withMask ?
            <Widget>[]
            :
            <Widget>[
              // _buildInfoAction(),
              _buildSemestresAction(),
            ],
        ),
        body: withMask ?
          Stack(
            children: <Widget>[
              _buildBody(),
              LoadingMaskWidget(
                mensaje: 'Cargando notas',
                alto: MediaQuery.of(context).size.height,
                ancho: MediaQuery.of(context).size.width,
              ),
            ],
          )
          :
          _buildBody(),
      ),
    );
  }

  Widget _buildBody(){
    return ListaCursosWidget(
      leyenda: _buildCabecera(),
      nadaQueMostrarMensaje: 'Puede que no tengas cursos inscritos en este semestre'
        'Puedes comprobarlo visitando ${Urls.LOGIN}',
      cursos: List.generate(_bloc.modelo.cursos.length, (int i){
        return CursoWidget(
          index: i + 1,
          cursoModel: _bloc.modelo.cursos[i],
          botones: <Widget>[
            _buildBoton(
              text: 'Notas',
              onPressed: () => _tapNotas(i),
            ),
            _buildBoton(
              text: 'Sílabo',
              onPressed: () =>_tapSilabo(i),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildCabecera(){
    int totalCreditos, totalCursos;

    totalCursos = _bloc.modelo.cursos.length;
    totalCreditos = 0;
    for(int i = 0; i < _bloc.modelo.cursos.length; i++){
      totalCreditos += int.parse(_bloc.modelo.cursos[i].creditos);
    }

    return Container(
      margin: EdgeInsets.only(left: 5),
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          child: Text('Total cursos:\t$totalCursos'),
        ),
        Container(
          child: Text('Total créditos:\t$totalCreditos'),
        ),
      ],
    ),
    );
  }

  // Widget _buildInfoAction(){
  //   return IconButton(
  //     icon: Icon(Icons.info),
  //     onPressed: _showDialog,
  //   );
  // } 

  Widget _buildSemestresAction(){
    return PopupMenuButton<int>(
      icon: Icon(Icons.arrow_drop_down),
      onSelected: (selectedIndex){
        App.browserController.gestorFirebase.registrarUso(CasosDeUso.BoletinSeleccionarSemestre);
        _bloc.add(BoletinUserChange(selectedIndex));
      },
      itemBuilder: (BuildContext context){
        return List.generate(_bloc.semestres.length, (int i){
          return PopupMenuItem<int>(
            value: i,
            child: Text(_bloc.semestres[i]),
          );
        });
      },
    );
  }

  Widget _buildBoton({@required String text, @required Function onPressed}){
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(App.bordeRadio),
        ),
      ),
      child: Text(text),
    );
  }

  void _tapNotas(int cursoIndex){
    App.browserController.gestorFirebase.registrarUso(CasosDeUso.BoletinNotas);
    _bloc.add(BoletinUserRequestNotas(cursoIndex));
  }

  void _tapSilabo(int index){  
    App.browserController.gestorFirebase.registrarUso(CasosDeUso.BoletinSilabo);
    _launchURL(_bloc.modelo.cursos[index].silaboUrl);
  }

  void _lanzarNotasPage(){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NotasPage(_bloc.notasModel)
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      _print('Lanzando $url');
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _print(String mensaje){
    print("BoletinPage: $mensaje");
  }

  void _showDialog(){
    double tamFuente = 14;
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 10),
              child: Icon(
                Icons.explore,
                color: App.blueColor,
              ),
            ),
            Text('Consejo'),
          ],
        ),        
        content: Container(
          // color: Colors.redAccent,
          child: Text(
            'Es posible que para poder visualizar las notas o el sílabo '
            'de un curso correctamente tenga intentar más de una vez. '
            'En algunas ocasiones los servidores no responden correctamente.'
          ),
        ),
        actions: <Widget>[
          Container(
            // color: Colors.green,
            margin: EdgeInsets.only(right: 8),
            child: TextButton(
              child: Text(
                "Comprendido",
                style: TextStyle(
                  fontSize: tamFuente,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}