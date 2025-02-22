import 'package:flutter/material.dart';
import 'package:sigapp/core/utils/ui_utils.dart';

class UserAvatarWidget extends StatelessWidget {
  const UserAvatarWidget({
    super.key,
    this.onPressed,
  });

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Theme.of(context).primaryColor;
    final textColor = UIUtils.getTextColorForBackground(backgroundColor);
    return Ink(
      decoration: ShapeDecoration(
        color: backgroundColor,
        shape: CircleBorder(),
      ),
      child: IconButton(
        icon: const Icon(Icons.person),
        color: textColor,
        onPressed: () {},
      ),
    );
  }
}
