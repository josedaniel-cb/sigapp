import 'package:flutter/material.dart';
import 'package:sigapp/core/ui/utils/colors_utils.dart';

class InitialsAvatarWidget extends StatelessWidget {
  const InitialsAvatarWidget({
    super.key,
    required this.content,
    required this.backgroundColor,
    this.diameter,
    this.onPressed,
    this.enableGradient = false,
    this.shape = BoxShape.circle,
  });

  final String content;
  final Color backgroundColor;
  final double? diameter;
  final void Function()? onPressed;
  final bool enableGradient;
  final BoxShape shape;

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
    final diameter = this.diameter ?? 48.0;
    return Container(
      width: diameter,
      height: diameter,
      decoration: enableGradient
          ? BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  backgroundColor.withValues(alpha: 0.5),
                  backgroundColor,
                  backgroundColor.withValues(alpha: 0.7),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
            )
          : BoxDecoration(
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
            fontSize: diameter * (2 / 5),
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
