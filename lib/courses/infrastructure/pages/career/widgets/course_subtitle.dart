import 'package:flutter/material.dart';

class CourseSubtitleWidgetItem {
  final String text;
  final IconData? icon;
  final bool? loading;

  CourseSubtitleWidgetItem({
    required this.text,
    this.icon,
    this.loading,
  });
}

class CourseSubtitleWidget extends StatelessWidget {
  const CourseSubtitleWidget({super.key, required this.children});

  final List<CourseSubtitleWidgetItem> children;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 6,
      runSpacing: 4,
      children:
          _join(children.map((item) => _buildInfo(item)).toList(), Text('•')),
    );
  }

  Widget _buildInfo(CourseSubtitleWidgetItem item) {
    final children = <Widget>[Text(item.text)];
    final iconSize = 14.0;
    if (item.loading == true) {
      children.insertAll(0, [
        SizedBox(
          height: iconSize,
          width: iconSize,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
        SizedBox(width: 4),
      ]);
    } else if (item.icon != null) {
      children.insertAll(0, [
        Icon(item.icon, size: iconSize),
        SizedBox(width: 4),
      ]);
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: children,
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
