import 'package:flutter/services.dart';
import 'package:sigapp/app/app.dart';
import 'package:sigapp/pages/text_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class TerminosWidget extends StatefulWidget {
  const TerminosWidget({super.key});

  @override
  State<StatefulWidget> createState() => _TerminosWidget();
}

class _TerminosWidget extends State<TerminosWidget> {
  bool? terminosAceptados = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: AlertDialog(
        content: Container(
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
                        const TextSpan(
                            text: 'Acepto los ',
                            style: TextStyle(
                              color: Colors.black,
                            )),
                        _buildLinkText('Términos y Condiciones de Uso', () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const TextPage(),
                            ),
                          );
                        }),
                        const TextSpan(
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
            margin: const EdgeInsets.only(right: 15),
            child: TextButton(
              onPressed: continuarPressed,
              child: const Text(
                "Continuar",
              ),
            ),
          ),
        ],
      ),
    );
  }

  void continuarPressed() {
    if (terminosAceptados!) {
      App.browserController.preferencias!.guardarPrimerUso(false);
      Navigator.pop(context);
    } else {
      SystemNavigator.pop();
    }
  }

  TextSpan _buildLinkText(String url, Function onTap) {
    return TextSpan(
      text: url,
      style: const TextStyle(
        color: Colors.blue,
        decoration: TextDecoration.underline,
      ),
      recognizer: TapGestureRecognizer()..onTap = onTap as void Function()?,
    );
  }
}
