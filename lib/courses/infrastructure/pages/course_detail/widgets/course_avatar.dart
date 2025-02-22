import 'package:flutter/material.dart';
import 'package:sigapp/core/injection/get_it.dart';
import 'package:sigapp/core/widgets/initials_avatar.dart';
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

    return InitialsAvatarWidget(
      content: initials,
      backgroundColor: backgroundColor,
    );
  }
}
