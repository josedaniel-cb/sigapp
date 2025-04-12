import 'package:flutter/material.dart';

class EmptyCoursesWidget extends StatelessWidget {
  const EmptyCoursesWidget({super.key, this.message});

  final String? message;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.info_outline, size: 80, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            message ?? "No tienes cursos inscritos este semestre",
            style: TextStyle(fontSize: 18, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
