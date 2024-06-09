// import 'package:sigapp/app/app.dart';
import 'package:sigapp/widgets/simple_loading_body_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

enum MensajesTextPage { TerminosYCondiciones, NotaDeAutor }

class TextPage extends StatefulWidget {
  final MensajesTextPage cualMensaje;

  const TextPage({super.key, this.cualMensaje = MensajesTextPage.TerminosYCondiciones});

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
        // _contenido = await App.browserController.gestorFirebase
        //     .obtenerTerminosYCondiciones();

        _contenido = await Future(() {
          // Fetch data from (GET Method HTTP)
          // https://raw.githubusercontent.com/josedaniel-cb/sigapp-privacy-policy/main/terminos_y_condiciones.txt
          return http
              .get(Uri.parse(
                  'https://raw.githubusercontent.com/josedaniel-cb/sigapp-privacy-policy/main/terminos_y_condiciones.txt'))
              .then((response) {
            return response.body;
          });
        });
        break;
      case MensajesTextPage.NotaDeAutor:
        // _contenido =
        //     await App.browserController.gestorFirebase.obtenerNotaDelAutor();
        _contenido = await Future.delayed(
            const Duration(seconds: 1), () => 'No disponible');
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
