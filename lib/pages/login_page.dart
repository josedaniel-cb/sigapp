import 'package:SIGApp/pages/text_page.dart';
import 'package:SIGApp/widgets/emergentes/affection_widget.dart';
import 'package:SIGApp/widgets/emergentes/terminos_widget.dart';
import 'package:SIGApp/widgets/sigapp_info/sigapp_logotipo_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:SIGApp/app/urls.dart';
import 'package:SIGApp/app/app.dart';
import 'package:SIGApp/blocs/home_bloc/bloc.dart';
import 'package:SIGApp/blocs/login_bloc/bloc.dart';
import 'package:SIGApp/widgets/emergentes/critical_error_message.dart';
import 'package:url_launcher/url_launcher.dart';

import 'home_page.dart';

class LoginPage extends StatefulWidget {
  LoginPage({
    Key key,
  }) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _passwordFocusNode = FocusNode();
  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  // final double _bodyHeight = 420;
  final double _margenVertical = 18;

  LoginBloc _loginBloc;

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
  }

  /// LISTA DE ESTADOS:
  /// Loading
  /// Ready
  /// LoggingIn
  /// CriticalError
  /// LoggedIn
  /// NotLoggedIn
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginNotLoggedIn) {
          // _mostrarMensaje("El usuario o la contraseña no son correctos");
          App.showToast("El usuario o la contraseña no son correctos");
        } else if (state is LoginLoggedIn) {
          // _passwordController.text = '';
          _passwordController.clear();
          _lanzarHomePage();
        } else if (state is LoginCriticalError) {
          showDialog(
              context: context,
              builder: (context) => CriticalErrorMessage(
                    state.mensaje,
                    mensaje:
                        'Revisa tu conexión a internet y vuelve a intentarlo más tarde',
                  ));
        } else if (state is LoginReady) {
          bool ban = App.browserController.preferencias.primerUso;
          if (ban == true || ban == null) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return TerminosWidget();
              },
            );
          }
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AffectionWidget();
            },
          );
        }
      },
      child: Scaffold(
        body: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            // _print('BlocBuilder dice: $state');
            if (state is LoginLoading) {
              return _buildMaskedBody(_buildLoadingMessage('Cargando'));
            } else if (state is LoginLoggingIn) {
              _usuarioController.text = _loginBloc.loginModel.user;
              return _buildMaskedBody(_buildLoadingMessage('Iniciando sesión'));
            } else {
              // LoginReady
              return _buildBody();
            }
          },
        ),
      ),
    );
  }

  Widget _buildMaskedBody(Widget maskWidget) {
    return Stack(
      children: <Widget>[
        _buildBody(),
        _buildMask(maskWidget),
      ],
    );
  }

  Widget _buildMask(Widget maskWidget) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: const Color(0xcc000000),
      child: SafeArea(
        child: Center(
          child: maskWidget,
        ),
      ),
    );
  }

  Widget _buildLoadingMessage(String mensaje) {
    final double lateralMargins = 20;
    return Container(
      padding: EdgeInsets.all(lateralMargins),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(lateralMargins)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            width: 30.0,
            height: 30.0,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              backgroundColor: Colors.white,
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: lateralMargins),
            child: Text(mensaje),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      color: const Color(0xFF036FB8),
      child: SafeArea(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(right: 2, top: 2),
                    child: Text(
                      'v${App.version}',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Center(
                child: Container(
                  margin: EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                  ),
                  child: SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        // horizontal: _margenVertical*1.5,
                        horizontal: _margenVertical * 1.5,
                        vertical: _margenVertical,
                      ),
                      child: _buildFormulario(),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 4, bottom: 2, left: 4),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      '#UniversidadNacionalDePiura',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 11,
                      ),
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Ver nota de autor',
                      style: TextStyle(
                        color: Colors.white70,
                        fontFamily: 'ProductSans',
                        fontSize: 13,
                      ),
                      recognizer: TapGestureRecognizer()
                        // ..onTap = () => launch(Urls.DESCARGAR_MEGA),
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TextPage(
                                cualMensaje: MensajesTextPage.NotaDeAutor,
                              ),
                            ),
                          );
                        },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormulario() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _buildTitulo(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildUserInput(),
              _buildPasswordInput(),
              _buildCheckBox(),
            ],
          ),
          _buildSubmitButton(),
          _buildHelpButton(),
        ],
      ),
    );
  }

  Widget _buildTitulo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Container(
          // color: Colors.red,
          margin: EdgeInsets.symmetric(vertical: _margenVertical),
          child: SigappLogotipoWidget(
            fontSize: 50,
          ),
        ),
      ],
    );
  }

  Widget _buildUserInput() {
    return Container(
      child: TextFormField(
        controller: _usuarioController,
        maxLines: 1,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            hintText: 'Código universitario',
            icon: Icon(
              Icons.account_circle,
              color: App.blueColor,
            )),
        validator: (valor) {
          if (valor.isEmpty) {
            return 'Por favor ingrese su código universitario';
          } else {
            return null;
          }
        },
        // onSaved: (value) => _loginBloc.loginModel.user = value,
        onSaved: (value) {
          _print('+ Guardando usuario en modelo de loginBloc: $value');
          _loginBloc.loginModel.user = value;
        },
        textInputAction: TextInputAction.next,
        onFieldSubmitted: (value) {
          FocusScope.of(context).requestFocus(_passwordFocusNode);
        },
        inputFormatters: [
          LengthLimitingTextInputFormatter(10),
        ],
      ),
    );
  }

  Widget _buildPasswordInput() {
    return Container(
      margin: EdgeInsets.only(top: _margenVertical),
      child: TextFormField(
        controller: _passwordController,
        maxLines: 1,
        obscureText: true,
        autofocus: false,
        focusNode: _passwordFocusNode,
        decoration: InputDecoration(
            hintText: 'Clave web',
            icon: Icon(
              Icons.lock,
              color: App.blueColor,
            )),
        validator: (valor) {
          if (valor.isEmpty) {
            return 'Por favor ingrese su clave web';
          } else {
            return null;
          }
        },
        // onSaved: (value) => _loginBloc.loginModel.password = value,
        onSaved: (value) {
          _print('+ Guardando contraseña en modelo de loginBloc: $value');
          _loginBloc.loginModel.password = value;
        },
        textInputAction: TextInputAction.go,
        onFieldSubmitted: (value) {
          _solicitarIngreso();
        },
      ),
    );
  }

  Widget _buildCheckBox() {
    return Container(
      margin: EdgeInsets.only(top: _margenVertical - _margenVertical * 0.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Checkbox(
            value: _loginBloc.loginModel.keepSesion,
            onChanged: (bool ban) {
              setState(() {
                _loginBloc.loginModel.keepSesion = ban;
              });
            },
          ),
          Text(
            "Mantener sesión iniciada",
          )
        ],
      ),
    );
  }

  Widget _buildSubmitButton() {
    return Container(
        margin: EdgeInsets.only(top: _margenVertical),
        child: SizedBox(
          height: 40.0,
          width: 280.0,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: App.blueColor, // This replaces 'color' parameter
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
            child: Text('Ingresar',
                style: TextStyle(fontSize: 20.0, color: Colors.white)),
            onPressed: _solicitarIngreso,
          ),
        ));
  }

  Widget _buildHelpButton() {
    return Container(
      child: TextButton(
        child: Text('¿Ha olvidado su contraseña?',
            style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w300)),
        onPressed: () => _launchURL(Urls.RESET_PASSWORD),
      ),
    );
  }

  void _solicitarIngreso() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      _loginBloc.add(LoginUserRequestLogIn());
    }
  }

  Future _lanzarHomePage() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return BlocProvider(
          create: (BuildContext context) => HomeBloc(),
          child: HomePage(),
        );
      }),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _print(String mensaje) {
    print("LoginScreen: $mensaje");
  }
}
