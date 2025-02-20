import 'package:flutter/material.dart';
import 'package:sigapp/core/injection/get_it.dart';
import 'package:sigapp/courses/domain/services/course_service.dart';

class CourseAvatarWidget extends StatelessWidget {
  CourseAvatarWidget({
    super.key,
    required this.courseName,
    required this.courseCode,
  });

  final String courseName;

  final String courseCode;

  final _courseService = getIt<CourseService>();

  @override
  Widget build(BuildContext context) {
    final initials = _courseService.extractInitials(courseName);
    final backgroundColor =
        Color(_courseService.getBackgroundColor(courseName));

    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          initials,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 8 * 2,
          ),
        ),
      ),
    );
  }
}
