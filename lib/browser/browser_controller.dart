import 'dart:async';

import 'package:SIGApp/app/app.dart';
import 'package:SIGApp/browser/gestor_firebase.dart';
import 'package:flutter/material.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:SIGApp/app/urls.dart';
import 'package:SIGApp/app/preferencias.dart';
import 'package:SIGApp/blocs/boletin_bloc/bloc.dart';
import 'package:SIGApp/blocs/historial_bloc/bloc.dart';
import 'package:SIGApp/blocs/horario_bloc/bloc.dart';
import 'package:SIGApp/blocs/informe_bloc/bloc.dart';
import 'package:SIGApp/blocs/login_bloc/bloc.dart';
import 'package:SIGApp/blocs/home_bloc/bloc.dart';
import 'package:SIGApp/blocs/plan_bloc/bloc.dart';
import 'package:SIGApp/blocs/programacion_bloc/bloc.dart';
import 'package:SIGApp/blocs/programacion_bloc/programacion_bloc.dart';
import 'package:SIGApp/models/boletin_model/boletin_model.dart';
import 'package:SIGApp/models/home_model.dart';
import 'package:SIGApp/models/horario_model/horario_model.dart';
import 'package:SIGApp/models/login_model.dart';
import 'my_pages.dart';

import 'scripts.dart';
import 'scraper.dart';

class BrowserController {
  /// Blocs
  LoginBloc _loginBloc;
  HomeBloc? _homeBloc;
  HorarioBloc? _horarioBloc;
  BoletinBloc? _boletinBloc;
  PlanBloc? _planBloc;
  ProgramacionBloc? _programacionBloc;
  HistorialBloc? _historialBloc;
  InformeBloc? _informeBloc;

  late GestorFirebase gestorFirebase;
  late WebViewController _webViewController;
  Preferencias? _preferencias;
  MyPages? currentPage;

  final int _tiempoDeEsperaMs = 250;
  late bool solicitudActiva;

  bool banAuxSeHaLlegadoACienPorciento = false;

  /// Constructor
  BrowserController(this._loginBloc) {
    // Obtener preferencias
    _preferencias = Preferencias();
    _preferencias!.obtener();

    gestorFirebase = GestorFirebase();

    // Inicializar navegador
    _initializeWebView();
  }

  void _initializeWebView() {
    _webViewController = WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          // ..setBackgroundColor(const Color(0x00000000))
          ..setNavigationDelegate(
            NavigationDelegate(
              onProgress: (int progress) {
                if (banAuxSeHaLlegadoACienPorciento) {
                  App.showToast('🌐 Web cargada', duracionSegundos: 1);
                  banAuxSeHaLlegadoACienPorciento = false;
                } else {
                  App.showToast(
                      '🌐 _status: ${(progress * 100.0).toStringAsFixed(0)}%',
                      duracionSegundos: 1);
                  if (progress == 100) {
                    banAuxSeHaLlegadoACienPorciento = true;
                  }
                }
                _print('Cargando web ${progress}%');
              },
              // onPageStarted: (String url) {
              //   _urlListener(url);
              // },
              onPageFinished: (String url) {
                _urlListener(url);
              },
              onWebResourceError: (WebResourceError error) {
                _print('''
              Page resource error:
                code: ${error.errorCode}
                description: ${error.description}
                errorType: ${error.errorType}
                isForMainFrame: ${error.isForMainFrame}
            ''');
              },
              // onNavigationRequest: (NavigationRequest request) {
              //   if (request.url.startsWith('https://www.youtube.com/')) {
              //     _print('blocking navigation to ${request.url}');
              //     return NavigationDecision.prevent;
              //   }
              //   _print('allowing navigation to ${request.url}');
              //   return NavigationDecision.navigate;
              // },
            ),
          )
        // ..addJavaScriptChannel(
        //   'Toaster',
        //   onMessageReceived: (JavaScriptMessage message) {
        //     ScaffoldMessenger.of(context).showSnackBar(
        //       SnackBar(content: Text(message.message)),
        //     );
        //   },
        // )
        // ..loadRequest(Uri.parse('https://flutter.dev'))
        ;

    currentPage = MyPages.Login;
    _webViewController.loadRequest(Uri.parse(Urls.SALIR));
  }

