import 'package:flutter/material.dart';
import 'package:sigapp/core/infrastructure/ui/utils/colors_utils.dart';
import 'package:sigapp/core/infrastructure/ui/widgets/avatar.dart';

class InitialsAvatarWidget extends StatelessWidget {
  const InitialsAvatarWidget({
    super.key,
    required this.content,
    required this.backgroundColor,
    this.diameter,
    this.onPressed,
    this.enableGradient = false,
  });

  final String content;
  final Color backgroundColor;
  final double? diameter;
  final void Function()? onPressed;
  final bool enableGradient;

  @override
  Widget build(BuildContext context) {
    return AvatarWidget(
      backgroundColor: backgroundColor,
      diameter: diameter,
      onPressed: onPressed,
      enableGradient: enableGradient,
      child: Text(
        content,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: ColorsUtils.getTextColor(backgroundColor),
          fontWeight: FontWeight.w500,
          fontSize: (diameter ?? 48) * (2 / 5),
        ),
      ),
    );
  }
}
