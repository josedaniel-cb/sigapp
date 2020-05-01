import 'package:flutter/material.dart';

class SimpleLoadingBodyWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Center(
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