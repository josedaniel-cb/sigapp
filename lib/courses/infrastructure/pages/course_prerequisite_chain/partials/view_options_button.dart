import 'package:flutter/material.dart';
import 'package:sigapp/courses/infrastructure/pages/course_prerequisite_chain/course_prerequisite_chain_page.dart';

class ViewOptionsButton extends StatelessWidget {
  final CoursePrerequisiteChainViewMode viewMode;
  final bool highlightCriticalPath;
  final VoidCallback onPressed;

  const ViewOptionsButton({
    super.key,
    required this.viewMode,
    required this.highlightCriticalPath,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FloatingActionButton(
      onPressed: onPressed,
      tooltip: 'Opciones de visualización',
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(
            viewMode == CoursePrerequisiteChainViewMode.tree
                ? Icons.account_tree
                : Icons.view_list,
            size: 24,
          ),
          if (highlightCriticalPath)
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: theme.colorScheme.surface,
                    width: 1,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
