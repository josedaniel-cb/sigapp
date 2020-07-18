import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:SIGApp/app/app.dart';
import 'package:SIGApp/models/login_model.dart';
// import 'package:SIGApp/others/Constants/app_const.dart';
import './bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  int intentosDeIngreso;
  LoginModel loginModel;

  LoginBloc() : super(LoginLoading()) {
    intentosDeIngreso = 0;
    loginModel = LoginModel('', '', true);
  }
  // @override
  // LoginState get initialState => LoginLoading();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    // Eventos
    // - UserRequestLogIn
    // - ControllerReady
    // - ControllerError
    // - ControllerLoggingIn
    // - ControllerLoggedIn
    // - ControllerNotLoggedIn

    // Estados
    // - Loading
    // - Ready
    // - LoggingIn
    // - LoggedIn
    // - Error
    // - NotLoggedIn

    ///Nota: Es necesario actualizar [loginModel] desde la LoginPage para poder realizar operaciones
    if (event is LoginUserRequestLogIn) {
      yield LoginLoading();
      // intentosDeIngreso++;
      App.browserController
          .loginSolicitarIngreso(loginModel.user, loginModel.password);
    } else if (event is LoginControllerReady) {
      loginModel = event.loginModel;
      yield LoginReady();
    } else if (event is LoginControllerError) {
      yield LoginCriticalError(event.url);
    } else if (event is LoginControllerLoggingIn) {
      loginModel.user = event.usuario;
      loginModel.password = event.pass;
      yield LoginLoggingIn();
    } else if (event is LoginControllerLoggedIn) {
      yield LoginLoggedIn();
    } else if (event is LoginControllerNotLoggedIn) {
      yield LoginNotLoggedIn();
    }
  }
}
