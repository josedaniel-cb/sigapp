// import 'package:sigapp/app/app.dart';
import 'package:sigapp/widgets/simple_loading_body_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

enum MensajesTextPage { TerminosYCondiciones, PrivacyPolicy }

class TextPage extends StatefulWidget {
  final MensajesTextPage cualMensaje;

  const TextPage(
      {super.key, this.cualMensaje = MensajesTextPage.TerminosYCondiciones});

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
      case MensajesTextPage.PrivacyPolicy:
        _titulo = 'Política de Privacidad';
        break;
    }
    _solicitarTerminos();
  }

  Future<void> _solicitarTerminos() async {
    switch (widget.cualMensaje) {
      case MensajesTextPage.TerminosYCondiciones:
        _contenido = await http
            .get(Uri.parse(
                'https://raw.githubusercontent.com/josedaniel-cb/sigapp-privacy-policy/main/terminos_y_condiciones.txt'))
            .then((response) {
          return response.body;
        }).catchError((error) {
          return 'No disponible';
        });
        break;
      case MensajesTextPage.PrivacyPolicy:
        _contenido = await http
            .get(Uri.parse(
                'https://raw.githubusercontent.com/josedaniel-cb/sigapp-privacy-policy/main/privacy_policy.txt'))
            .then((response) {
          return response.body;
        }).catchError((error) {
          return 'No disponible';
        });
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
      body: _waiting ? const SimpleLoadingBodyWidget() : _buildTerminos(),
    );
  }

  Widget _buildTerminos() {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(10),
        child: Text(
          _contenido,
          style: const TextStyle(
            color: Colors.black45,
            fontSize: 10,
          ),
        ),
      ),
    );
  }
}
