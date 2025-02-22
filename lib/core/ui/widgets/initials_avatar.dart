import 'package:flutter/material.dart';
import 'package:sigapp/core/ui/utils/colors_utils.dart';

class InitialsAvatarWidget extends StatelessWidget {
  const InitialsAvatarWidget({
    super.key,
    required this.content,
    required this.backgroundColor,
    this.diameter = 48,
    this.onPressed,
  });

  final String content;
  final Color backgroundColor;
  final double diameter;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    if (onPressed == null) {
      return _buildAvatar();
    }
    return _CircleIconButton(
      onTap: onPressed!,
      child: _buildAvatar(),
    );
  }

  Container _buildAvatar() {
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
            color: ColorsUtils.getTextColor(backgroundColor),
            fontWeight: FontWeight.w500,
            fontSize: diameter * (1 / 2),
          ),
        ),
      ),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  final void Function() onTap;
  final Color splashColor;
  final Widget child;

  const _CircleIconButton({
    required this.child,
    required this.onTap,
    this.splashColor = Colors.white60,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        child,
        Positioned.fill(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onTap,
                splashColor: splashColor,
                hoverColor: Colors.transparent,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
