import 'package:sigapp/app/app.dart';
import 'package:sigapp/app/urls.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';

class AffectionWidget extends StatefulWidget {
  const AffectionWidget({super.key});

  @override
  State<StatefulWidget> createState() => _AffectionWidget();
}

class _AffectionWidget extends State<AffectionWidget> {
  bool terminosAceptados = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                          text: 'Querido unepino,\n',
                          style: TextStyle(
                              color: App.darkGreenColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 30)),
                      TextSpan(
                          text: 'esta app fue realizada con cariño para ti\n',
                          style: TextStyle(
                              color: App.darkGreenColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18)),
                      const TextSpan(
                          text: '\nSi no funciona como esperas lo más probable '
                              'es que el error provenga del sistema a la universidad '
                              '(lo cual es ajeno a la app). Recuerda que SIGApp '
                              'es solo un puente hacia la web del SIGA, se '
                              'basa totalmente en lo que disponga ',
                          style: TextStyle(color: Colors.black)),
                      _buildLinkText('https://academico.unp.edu.pe/',
                          () => _launchURL(Urls.INICIO_SESION)),
                      const TextSpan(
                          text:
                              '.\n\nSIGApp no es una app oficial, simplemente '
                              'fue desarrollada por un unepino aficionado de '
                              'Informática que quiso mejorar '
                              'el SIGA de la UNP por su cuenta. ',
                          style: TextStyle(color: Colors.black)),
                      const TextSpan(
                          text: 'Por favor no la '
                              'califiques mal en la Play Store. En su lugar, '
                              'espera a que la universidad resuelva el '
                              'inconveniente y vuelve a intentar.',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                    ]),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: <Widget>[
        Container(
          margin: const EdgeInsets.only(right: 15, bottom: 6),
          child: ElevatedButton(
            autofocus: true,
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(Colors.blue),
            ),
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Entiendo'),
          ),
        ),
      ],
    );
  }

  TextSpan _buildLinkText(String url, Function onTap) {
    return TextSpan(
      text: url,
      style: const TextStyle(
        color: Colors.blue,
        // fontSize: fontSize,
        // fontWeight: FontWeight.bold,
        decoration: TextDecoration.underline,
      ),
      recognizer: TapGestureRecognizer()..onTap = onTap as void Function()?,
    );
  }

  void _launchURL(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }
}
