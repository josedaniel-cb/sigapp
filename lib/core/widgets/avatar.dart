import 'package:flutter/material.dart';
import 'package:sigapp/core/utils/ui_utils.dart';

class AvatarWidget extends StatelessWidget {
  const AvatarWidget({
    super.key,
    required this.content,
    required this.backgroundColor,
    this.diameter = 48,
  });

  final String content;
  final Color backgroundColor;
  final double diameter;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: diameter,
      height: diameter,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          content,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: UIUtils.getTextColorForBackground(backgroundColor),
            fontWeight: FontWeight.w500,
            fontSize: diameter * (1 / 2),
          ),
        ),
      ),
    );
  }
}
