import 'dart:io';

import 'package:sigapp/app/app.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CriticalErrorMessage extends StatelessWidget {
  final String url;
  final String mensaje;

  const CriticalErrorMessage(this.url,
      {super.key, this.mensaje = 'Url no controlada'});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: AlertDialog(
        title: const Text("Ocurrió un problema"),
        content: Container(
          // color: Colors.blueGrey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '$mensaje: ',
              ),
              SelectableText(
                url,
                style: const TextStyle(
                  color: Colors.blue,
                ),
                toolbarOptions: const ToolbarOptions(
                  copy: true,
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: 15),
            child: TextButton(
              onPressed: darUnVistazo,
              child: const Text(
                "Dar un vistazo",
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 15),
            child: TextButton(
              onPressed: _entendido,
              child: const Text(
                "Entendido :/",
              ),
            ),
          ),
        ],
      ),
    );
  }

  void darUnVistazo() {
    // _launchURL(url);
    App.browserController.setVisible(true);
  }

  void _entendido() {
    exit(0);
  }

  void _launchURL(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }
}
