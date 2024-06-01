import 'package:shared_preferences/shared_preferences.dart';

class Preferencias{
  final String _usuarioKey = 'usuario';
  final String _passwordKey = 'password';
  final String _mantenerSesionKey = 'mantenerSesion';
  final String _iniciarSesionAutoKey = 'iniciarSesionAuto';
  final String _primerUso = 'primerUso';
  String? usuario;
  String? password;
  bool? mantenerSesion;
  bool? iniciarSesionAuto;
  bool? primerUso;
  late SharedPreferences _preferencias;

  Future obtener() async {
    _preferencias = await SharedPreferences.getInstance();
    primerUso = _preferencias.getBool(_primerUso);
    usuario = _preferencias.getString(_usuarioKey);
    password = _preferencias.getString(_passwordKey);
    mantenerSesion = _preferencias.getBool(_mantenerSesionKey);
    iniciarSesionAuto = _preferencias.getBool(_iniciarSesionAutoKey);
    _print('obtenidas:\n\tprimerUso: \'$primerUso\'\n\tusuario: \'$usuario\'\n\tpassword: \'$password\'\n\tmantenerSesion: \'$mantenerSesion\'\n\tiniciarSesionAuto: \'$iniciarSesionAuto\'');
  }

  Future guardarSesionInfo(String usuario, String password, bool mantenerSesion, bool iniciarSesionAuto) async {
    guardarPassword(password);
    guardarIniciarSesionAuto(iniciarSesionAuto);
    guardarUsuario(usuario);
    guardarMantenerSesion(mantenerSesion);
    _print('guardadas:\n\tusuario: \'$usuario\'\n\tpassword: \'$password\'\n\tmantenerSesion: \'$mantenerSesion\'\n\tiniciarSesionAuto: \'$iniciarSesionAuto\'');
  }

  Future guardarPassword(String password) async {
    this.password = password;
    await _preferencias.setString(_passwordKey, password);
  }

  Future guardarIniciarSesionAuto(bool iniciarSesionAuto) async {
    this.iniciarSesionAuto = iniciarSesionAuto;
    await _preferencias.setBool(_iniciarSesionAutoKey, iniciarSesionAuto);
  }

  Future guardarUsuario(String usuario) async {
    this.usuario = usuario;
    await _preferencias.setString(_usuarioKey, usuario);
  }

  Future guardarMantenerSesion(bool mantenerSesion) async {
    this.mantenerSesion = mantenerSesion;
    await _preferencias.setBool(_mantenerSesionKey, mantenerSesion);
  }
  
  Future guardarPrimerUso(bool primerUso) async {
    this.primerUso = primerUso;
    await _preferencias.setBool(_primerUso, primerUso);
  }

  void _print(Object mensaje){
    print("🅿️: $mensaje");
  }
}