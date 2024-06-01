import 'package:SIGApp/browser/gestor_firebase.dart';
import 'package:SIGApp/browser/my_pages.dart';
import 'package:SIGApp/pages/about_page.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:SIGApp/app/colores_gradiente.dart';
import 'package:SIGApp/app/urls.dart';
import 'package:SIGApp/app/app.dart';
import 'package:SIGApp/blocs/boletin_bloc/bloc.dart';
import 'package:SIGApp/blocs/historial_bloc/bloc.dart';
import 'package:SIGApp/blocs/home_bloc/bloc.dart';
import 'package:SIGApp/blocs/horario_bloc/bloc.dart';
import 'package:SIGApp/blocs/informe_bloc/bloc.dart';
import 'package:SIGApp/blocs/plan_bloc/plan_bloc.dart';
import 'package:SIGApp/blocs/programacion_bloc/bloc.dart';
import 'package:SIGApp/pages/academico/plan_page/plan_page.dart';
import 'package:SIGApp/pages/academico/programacion_page.dart';
import 'package:SIGApp/widgets/emergentes/critical_error_message.dart';
import 'package:url_launcher/url_launcher.dart';

import 'academico/boletin_page.dart';
import 'academico/historial_page/historial_page.dart';
import 'academico/horario_page.dart';
import 'academico/informe_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final double _titleItemSize = 16;
  final FontWeight _titleItemFontWeight = FontWeight.w600;

  HomeBloc _homeBloc;

  List<Color> _userColors;

  bool _busy;

  @override
  void initState() {
    super.initState();
    _userColors = ColoresGradiente.blueDefault;
    _busy = true;
    _homeBloc = BlocProvider.of<HomeBloc>(context);
    App.browserController.homeBloc = _homeBloc;
    App.browserController.homeSolicitarDatos();
    // App.browserController.currentPage = Page.Home;
  }

  @override
  void dispose() {
    _homeBloc.close();
    App.browserController.currentPage = MyPages.Login;
    super.dispose();
  }

  void _print(String mensaje) {
    print("HomePage: $mensaje");
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is HomeLoading) {
          _busy = true;
        } else {
          _busy = false;
          if (state is HomeReady) {
            _userColors =
                ColoresGradiente.generarColores(_homeBloc.homeModel.iniciales);
          } else if (state is HomeLogOut) {
            _logOut();
          } else if (state is HomeHorario) {
            _lanzarHorarioPage();
          } else if (state is HomeBoletin) {
            _lanzarBoletinPage();
          } else if (state is HomePlan) {
            _lanzarPlanPage();
          } else if (state is HomeProgramacion) {
            _lanzarProgramacionPage();
          } else if (state is HomeHistorial) {
            _lanzarHistorialPage();
          } else if (state is HomeInforme) {
            _lanzarInformePage();
          } else if (state is HomeCriticalError) {
            showDialog(
                context: context,
                builder: (context) => CriticalErrorMessage(state.mensaje));
          }
        }
      },
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return WillPopScope(
            onWillPop: () => null,
            child: _buildScaffold(),
          );
        },
      ),
    );
  }

  Widget _buildScaffold() {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Bienvenido',
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.info),
            // onPressed: _showAbout,
            onPressed: _tapAbout,
          ),
        ],
        bottom: _buildProgressIndicator(),
      ),
      body: Container(
        color: Colors.white,
        child: _buildBody(),
      ),
    );
  }

  PreferredSize _buildProgressIndicator() {
    return PreferredSize(
        preferredSize: Size(double.infinity, 0.0),
        child: SizedBox(
          height: 4.0,
          child: _busy
              ? LinearProgressIndicator(
                  backgroundColor: Colors.white70,
                )
              : null,
        ));
  }

  Widget _buildBody() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          stops: [0.2, 0.5, 0.7, 0.9],
          colors: _userColors,
        ),
      ),
      child: Stack(
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _buildUser(),
            ],
          ),
          SingleChildScrollView(
            // child: Column(
            //   children: <Widget>[
            //     _buildInvisibleUser(),
            //     Container(
            //       decoration: BoxDecoration(
            //         color: Colors.white,
            //         borderRadius: BorderRadius.only(
            //           topLeft: Radius.circular(20),
            //           topRight: Radius.circular(20),
            //         ),
            //       ),
            //       margin: EdgeInsets.symmetric(horizontal: 10),
            //       child: _buildMenu(),
            //     ),
            //   ],
            // ),
            child: FadeInUp(
              child: Column(
                children: <Widget>[
                  _buildInvisibleUser(),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    // child: _buildMenu(),
                    child: FadeIn(
                      child: _buildMenu(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenu() {
    return Column(
      children: <Widget>[
        SizedBox(height: 14),
        _buildCategoria(
            titulo: 'Semestre actual',
            backgroundBoton: Colors.primaries[6],
            colorTextoBoton: Colors.white,
            botones: <BotonInfo>[
              BotonInfo(
                // icono: Icons.calendar_today,
                // icono: Icons.dashboard,
                icono: Icons.event_note,
                name: 'Horario de clases',
                onPressed: _tapHorario,
              ),
              BotonInfo(
                // icono: Icons.calendar_today,
                icono: Icons.format_list_numbered_rtl,
                name: 'Boletín de cursos',
                onPressed: _tapBoletin,
              ),
            ]),
        _buildCategoria(
            titulo: 'Procesos académicos',
            backgroundBoton: Colors.red,
            colorTextoBoton: Colors.white,
            botones: <BotonInfo>[
              BotonInfo(
                icono: Icons.book,
                name: 'Plan de estudios',
                onPressed: _tapPlanDeEstudios,
              ),
              BotonInfo(
                // icono: Icons.book,
                icono: Icons.format_list_bulleted,
                name: 'Programación académica',
                onPressed: _tapProgramacionAcademica,
              ),
            ]),
        _buildCategoria(
            titulo: 'Resultados académicos',
            // backgroundBoton: Colors.green,
            backgroundBoton: Color(0xFF18cc04),
            colorTextoBoton: Colors.white,
            botones: <BotonInfo>[
              BotonInfo(
                // icono: Icons.check,
                // icono: Icons.done_outline,
                icono: Icons.assessment,
                name: 'Historial académico',
                // onPressed: () => App.showToast('Próximamente'),
                onPressed: _tapHistorialAcademico,
              ),
              BotonInfo(
                // icono: Icons.check,
                icono: Icons.assignment_ind,
                name: 'Informe académico',
                onPressed: _tapInformeAcademico,
              ),
            ]),
        _buildCategoria(
            titulo: 'Enlaces de interés',
            // colorTitulo: Colors.grey,,
            // colorTextoBoton: Colors.grey,
            colorTitulo: Color(0xFF474647),
            backgroundBoton: Color(0xFFEAEAEA),
            colorTextoBoton: Color(0xFF474647),
            botones: <BotonInfo>[
              BotonInfo(
                icono: Icons.attach_money,
                name: 'Consulta de pagos',
                onPressed: () {
                  App.browserController.gestorFirebase
                      .registrarUso(CasosDeUso.ConsultaDePagos);
                  _launchURL(Urls.REPORTE_PAGOS);
                },
              ),
              BotonInfo(
                icono: Icons.laptop,
                name: 'Plataforma virtual',
                onPressed: () {
                  App.browserController.gestorFirebase
                      .registrarUso(CasosDeUso.PlataformaVirtual);
                  _launchURL(Urls.PLATAFORMA_VIRTUAL);
                },
              ),
              BotonInfo(
                icono: Icons.home,
                name: 'SIGA',
                onPressed: () {
                  App.browserController.gestorFirebase
                      .registrarUso(CasosDeUso.Siga);
                  _launchURL(Urls.INICIO_SESION);
                },
              ),
            ]),
        _buildCategoria(
            titulo: 'Salir',
            backgroundBoton: Colors.grey,
            colorTextoBoton: Colors.white,
            botones: <BotonInfo>[
              BotonInfo(
                icono: Icons.exit_to_app,
                name: 'Cerrar sesión',
                onPressed: _tapCerrarSesion,
              ),
            ]),
        _buildCategoria(
            titulo: 'Enlace de descarga',
            backgroundBoton: App.greenColor,
            colorTextoBoton: Colors.white,
            botones: <BotonInfo>[
              BotonInfo(
                icono: Icons.favorite,
                name: 'Compartir app',
                onPressed: App.compartirApp,
              ),
            ]),
      ],
    );
  }

  Widget _buildUser() {
    final double fontSize = 15;
    final double margen = 20;
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(margen),
            child: CircleAvatar(
              radius: 30,
              child: Text(
                _homeBloc.homeModel.iniciales,
                // 'LE',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w400,
                ),
              ),
              backgroundColor: Colors.black54,
            ),
          ),
          Expanded(
              child: Container(
            margin: EdgeInsets.only(top: margen, bottom: margen, right: margen),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text(
                    _homeBloc.homeModel.apellidosNombres,
                    // 'ANCAJIMA RUIZ, LUIS ELIAN',
                    style: TextStyle(
                      fontSize: fontSize,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 2),
                  child: Text(
                    _homeBloc.homeModel.escuela,
                    // 'INGENIERIA ELECTRONICA',
                    style: TextStyle(
                      fontSize: fontSize - 3,
                      // color: Colors.white,
                      color: Color(0xFFE7E7E7),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildInvisibleUser() {
    final double fontSize = 15;
    final double margen = 20;
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(margen),
            child: CircleAvatar(
              radius: 30,
              child: Text(
                _homeBloc.homeModel.iniciales,
                style: TextStyle(
                  color: Colors.transparent,
                  fontSize: 30,
                  fontWeight: FontWeight.w400,
                ),
              ),
              backgroundColor: Colors.transparent,
            ),
          ),
          Expanded(
              child: Container(
            margin: EdgeInsets.only(top: margen, bottom: margen, right: margen),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text(
                    _homeBloc.homeModel.apellidosNombres,
                    style: TextStyle(
                      fontSize: fontSize,
                      color: Colors.transparent,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 2),
                  child: Text(
                    _homeBloc.homeModel.escuela,
                    style: TextStyle(
                      fontSize: fontSize - 3,
                      color: Colors.transparent,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildCategoria({
    @required String titulo,
    Color colorTitulo,
    @required Color backgroundBoton,
    @required Color colorTextoBoton,
    @required List<BotonInfo> botones,
  }) {
    return Container(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        // top: 20,
        // bottom: 5,
        bottom: 20,
      ),
      width: MediaQuery.of(context).size.width,
      // decoration: BoxDecoration(
      //   color: Colors.white,
      // ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 5),
            child: Text(
              titulo,
              style: TextStyle(
                color: colorTitulo ?? backgroundBoton,
                fontSize: _titleItemSize,
                fontWeight: _titleItemFontWeight,
              ),
            ),
          ),
          Column(
            children: List.generate(botones.length, (int i) {
              return _buildExpandedButton(
                text: botones[i].name,
                icon: botones[i].icono,
                function: botones[i].onPressed,
                textColor: colorTextoBoton,
                background: backgroundBoton,
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildExpandedButton(
      {@required String text,
      @required Color textColor,
      @required Color background,
      @required IconData icon,
      @required Function function}) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            margin: EdgeInsets.only(top: 2),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: background,
                padding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    flex: 2,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(right: 8),
                            child: Icon(
                              icon,
                              color: textColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 5,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            child: Text(
                              text,
                              style: TextStyle(
                                color: textColor,
                                fontSize: _titleItemSize,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              onPressed: function,
            ),
          ),
        ),
      ],
    );
  }

  void _tapHorario() {
    if (!_busy) {
      _homeBloc.add(HomeUserHorario());
      App.browserController.gestorFirebase.registrarUso(CasosDeUso.Horario);
      // App.browserController.gestorFirebase.registrarUso(GestorFirebase.HORARIO);
    }
  }

  void _tapBoletin() {
    if (!_busy) {
      _homeBloc.add(HomeUserBoletin());
      App.browserController.gestorFirebase.registrarUso(CasosDeUso.Boletin);
    }
  }

  void _tapPlanDeEstudios() {
    if (!_busy) {
      _homeBloc.add(HomeUserPlan());
      App.browserController.gestorFirebase
          .registrarUso(CasosDeUso.PlanEstudios);
    }
  }

  void _tapHistorialAcademico() {
    if (!_busy) {
      _homeBloc.add(HomeUserHistorial());
      App.browserController.gestorFirebase
          .registrarUso(CasosDeUso.HistorialAcademico);
    }
  }

  void _tapInformeAcademico() {
    if (!_busy) {
      _homeBloc.add(HomeUserInforme());
      App.browserController.gestorFirebase
          .registrarUso(CasosDeUso.InformeAcademico);
    }
  }

  void _tapProgramacionAcademica() {
    if (!_busy) {
      _homeBloc.add(HomeUserProgramacion());
      App.browserController.gestorFirebase
          .registrarUso(CasosDeUso.ProgramacionAcademica);
    }
  }

  void _tapCerrarSesion() {
    if (!_busy) {
      _homeBloc.add(HomeUserLogOut());
      App.browserController.gestorFirebase
          .registrarUso(CasosDeUso.CerrarSesion);
    }
  }

  void _logOut() {
    Navigator.of(context).pop();
  }

  void _lanzarHorarioPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return BlocProvider(
          create: (BuildContext context) => HorarioBloc(),
          child: HorarioPage(),
        );
      }),
    );
  }

  void _lanzarBoletinPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return BlocProvider(
          create: (BuildContext context) => BoletinBloc(),
          child: BoletinPage(),
        );
      }),
    );
  }

  void _lanzarPlanPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return BlocProvider(
          create: (BuildContext context) => PlanBloc(),
          child: PlanPage(),
        );
      }),
    );
  }

  void _lanzarProgramacionPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return BlocProvider(
          create: (BuildContext context) => ProgramacionBloc(),
          child: ProgramacionPage(),
        );
      }),
    );
  }

  void _lanzarHistorialPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return BlocProvider(
          create: (BuildContext context) => HistorialBloc(),
          child: HistorialPage(),
        );
      }),
    );
  }

  void _lanzarInformePage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return BlocProvider(
          create: (BuildContext context) => InformeBloc(),
          child: InformePage(),
        );
      }),
    );
  }

  void _launchURL(String url) async {
    if (!_busy && await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  // void _showAbout(){
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AcercaDeWidget();
  //     },
  //   );
  // }

  void _tapAbout() {
    App.browserController.gestorFirebase.registrarUso(CasosDeUso.About);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return AboutPage();
      }),
    );
  }
}

class BotonInfo {
  final IconData icono;
  final String name;
  final Function onPressed;

  BotonInfo(
      {@required this.name, @required this.icono, @required this.onPressed});
}
