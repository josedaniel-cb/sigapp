import 'package:flutter/material.dart';
import 'package:sigapp/app/app.dart';

class RoundContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final Color color;

  const RoundContainer({super.key, 
    required this.child,
    this.padding = const EdgeInsets.all(0),
    this.margin = const EdgeInsets.all(0),
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(App.bordeRadio)),
      ),
      padding: padding,
      margin: margin,
      child: child,
    );
  }
}
