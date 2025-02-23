import 'package:flutter/material.dart';

class LoadingIndicatorIconWidget extends StatelessWidget {
  const LoadingIndicatorIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Icon(Icons.abc, color: Colors.transparent),
        Positioned.fill(child: CircularProgressIndicator()),
      ],
    );
  }
}
