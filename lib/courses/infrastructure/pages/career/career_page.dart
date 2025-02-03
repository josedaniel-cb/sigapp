import 'package:flutter/material.dart';

class CareerPage extends StatelessWidget {
  const CareerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListTile(
          title: Text('Malla Curricular'),
        ),
        ListTile(
          title: Text('Historial Académico'),
        ),
      ],
    );
  }
}
