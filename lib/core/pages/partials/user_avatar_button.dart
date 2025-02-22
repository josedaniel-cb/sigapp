import 'package:flutter/material.dart';
import 'package:sigapp/core/utils/ui_utils.dart';
import 'package:sigapp/core/widgets/brand_text.dart';

class UserAvatarButtonWidget extends StatelessWidget {
  const UserAvatarButtonWidget({
    super.key,
    // this.onPressed,
  });

  // final void Function()? onPressed;

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
        onPressed: () {
          _showDialog(context);
        },
      ),
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(),
              BrandTextWidget(
                fontSize: Theme.of(context).textTheme.headlineLarge?.fontSize,
              ),
              Container(),
            ],
          ),
          content: const Text('This is the user avatar dialog'),
          // actions: <Widget>[
          //   TextButton(
          //     onPressed: () {
          //       Navigator.of(context).pop();
          //     },
          //     child: const Text('Close'),
          //   ),
          // ],
        );
      },
    );
  }
}
