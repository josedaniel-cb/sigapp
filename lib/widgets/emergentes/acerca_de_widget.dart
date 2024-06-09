import 'package:sigapp/pages/about_page.dart';
import 'package:sigapp/pages/easter_egg_page.dart';
import 'package:sigapp/widgets/sigapp_info/sigapp_logotipo_widget.dart';
import 'package:sigapp/widgets/sigapp_info/sigapp_version_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AcercaDeWidget extends StatelessWidget {
  final double fontSize = 15;

  const AcercaDeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: _buildAlertDialogContent(context),
      actions: _buildActions(context),
    );
  }

  Widget _buildAlertDialogContent(BuildContext context) {
    return SizedBox(
      // color: Colors.red,
      width: double.maxFinite,
      height: 200,
      child: Scrollbar(
        child: ListView(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 25),
              child: _buildTitle(context),
            ),
            Container(
              child: _buildContent(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // SigappLogotipoWidget(
        //   fontSize: fontSize * 3.1,
        // ),
        GestureDetector(
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
            fontSize: fontSize * 3.1,
          ),
        ),
        SigappVersionWidget(
          fontSize: fontSize * .85,
        ),
      ],
    );
  }

  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        RichText(
          // textAlign: TextAlign.justify,
          text: TextSpan(
            children: [
              _buildDefaultText('Desarrollada con Flutter 1.15.17.\n'
                  '¿Te gustaria que la app fuera de código abierto? '
                  'Haz click en Leer más.'),
              // _buildLinkText(
              //   'Házmelo saber',
              //   () => launch(Urls.PERFIL_FACEBOOK)
              // ),
              // _buildDefaultText('.'),
            ],
          ),
        )
      ],
    );
  }

  TextSpan _buildLinkText(String url, Function onTap) {
    return TextSpan(
      text: url,
      style: TextStyle(
        color: Colors.blue,
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        decoration: TextDecoration.underline,
      ),
      recognizer: TapGestureRecognizer()..onTap = onTap as void Function()?,
    );
  }

  TextSpan _buildDefaultText(String text) {
    return TextSpan(
      text: text,
      style: TextStyle(
        fontSize: fontSize,
        color: Colors.black,
      ),
    );
  }

  List<Widget> _buildActions(BuildContext context) {
    return <Widget>[
      // onPressed: (){
      //   Navigator.pop(context);
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context){
      //         return EasterEggPage();
      //       }
      //     ),
      //   );
      // },
      Container(
        margin: const EdgeInsets.only(
            // right: 8,
            bottom: 10),
        child: TextButton(
          child: Text(
            "Entendido",
            style: TextStyle(
              fontSize: fontSize * 1.05,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      Container(
        margin: const EdgeInsets.only(right: 15, bottom: 10),
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Colors.blue),
          ),
          onPressed: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return const AboutPage();
              }),
            );
          },
          child: Text(
            "Leer más",
            style: TextStyle(
              color: Colors.white,
              fontSize: fontSize * 1.05,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ];
  }
}
