import 'package:flutter/material.dart';

class AvatarWidget extends StatelessWidget {
  const AvatarWidget({
    super.key,
    required this.backgroundColor,
    this.diameter,
    this.onPressed,
    this.enableGradient = false,
    required this.child,
  });

  final Color backgroundColor;
  final double? diameter;
  final void Function()? onPressed;
  final bool enableGradient;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (onPressed == null) {
      return _buildAvatar();
    }
    return _TapRegion(
      onTap: onPressed!,
      child: _buildAvatar(),
    );
  }

  Widget _buildAvatar() {
    final diameter = this.diameter ?? 48.0;
    return _AvatarContainer(
      backgroundColor: backgroundColor,
      diameter: diameter,
      enableGradient: enableGradient,
      child: child,
    );
  }
}

class _AvatarContainer extends StatelessWidget {
  const _AvatarContainer({
    required this.backgroundColor,
    this.diameter,
    required this.enableGradient,
    required this.child,
  });

  final Color backgroundColor;
  final double? diameter;
  final bool enableGradient;
  final Widget child;

  @override
  Widget build(BuildContext context) {
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
        child: child,
      ),
    );
  }
}

class _TapRegion extends StatelessWidget {
  final void Function() onTap;
  final Color splashColor;
  final Widget child;

  const _TapRegion({
    required this.child,
    required this.onTap,
    Color? splashColor,
  }) : splashColor = splashColor ?? Colors.white60;

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
