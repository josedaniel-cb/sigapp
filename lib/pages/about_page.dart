import 'package:sigapp/app/app.dart';
import 'package:sigapp/app/urls.dart';
import 'package:sigapp/pages/easter_egg_page.dart';
import 'package:sigapp/pages/text_page.dart';
import 'package:sigapp/widgets/sigapp_info/sigapp_logotipo_widget.dart';
import 'package:sigapp/widgets/sigapp_info/sigapp_version_widget.dart';
// import 'package:clipboard_manager/clipboard_manager.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<StatefulWidget> createState() => AboutPageState();
}

class AboutPageState extends State<AboutPage> {
  static String? notaDelAutorCache;
  final double fontSize = 14;
  String? notaDeAutor;

  @override
  void initState() {
    super.initState();
    // rootBundle.load('assets/nota_del_autor.txt').then((data){
    //   setState(() {
    //     notaDeAutor = utf8.decode(data.buffer.asUint8List());
    //   });
    // });
    if (notaDelAutorCache == null) {
      // App.browserController.gestorFirebase.obtenerNotaDelAutor().then((data) {
      //   setState(() {
      //     notaDelAutorCache = data;
      //     notaDeAutor = data;
      //   });
      // });
    } else {
      notaDeAutor = notaDelAutorCache;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
        backgroundColor: App.greenColor,
        actions: const [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: App.compartirApp,
          ),
        ],
      ),
      // body: Container(child: _buildBody(), color: Colors.white,),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Column(
      children: <Widget>[
        Expanded(
            child: Container(
          child: ListView(
            children: <Widget>[
              _buildContenido(),
            ],
          ),
        )),
      ],
    );
  }

  Widget _buildContenido() {
    return Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 17, vertical: 13),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    // child: SigappLogotipoWidget(fontSize: fontSize*3.5),
                    child: GestureDetector(
                      onDoubleTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return const EasterEggPage();
                          }),
                        );
                      },
                      child: SigappLogotipoWidget(
                        fontSize: fontSize * 3.5,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: SigappVersionWidget(fontSize: fontSize),
              ),
              // Row(
              //   children: <Widget>[
              //     Expanded(
              //       child: Row(
              //         children: <Widget>[
              //           RichText(
              //             text: TextSpan(
              //               children: [
              //                 _buildDefaultText('Desarrollada con ',
              //                     color: Colors.black),
              //               ],
              //             ),
              //           ),
              //           const FlutterLogo(
              //             size: 12,
              //           ),
              //           RichText(
              //             text: TextSpan(
              //               children: [
              //                 _buildDefaultText(
              //                     ' Flutter ${App.versionFlutter}',
              //                     color: Colors.black),
              //               ],
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ],
              // ),
              // RichText(
              //   // textAlign: TextAlign.justify,
              //   text: TextSpan(
              //     children: [
              //       // _buildDefaultText(
              //       //   'Se recomienda Android 5 Lollipop en adelante.'
              //       //   '\n\n',
              //       //   color: Colors.black,
              //       // ),
              //       _buildDefaultText(
              //         '\n\t\t\t\tDe la UNP para la UNP\n',
              //         color: const Color(0xFFc2453c),
              //         size: 14,
              //       ),
              //       _buildDefaultText(
              //         '\t\t\t\t\t\t\t\t#UniversidadNacionalDePiura\t\t☄️' //☄️🌠
              //         '\n\n',
              //         color: const Color(0xFFc2453c),
              //         size: 14.5,
              //         bold: true,
              //       ),
              //       _buildDefaultText(
              //           '¿Desearías que fuera de código abierto? '
              //           '¿Te gustaría apoyar el proyecto? '
              //           '¿Quieres reportar algún problema o tienes alguna sugerencia? '
              //           'Escríbeme a mi ',
              //           color: Colors.black),
              //       _buildLinkText('email', () {
              //         // ClipboardManager.copyToClipBoard(Urls.EMAIL).then((result) {
              //         //   App.showToast('Copiado en portapapeles');
              //         // });
              //         Clipboard.setData(const ClipboardData(text: Urls.EMAIL))
              //             .then((value) {
              //           App.showToast('Copiado en portapapeles');
              //         });
              //       }),
              //       _buildDefaultText(' o a ', color: Colors.black),
              //       _buildLinkText(
              //           'facebook', () => launch(Urls.PERFIL_FACEBOOK)),
              //       // _buildLinkText(
              //       //   'Escríbeme aquí',
              //       //   () => launch(Urls.PERFIL_FACEBOOK)
              //       // ),
              //       _buildDefaultText('.\n', color: Colors.black),

              //       // // Enlace de descarga
              //       // _buildDefaultText(
              //       //   '\nActualmente esta app no está disponible en Play Store. Enlace de descarga: '
              //       //   , color: Colors.black
              //       // ),
              //       // _buildLinkText(
              //       //   'MEGA',
              //       //   () => launch(Urls.DESCARGAR)
              //       // ),
              //       // _buildDefaultText('\n', color: Colors.black),
              //     ],
              //   ),
              // ),
              // Row(
              //   mainAxisSize: MainAxisSize.max,
              //   children: <Widget>[
              //     SizedBox(
              //       // margin: EdgeInsets.all(10),
              //       height: 18,
              //       child: Image.asset('assets/images/by-nc.png'),
              //     ),
              //     RichText(
              //       text: TextSpan(
              //         children: [
              //           _buildDefaultText('\t\tVer ', color: Colors.black),
              //           _buildLinkText('Términos y Condiciones de uso', () {
              //             Navigator.push(
              //               context,
              //               MaterialPageRoute(
              //                 builder: (context) => const TextPage(),
              //               ),
              //             );
              //           }),
              //           _buildDefaultText('.',
              //               color: Colors.black), // dont touch
              //         ],
              //       ),
              //     ),
              //   ],
              // ),
              // _buildNotaDeAutor(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNotaDeAutor() {
    if (notaDeAutor != null) {
      return RichText(
        text: TextSpan(
          children: [
            _buildDefaultText('\n\n🕷\t$notaDeAutor'),
          ],
        ),
      );
    } else {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 80),
        child: const SizedBox(
          width: 30.0,
          height: 30.0,
          child: CircularProgressIndicator(
            strokeWidth: 3,
          ),
        ),
      );
    }
  }

  TextSpan _buildLinkText(String url, Function onTap) {
    return TextSpan(
      text: url,
      style: TextStyle(
        color: Colors.blue,
        fontSize: fontSize,
        // fontWeight: FontWeight.bold,
        decoration: TextDecoration.underline,
      ),
      recognizer: TapGestureRecognizer()..onTap = onTap as void Function()?,
    );
  }

  TextSpan _buildDefaultText(String text,
      {Color? color, double? size, bool bold = false}) {
    return TextSpan(
      text: text,
      style: TextStyle(
        fontSize: size ?? fontSize,
        color: color ?? Colors.black54,
        fontWeight: bold ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }
}
