import 'package:SIGApp/app/app.dart';
import 'package:SIGApp/app/urls.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';

class AffectionWidget extends StatefulWidget {
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
                      TextSpan(
                          text: '\nSi no funciona como esperas lo más probable '
                              'es que el error provenga del sistema a la universidad '
                              '(lo cual es ajeno a la app). Recuerda que SIGApp '
                              'es solo un puente hacia la web del SIGA, se '
                              'basa totalmente en lo que disponga ',
                          style: TextStyle(color: Colors.black)),
                      _buildLinkText('https://academico.unp.edu.pe/',
                          () => _launchURL(Urls.INICIO_SESION)),
                      TextSpan(
                          text:
                              '.\n\nSIGApp no es una app oficial, simplemente '
                              'fue desarrollada por un unepino aficionado de '
                              'Informática que quiso mejorar '
                              'el SIGA de la UNP por su cuenta. ',
                          style: TextStyle(color: Colors.black)),
                      TextSpan(
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
          margin: EdgeInsets.only(right: 15, bottom: 6),
          child: RaisedButton(
            child: Text('Entiendo'),
            autofocus: true,
            color: Colors.blue,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      ],
    );
  }

  TextSpan _buildLinkText(String url, Function onTap) {
    return TextSpan(
      text: url,
      style: TextStyle(
        color: Colors.blue,
        // fontSize: fontSize,
        // fontWeight: FontWeight.bold,
        decoration: TextDecoration.underline,
      ),
      recognizer: TapGestureRecognizer()..onTap = onTap,
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
