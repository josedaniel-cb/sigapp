import 'package:flutter/material.dart';
import 'package:sigapp/app/app.dart';

class SigappLogotipoWidget extends StatelessWidget {
  final double fontSize;

  const SigappLogotipoWidget({super.key, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    var children = [
      TextSpan(
        text: "SIG",
        style: TextStyle(
          color: App.blueColor,
          fontSize: fontSize,
          fontFamily: "Sigapp",
        ),
      ),
      TextSpan(
        text: "App",
        style: TextStyle(
          color: App.greenColor,
          fontSize: fontSize,
          fontFamily: "Sigapp",
        ),
      ),
    ];

    if (App.beta) {
      children.add(TextSpan(
        text: " Beta",
        style: TextStyle(
            color: Colors.red,
            fontSize: fontSize * 0.3,
            fontFamily: "Sigapp",
            fontWeight: FontWeight.w500),
      ));
    }

    return RichText(
      text: TextSpan(
        children: children,
      ),
    );
  }
}
