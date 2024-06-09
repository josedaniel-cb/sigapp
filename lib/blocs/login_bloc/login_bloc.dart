import 'package:bloc/bloc.dart';
import 'package:sigapp/app/app.dart';
import 'package:sigapp/models/login_model.dart';
// import 'package:sigapp/others/Constants/app_const.dart';
import './bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  int? intentosDeIngreso;
  late LoginModel loginModel;

  LoginBloc() : super(LoginLoading()) {
    intentosDeIngreso = 0;
    loginModel = LoginModel('', '', true);
    on<LoginEvent>(_onLoginRequested);
  }

  void _onLoginRequested(LoginEvent event, Emitter<LoginState> emit) async {
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
      emit(LoginLoading());
      // intentosDeIngreso++;
      App.browserController
          .loginSolicitarIngreso(loginModel.user, loginModel.password);
    } else if (event is LoginControllerReady) {
      loginModel = event.loginModel;
      emit(LoginReady());
    } else if (event is LoginControllerError) {
      emit(LoginCriticalError(event.url));
    } else if (event is LoginControllerLoggingIn) {
      loginModel.user = event.usuario;
      loginModel.password = event.pass;
      emit(LoginLoggingIn());
    } else if (event is LoginControllerLoggedIn) {
      emit(LoginLoggedIn());
    } else if (event is LoginControllerNotLoggedIn) {
      emit(LoginNotLoggedIn());
    }
  }
}
