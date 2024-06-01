import 'dart:io';
import 'package:SIGApp/app/app.dart';
import 'package:SIGApp/pages/text_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class TerminosWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TerminosWidget();
}

class _TerminosWidget extends State<TerminosWidget> {
  bool terminosAceptados = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => null,
      child: AlertDialog(
        // title: Text("T"),
        content: Container(
          // color: Colors.blueGrey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Checkbox(
                    value: terminosAceptados,
                    onChanged: (ban) {
                      setState(() {
                        terminosAceptados = ban;
                      });
                    },
                  ),
                  Expanded(
                    child: RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: 'Acepto los ',
                            style: TextStyle(
                              color: Colors.black,
                            )),
                        _buildLinkText('Términos y Condiciones de Uso', () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TextPage(),
                            ),
                          );
                        }),
                        TextSpan(
                            text: '.',
                            style: TextStyle(
                              color: Colors.black,
                            )),
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
            margin: EdgeInsets.only(right: 15),
            child: TextButton(
              child: Text(
                "Continuar",
              ),
              onPressed: continuarPressed,
            ),
          ),
        ],
      ),
    );
  }

  void continuarPressed() {
    if (terminosAceptados) {
      App.browserController.preferencias.guardarPrimerUso(false);
      Navigator.pop(context);
    } else {
      exit(0);
    }
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
}
