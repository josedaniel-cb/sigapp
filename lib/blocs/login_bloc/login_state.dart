import 'package:equatable/equatable.dart';
import 'package:SIGApp/models/login_model.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

/// Estados de LoginPage:
/// - Cargando
/// - Listo
/// - Iniciando sesion
/// - Error
/// - Ingresado
/// - No ingresado

class LoginLoading extends LoginState {} // Cargando

class LoginReady extends LoginState {} // Listo

class LoginLoggingIn extends LoginState {} // Iniciando sesión

class LoginCriticalError extends LoginState {
  final String mensaje;

  const LoginCriticalError(this.mensaje);

  @override
  List<Object> get props => [mensaje];
} // Error

class LoginLoggedIn extends LoginState {} // Ingresado

class LoginNotLoggedIn extends LoginState {} // No Ingresado

/// Loading
/// Ready
/// LoggingIn
/// CriticalError
/// LoggedIn
/// NotLoggedIn

