import 'dart:io';

import 'package:SIGApp/app/app.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CriticalErrorMessage extends StatelessWidget{
  final String url;
  final String mensaje;

  const CriticalErrorMessage(this. url, {this.mensaje = 'Url no controlada'});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (() => null) as Future<bool> Function()?,
      child: AlertDialog(
        title: Text("Ocurrió un problema"),
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
                style: TextStyle(
                  color: Colors.blue,
                ),
                toolbarOptions: ToolbarOptions(
                  copy: true,
                ),                  
              ),
            ],
          ),
        ),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 15),
            child: TextButton(
              child: Text(
                "Dar un vistazo",
              ),
              onPressed: darUnVistazo,
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 15),
            child: TextButton(
              child: Text(
                "Entendido :/",
              ),
              onPressed: _entendido,
            ),
          ),
        ],
      ),
    );
  }

  void darUnVistazo(){
    // _launchURL(url);
    App.browserController.setVisible(true);
  }

  void _entendido(){
    exit(0);
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

}