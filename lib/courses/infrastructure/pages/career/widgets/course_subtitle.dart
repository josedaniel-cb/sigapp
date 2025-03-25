import 'package:flutter/material.dart';

class CourseSubtitleWidgetItem {
  final String text;
  final IconData? icon;

  CourseSubtitleWidgetItem({required this.text, this.icon});
}

class CourseSubtitleWidget extends StatelessWidget {
  const CourseSubtitleWidget({super.key, required this.children});

  final List<CourseSubtitleWidgetItem> children;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 6,
      runSpacing: 4,
      children: _join(
          children
              .map((item) => _buildInfo(
                    text: item.text,
                    icon: item.icon,
                  ))
              .toList(),
          Text('•')),
    );
  }

  Widget _buildInfo({
    required String text,
    IconData? icon,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          Icon(icon, size: 16),
          SizedBox(width: 4),
        ],
        Text(text),
      ],
    );
  }

  List<Widget> _join(List<Widget> list, Widget separator) {
    final result = <Widget>[];
    for (var i = 0; i < list.length; i++) {
      result.add(list[i]);
      if (i < list.length - 1) {
        result.add(separator);
      }
    }
    return result;
  }
}
