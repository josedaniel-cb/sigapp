import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyCoursesWidget extends StatelessWidget {
  const EmptyCoursesWidget({super.key, this.message, this.lottiePath});

  final String? message;
  final String? lottiePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (lottiePath != null)
            Lottie.asset(
              lottiePath!,
              height: MediaQuery.of(context).size.width * 0.5,
            )
          else
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
