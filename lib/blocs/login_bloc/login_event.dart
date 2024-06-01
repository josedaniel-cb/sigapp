import 'package:equatable/equatable.dart';
import 'package:SIGApp/models/login_model.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

/// Eventos de usuario:
/// - Ingresar
/// Eventos de navegador
/// - Listo
/// - Error
/// - Iniciando sesión
/// - Ingresó
/// - No ingresó

/// Eventos de usuario:
class LoginUserRequestLogIn extends LoginEvent{} // Ingresar

/// Eventos de controlador:
class LoginControllerReady extends LoginEvent{
  final LoginModel loginModel;

  const LoginControllerReady(this.loginModel);
} // Listo

class LoginControllerError extends LoginEvent{
  final String url;
  // final String mensaje;

  const LoginControllerError(this.url);
} // Error

class LoginControllerLoggingIn extends LoginEvent{
  final String? usuario;
  final String? pass;

  LoginControllerLoggingIn(this.usuario, this.pass); 
  // Esto Solo sucede cuando existe un inicio de sesi[o]n autom[a]tico
  // Deber[i]a llamarse... LoginControllerLoggingInAutomaticly
} // Iniciando sesión

class LoginControllerLoggedIn extends LoginEvent{} // Ingresó

class LoginControllerNotLoggedIn extends LoginEvent{} // No ingresó