  ///Get
  WebViewController get webView => _webViewController;

  HomeBloc? get homeBloc => _homeBloc;

  Preferencias? get preferencias => _preferencias;

  /// Setters
  set loginBloc(LoginBloc bloc) {
    _loginBloc = bloc;
  }

  set homeBloc(HomeBloc? bloc) {
    _homeBloc = bloc;
    currentPage = MyPages.Home;
  }

  set horarioBloc(HorarioBloc? bloc) {
    _horarioBloc = bloc;
    solicitudActiva = true;
  }

  set boletinBloc(BoletinBloc? bloc) {
    _boletinBloc = bloc;
    solicitudActiva = true;
    currentPage = MyPages.Boletin;
  }

  set planBloc(PlanBloc? bloc) {
    _planBloc = bloc;
    solicitudActiva = true;
  }

  set informeBloc(InformeBloc? bloc) {
    _informeBloc = bloc;
    solicitudActiva = true;
  }

  set programacionBloc(ProgramacionBloc? bloc) {
    _programacionBloc = bloc;
    solicitudActiva = true;
  }

  set historialBloc(HistorialBloc? bloc) {
    _historialBloc = bloc;
    solicitudActiva = true;
  }

  /// Operaciones con el navegador
  void cargarUrl(String url) {
    _webViewController.loadRequest(Uri.parse(url));
  }

  Future<Document> solicitarDocumento() async {
    String htmlData = await _webViewController
        .runJavaScriptReturningResult(Scripts.browserSolicitarDocumento())
        .then((value) => value.toString());
    htmlData = Scraper.acondicionarHtmlData(htmlData)!;
    return parse(htmlData);
  }

  /// Acciones Login
  void loginSolicitarIngreso(String? cu, String? password) {
    _print('Solicitando ingreso con cu: \'$cu\' pass: \'$password\'');
    _loginBloc.intentosDeIngreso = _loginBloc.intentosDeIngreso! + 1;
    _webViewController
        .runJavaScript(Scripts.loginSolicitarIngreso(cu, password));
  }

  // Acciones Home
  Future homeSolicitarDatos() async {
    Document document = await solicitarDocumento();
    HomeModel modelo = Scraper.homeObtenerDatos(document);
    _homeBloc!.add(HomeControllerReady(modelo));
  }

  // Acciones Horario
  void horarioSolicitarHorario() {
    if (solicitudActiva) {
      Timer(Duration(milliseconds: _tiempoDeEsperaMs), () async {
        Document document = await solicitarDocumento();
        bool aunEstaCargando = Scraper.estaCargandoTabla(document);
        if (!aunEstaCargando) {
          HorarioModel modelo = Scraper.horarioGenerarModelo(document);
          List<String> semestres =
              Scraper.browserGenerarListaSemestres(document);
          _horarioBloc!.add(HorarioControllerReady(modelo, semestres));
        } else {
          horarioSolicitarHorario();
        }
      });
    }
  }

  Future horarioSolicitarOtro(int semestreIndex) async {
    await _webViewController
        .runJavaScript(Scripts.genericSeleccionarSemestre(semestreIndex));
    _horarioSolicitarDatosOtro(semestreIndex);
  }

  Future _horarioSolicitarDatosOtro(int semestreIndex) async {
    if (solicitudActiva) {
      Timer(Duration(milliseconds: _tiempoDeEsperaMs), () async {
        Document document = await solicitarDocumento();
        bool aunEstaCargando = Scraper.estaCargandoTabla(document);
        if (!aunEstaCargando) {
          HorarioModel modelo = Scraper.horarioGenerarModelo(document);
          _horarioBloc!.add(HorarioControllerChanged(modelo));
        } else {
          _horarioSolicitarDatosOtro(semestreIndex);
        }
      });
    }
  }

