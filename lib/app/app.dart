import 'dart:io';

import 'package:SIGApp/app/urls.dart';
import 'package:SIGApp/browser/gestor_firebase.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:screenshot/screenshot.dart';
import 'package:SIGApp/browser/browser_controller.dart';
import 'package:flutter/services.dart' show rootBundle;

class App {
  // App info
  static String version = '1.1.1+1';
  static bool beta = false;
  static String versionFlutter = '1.17.5';

  // Navegador
  static BrowserController browserController;

  // Colores
  static MaterialColor getMaterialColor(int hexColor) {
    return MaterialColor(hexColor, {
      50: Color(hexColor),
      100: Color(hexColor),
      200: Color(hexColor),
      300: Color(hexColor),
      400: Color(hexColor),
      500: Color(hexColor),
      600: Color(hexColor),
      700: Color(hexColor),
      800: Color(hexColor),
      900: Color(hexColor),
    });
  }

  static const int _hexBlueColor = 0xFF036FB8;

  static const int _hexGreenColor = 0xFF03D5B8;

  static MaterialColor get blueColor => getMaterialColor(_hexBlueColor);

  static MaterialColor get greenColor => getMaterialColor(_hexGreenColor);

  // Otros
  static const double bordeRadio = 10;

  // Utilidades
  static void showToast(String mensaje, {int duracionSegundos = 3}) {
    BotToast.cleanAll();
    BotToast.showText(
        text: mensaje, duration: Duration(seconds: duracionSegundos));
  }

  static Future compartirCaptura(ScreenshotController screenshotController,
      String fileName, String descripcion) async {
    screenshotController.capture().then((File image) async {
      await Share.file(
          'Compartir', '$fileName.png', image.readAsBytesSync(), 'image/png',
          text: descripcion);
    }).catchError((onError) {
      print(onError);
    });
  }

  static Future compartirTexto(String text) {
    Share.text('Compartir', text, 'text/plain');
  }

  static Future compartirImagen(
      List<int> bytes, String fileName, String descripcion) async {
    Share.file('Compartir', '$fileName.png', bytes, 'image/png',
        text: descripcion);
  }

  static void compartirApp() {
    App.browserController.gestorFirebase.registrarUso(CasosDeUso.CompartirApp);
    rootBundle.load('assets/images/compartir_imagen.png').then((data) {
      App.compartirImagen(
          data.buffer.asUint8List(),
          'a_whatsapp_p_aqui_No',
          'Unepino(a), descarga la app del SIGA (no oficial) desde el siguiente enlace: '
              '${Urls.DESCARGAR_PLAYSTORE}\n'
              // 'Bon appetit' //📌📍 ✂️ 🖊 🖋 ✒️ 🖌 🖍 📝 ✏️ 🔍 🔎 🕹 🤟 🤘 👌
              // '👉\tPara Android 6 o inferior asegurarse de activar orígenes desconocidos en ajustes\n👌\tBon appetit'
              '👌\tBon appetit');
    });
  }
}
