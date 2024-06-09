import 'package:flutter/material.dart';

class SimpleLoadingBodyWidget extends StatelessWidget{
  const SimpleLoadingBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        width: 30.0,
        height: 30.0,
        child: CircularProgressIndicator(
          strokeWidth: 3,
        ),
      ),
    );
  }

}