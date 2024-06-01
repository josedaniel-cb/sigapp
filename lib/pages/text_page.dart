import 'package:SIGApp/app/app.dart';
import 'package:SIGApp/browser/gestor_firebase.dart';
import 'package:SIGApp/widgets/simple_loading_body_widget.dart';
import 'package:flutter/material.dart';

enum MensajesTextPage { TerminosYCondiciones, NotaDeAutor }

class TextPage extends StatefulWidget {
  final MensajesTextPage cualMensaje;

  TextPage({this.cualMensaje = MensajesTextPage.TerminosYCondiciones});

  @override
  State<StatefulWidget> createState() => TextPageState();
}

class TextPageState extends State<TextPage> {
  bool _waiting = true;
  String _contenido = '', _titulo = '';

  @override
  void initState() {
    super.initState();
//     App.browserController.gestorFirebase.registrarUso(CasosDeUso.TerminosYCondiciones);
    switch (widget.cualMensaje) {
      case MensajesTextPage.TerminosYCondiciones:
        _titulo = 'Términos y Condiciones de Uso';
        break;
      case MensajesTextPage.NotaDeAutor:
        _titulo = 'Nota del Autor';
        break;
    }
    _solicitarTerminos();
  }

  Future<void> _solicitarTerminos() async {
    switch (widget.cualMensaje) {
      case MensajesTextPage.TerminosYCondiciones:
        _contenido = await App.browserController.gestorFirebase
            .obtenerTerminosYCondiciones();
        break;
      case MensajesTextPage.NotaDeAutor:
        _contenido =
            await App.browserController.gestorFirebase.obtenerNotaDelAutor();
        break;
    }
    setState(() => _waiting = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titulo),
      ),
      body: _waiting ? SimpleLoadingBodyWidget() : _buildTerminos(),
    );
  }

  Widget _buildTerminos() {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(10),
        child: Text(
          _contenido,
          style: TextStyle(
            color: Colors.black45,
            fontSize: 10,
          ),
        ),
      ),
    );
  }
}
