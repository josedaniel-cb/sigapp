import 'package:flutter/material.dart';
import 'package:sigapp/core/injection/get_it.dart';
import 'package:sigapp/core/ui/widgets/initials_avatar.dart';
import 'package:sigapp/courses/domain/services/course_service.dart';

class CourseAvatarWidget extends StatelessWidget {
  CourseAvatarWidget({
    super.key,
    required this.courseName,
    required this.color,
  });

  final String courseName;
  final Color color;

  final _courseService = getIt<CourseService>();

  @override
  Widget build(BuildContext context) {
    final initials = _courseService.extractInitials(courseName);
    return InitialsAvatarWidget(
      content: initials,
      backgroundColor: color,
    );
  }
}
