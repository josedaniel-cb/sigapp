import 'package:flutter/material.dart';

class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Créditos: 32'),
            OutlinedButton(
              onPressed: () {},
              child: Row(
                children: [
                  const Text('2021-2'),
                  Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
