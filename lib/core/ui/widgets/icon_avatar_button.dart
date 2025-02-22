import 'package:flutter/material.dart';
import 'package:sigapp/core/ui/utils/colors_utils.dart';

class IconAvatarButtonWidget extends StatelessWidget {
  const IconAvatarButtonWidget({
    super.key,
    required this.onPressed,
    required this.backgroundColor,
    required this.icon,
  });

  final Color backgroundColor;
  final Widget icon;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    final textColor = ColorsUtils.getTextColorForBackground(backgroundColor);

    return Ink(
      decoration: ShapeDecoration(
        color: backgroundColor,
        shape: CircleBorder(),
      ),
      child: IconButton(
        icon: icon,
        color: textColor,
        onPressed: onPressed,
      ),
    );
  }
}
