import 'package:sigapp/app/app.dart';
import 'package:flutter/material.dart';

class SigappVersionWidget extends StatelessWidget {
  final double fontSize;

  const SigappVersionWidget({super.key, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            child: Text(
              "Version ${App.version}\nMade by josedaniel-cb",
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Colors.grey,
                fontSize: fontSize * .85,
              ),
            ),
          ),
        )
      ],
    );
  }
}
