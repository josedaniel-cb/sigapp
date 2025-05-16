import 'package:flutter/material.dart';
import 'package:sigapp/courses/infrastructure/pages/course_prerequisite_chain/course_prerequisite_chain_page.dart';

class ViewOptionsSheetWidget extends StatelessWidget {
  final CoursePrerequisiteChainViewMode viewMode;
  final bool highlightCriticalPath;
  final VoidCallback onTree;
  final VoidCallback onList;
  final VoidCallback onCritical;

  const ViewOptionsSheetWidget({
    super.key,
    required this.viewMode,
    required this.highlightCriticalPath,
    required this.onTree,
    required this.onList,
    required this.onCritical,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.account_tree),
            title: const Text('Vista árbol'),
            selected: viewMode == CoursePrerequisiteChainViewMode.tree,
            onTap: onTree,
          ),
          ListTile(
            leading: const Icon(Icons.view_list),
            title: const Text('Vista lista'),
            selected: viewMode == CoursePrerequisiteChainViewMode.list,
            onTap: onList,
          ),
          const Divider(),
          ListTile(
            leading: Icon(
              highlightCriticalPath ? Icons.visibility_off : Icons.alt_route,
            ),
            title:
                highlightCriticalPath
                    ? RichText(
                      text: TextSpan(
                        style: Theme.of(
                          context,
                        ).textTheme.bodyLarge?.copyWith(fontSize: 18),
                        children: [
                          const TextSpan(
                            text: 'Ocultar ',
                            children: [
                              TextSpan(
                                text: 'ruta crítica',
                                style: TextStyle(color: Colors.orange),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                    : const Text('Mostrar ruta crítica'),
            onTap: onCritical,
          ),
        ],
      ),
    );
  }
}