  // Acciones Boletin
  void boletinSolicitarBoletin() {
    if (solicitudActiva) {
      Timer(Duration(milliseconds: _tiempoDeEsperaMs), () async {
        Document document = await solicitarDocumento();
        bool aunEstaCargando = Scraper.estaCargandoTabla(document);
        if (!aunEstaCargando) {
          BoletinModel modelo = Scraper.boletinGenerarModelo(document);
          List<String> semestres =
              Scraper.browserGenerarListaSemestres(document);
          _boletinBloc!.add(BoletinControllerReady(modelo, semestres));
        } else {
          boletinSolicitarBoletin();
        }
      });
    }
  }

  Future boletinSolicitarOtro(int? semestreIndex) async {
    await _webViewController
        .runJavaScript(Scripts.genericSeleccionarSemestre(semestreIndex));
    _boletinSolicitarDatosOtro(semestreIndex);
  }

  Future _boletinSolicitarDatosOtro(int? semestreIndex) async {
    if (solicitudActiva) {
      Timer(Duration(milliseconds: _tiempoDeEsperaMs), () async {
        Document document = await solicitarDocumento();
        if (!Scraper.estaCargandoTabla(document)) {
          BoletinModel modelo = Scraper.boletinGenerarModelo(document);
          _boletinBloc!.add(BoletinControllerChanged(modelo));
        } else {
          _boletinSolicitarDatosOtro(semestreIndex);
        }
      });
    }
  }

  Future boletinSolicitarNotas(int cursoIndex) async {
    await _webViewController
        .runJavaScript(Scripts.boletinClickNotas(cursoIndex));
  }

  Future _boletinSolicitarDatosNotas() async {
    Document document = await solicitarDocumento();
    _boletinBloc!
        .add(BoletinControllerNotasReady(Scraper.notasGenerarModelo(document)));
    _webViewController.loadRequest(Uri.parse(Urls.BOLETIN));
  }

  // Plan de estudios
  Future planSolicitarPlanDeEstudios() async {
    if (solicitudActiva) {
      Document documento = await solicitarDocumento();
      if (Scraper.cuerpoTablaCargado(documento)) {
        _planBloc!
            .add(PlanControllerReady(Scraper.planGenerarModelo(documento)));
      } else {
        Timer(Duration(milliseconds: _tiempoDeEsperaMs),
            () => planSolicitarPlanDeEstudios());
      }
    }
  }

  // Programacion académica
  Future programacionSolicitarInformeAcademico() async {
    if (solicitudActiva) {
      Document documento = await solicitarDocumento();
      if (Scraper.cuerpoTablaCargado(documento)) {
        _programacionBloc!.add(ProgramacionControllerReady(
            Scraper.programacionGenerarModelo(documento)));
      } else {
        Timer(Duration(milliseconds: _tiempoDeEsperaMs),
            () => programacionSolicitarInformeAcademico());
      }
    }
  }

  // Historal académico
  Future historialSolicitarHistorialAcademico() async {
    if (solicitudActiva) {
      Document documento = await solicitarDocumento();
      if (!Scraper.estaCargandoTabla(documento)) {
        _historialBloc!.add(HistorialControllerReady(
            Scraper.historialGenerarModelo(documento)));
      } else {
        Timer(Duration(milliseconds: _tiempoDeEsperaMs),
            () => historialSolicitarHistorialAcademico());
      }
    }
  }

  // Informe Académico
  Future informeSolicitarInformeAcademico() async {
    if (solicitudActiva) {
      Document documento = await solicitarDocumento();
      if (!Scraper.estaCargandoTabla(documento)) {
        _informeBloc!.add(
            InformeControllerReady(Scraper.informeGenerarModelo(documento)));
      } else {
        Timer(Duration(milliseconds: _tiempoDeEsperaMs),
            () => informeSolicitarInformeAcademico());
      }
    }
  }

  /// Browsing
  void _urlListener(String url) {
    _print("$url");
    switch (currentPage) {
      case MyPages.Login:
        _loginUrlListener(url);
        break;
      case MyPages.Home:
        _homeUrlListener(url);
        break;
      case MyPages.Horario:
        break;
      case MyPages.Boletin:
        _boletinListener(url);
        break;
      case MyPages.Plan:
        break;
      case MyPages.Programacion:
        break;
      case MyPages.Verificacion:
        break;
      case MyPages.Historial:
        break;
      case MyPages.Informe:
        break;
      case MyPages.Notas:
        break;
    }
  }

  void _loginUrlListener(String url) async {
    switch (url) {
      case Urls.LOGIN:
        if (_loginBloc.intentosDeIngreso == 0) {
          if (_preferencias!.usuario != null) {
            if (_preferencias!.iniciarSesionAuto!) {
              _loginBloc.add(LoginControllerLoggingIn(
                  _preferencias!.usuario, _preferencias!.password));
              loginSolicitarIngreso(
                  _preferencias!.usuario, _preferencias!.password);
            } else {
              _loginBloc.add(LoginControllerReady(LoginModel(
                  _preferencias!.usuario,
                  _preferencias!.password,
                  _preferencias!.mantenerSesion)));
            }
          } else {
            _loginBloc.add(LoginControllerReady(LoginModel('', '', true)));
          }
        } else {
          _loginBloc.add(LoginControllerNotLoggedIn());
        }
        break;
      case Urls.HOME:
        await gestorFirebase.registrarInicioSesion(_loginBloc.loginModel.user);
        if (_loginBloc.intentosDeIngreso != 0) {
          _preferencias!.guardarSesionInfo(
              _loginBloc.loginModel.user!,
              _loginBloc.loginModel.password!,
              _loginBloc.loginModel.keepSesion!,
              _loginBloc.loginModel.keepSesion!);
        }
        _loginBloc.intentosDeIngreso = 0;
        _loginBloc.add(LoginControllerLoggedIn());
        break;
      default:
        _loginBloc.add(LoginControllerError(url));
        break;
    }
  }

  void _homeUrlListener(String url) {
    switch (url) {
      case Urls.INICIO_SESION:
      case Urls.LOGIN:
        _preferencias!.guardarIniciarSesionAuto(false);
        _homeBloc!.add(HomeControllerLoggedOut());
        break;
      case Urls.HORARIO:
        _homeBloc!.add(HomeControllerHorario());
        break;
      case Urls.BOLETIN:
        _homeBloc!.add(HomeControllerBoletin());
        break;
      case Urls.PLAN_DE_ESTUDIOS:
        _homeBloc!.add(HomeControllerPlan());
        break;
      case Urls.PROGRAMACION_ACADEMICA:
        _homeBloc!.add(HomeControllerProgramacion());
        break;
      case Urls.HISTORIAL_ACADEMICO:
        _homeBloc!.add(HomeControllerHistorial());
        break;
      case Urls.INFORME_ACADEMICO:
        _homeBloc!.add(HomeControllerInforme());
        break;
      default:
        _homeBloc!.add(HomeControllerError(url));
        break;
    }
  }

  void _boletinListener(String url) {
    if (Scraper.isNotasUrl(url)) {
      _boletinSolicitarDatosNotas();
    } else if (url == Urls.BOLETIN) {
      _boletinBloc!.add(BoletinUserChange(_boletinBloc!.selectedSemestreIndex));
    } else if (url == Urls.INICIO_SESION || url == Urls.LOGIN) {
      _boletinBloc!.add(BoletinControllerLoggedOut());
      _homeBloc!.add(HomeControllerLoggedOut());
    } else {
      _loginBloc.add(LoginControllerError(url));
    }
  }

  void _print(Object mensaje) {
    print("🌐:\t$mensaje");
  }

  void setVisible(bool visible) {
    if (visible) {
      // No existe el equivalente exacto a `show` y `hide` en `webview_flutter`.
      // Se puede simular ocultando y mostrando un widget que contiene el WebView.
    }
  }
}
