import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sigapp/courses/domain/entities/course_type.dart';
import 'package:sigapp/courses/domain/entities/program_curriculum_course_term.dart';
import 'package:sigapp/courses/infrastructure/pages/career/widgets/course_subtitle.dart';

enum _ViewMode { tree, list }

class CoursePrerequisiteChainPage extends StatefulWidget {
  const CoursePrerequisiteChainPage({
    super.key,
    required this.programCurriculum,
    required this.course,
  });

  final ProgramCurriculumCourse course;
  final List<ProgramCurriculumTerm> programCurriculum;

  @override
  State<CoursePrerequisiteChainPage> createState() =>
      _CoursePrerequisiteChainPageState();
}

class _CoursePrerequisiteChainPageState
    extends State<CoursePrerequisiteChainPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  // Filtros para requisitos
  bool _showMandatoryReq = true;
  bool _showElectiveReq = true;
  String _approvalFilterReq = 'todos';
  // Filtros para dependientes
  bool _showMandatoryDep = true;
  bool _showElectiveDep = true;
  String _approvalFilterDep = 'todos';
  bool _highlightCriticalPath = false;
  Set<String> _criticalPathIds = {};

  _ViewMode _viewMode = _ViewMode.tree;

  void _toggleCriticalPath(CourseTreeNode? root) {
    if (!_highlightCriticalPath) {
      // Calcular la ruta crítica solo si se va a activar
      final path = _findCriticalPath(root);
      setState(() {
        _highlightCriticalPath = true;
        _criticalPathIds = path.map((n) => n.course.info.courseCode).toSet();
      });
    } else {
      setState(() {
        _highlightCriticalPath = false;
        _criticalPathIds = {};
      });
    }
  }

  List<CourseTreeNode> _findCriticalPath(CourseTreeNode? node) {
    if (node == null) return [];
    if (node.children.isEmpty) return [node];
    List<CourseTreeNode> longest = [];
    for (final child in node.children) {
      final path = _findCriticalPath(child);
      if (path.length > longest.length) longest = path;
    }
    return [node, ...longest];
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    // Selecciona automáticamente 'Dependientes' si no hay requisitos
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final prerequisiteCoursesTree = widget.course.getPrerequisiteCoursesTree(
        programCurriculum: widget.programCurriculum,
      );
      if (prerequisiteCoursesTree == null) {
        _tabController.index = 1;
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final prerequisiteCoursesTree = widget.course.getPrerequisiteCoursesTree(
      programCurriculum: widget.programCurriculum,
    );
    final dependentCoursesTree = widget.course.getDependentCoursesTree(
      programCurriculum: widget.programCurriculum,
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadena de requisitos'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [Tab(text: 'Requisitos'), Tab(text: 'Dependientes')],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildTabSection(
            context,
            tree: prerequisiteCoursesTree,
            showMandatory: _showMandatoryReq,
            showElective: _showElectiveReq,
            approvalFilter: _approvalFilterReq,
            onMandatoryChanged: (v) => setState(() => _showMandatoryReq = v),
            onElectiveChanged: (v) => setState(() => _showElectiveReq = v),
            onApprovalChanged: (v) => setState(() => _approvalFilterReq = v),
            subtitle: '',
          ),
          _buildTabSection(
            context,
            tree: dependentCoursesTree,
            showMandatory: _showMandatoryDep,
            showElective: _showElectiveDep,
            approvalFilter: _approvalFilterDep,
            onMandatoryChanged: (v) => setState(() => _showMandatoryDep = v),
            onElectiveChanged: (v) => setState(() => _showElectiveDep = v),
            onApprovalChanged: (v) => setState(() => _approvalFilterDep = v),
            subtitle: '',
          ),
        ],
      ),
      floatingActionButton: _buildFab(context),
    );
  }

  Widget _buildFab(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        final selected = await showModalBottomSheet<String>(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          builder: (context) {
            return SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: Icon(Icons.account_tree),
                    title: Text('Vista árbol'),
                    selected: _viewMode == _ViewMode.tree,
                    onTap: () => Navigator.pop(context, 'tree'),
                  ),
                  ListTile(
                    leading: Icon(Icons.view_list),
                    title: Text('Vista lista'),
                    selected: _viewMode == _ViewMode.list,
                    onTap: () => Navigator.pop(context, 'list'),
                  ),
                  const Divider(),
                  ListTile(
                    leading: Icon(
                      _highlightCriticalPath
                          ? Icons.visibility_off
                          : Icons.alt_route,
                    ),
                    title: Text(
                      _highlightCriticalPath
                          ? 'Ocultar ruta crítica'
                          : 'Mostrar ruta crítica',
                    ),
                    onTap: () => Navigator.pop(context, 'critical'),
                  ),
                ],
              ),
            );
          },
        );
        if (selected == 'tree') {
          setState(() => _viewMode = _ViewMode.tree);
        } else if (selected == 'list') {
          setState(() => _viewMode = _ViewMode.list);
        } else if (selected == 'critical') {
          final currentTree =
              _tabController.index == 0
                  ? widget.course.getPrerequisiteCoursesTree(
                    programCurriculum: widget.programCurriculum,
                  )
                  : widget.course.getDependentCoursesTree(
                    programCurriculum: widget.programCurriculum,
                  );
          _toggleCriticalPath(currentTree);
        }
      },
      child: const Icon(Icons.tune),
      tooltip: 'Opciones de visualización',
    );
  }

  Widget _buildTabSection(
    BuildContext context, {
    required CourseTreeNode? tree,
    required bool showMandatory,
    required bool showElective,
    required String approvalFilter,
    required ValueChanged<bool> onMandatoryChanged,
    required ValueChanged<bool> onElectiveChanged,
    required ValueChanged<String> onApprovalChanged,
    required String subtitle, // <- dejar pero no usar
  }) {
    final bool showFilters = tree != null && tree.children.isNotEmpty;
    return Column(
      children: [
        if (showFilters)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildFilterChips(
                  showMandatory,
                  showElective,
                  onMandatoryChanged,
                  onElectiveChanged,
                ),
                _buildApprovalChips(approvalFilter, onApprovalChanged),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Botón de ruta crítica eliminado, solo floating button
                  ],
                ),
              ],
            ),
          ),
        Expanded(
          child:
              _viewMode == _ViewMode.tree
                  ? _buildTreeFiltered(
                    context,
                    tree,
                    showMandatory,
                    showElective,
                    approvalFilter,
                    highlightCriticalPath: _highlightCriticalPath,
                    criticalPathIds: _criticalPathIds,
                  )
                  : _buildFlatListFiltered(
                    context,
                    tree,
                    showMandatory,
                    showElective,
                    approvalFilter,
                    highlightCriticalPath: _highlightCriticalPath,
                    criticalPathIds: _criticalPathIds,
                  ),
        ),
      ],
    );
  }

  // Mejorada: lista plana con cards agrupadas por ciclo
  Widget _buildFlatListFiltered(
    BuildContext context,
    CourseTreeNode? root,
    bool showMandatory,
    bool showElective,
    String approvalFilter, {
    bool highlightCriticalPath = false,
    Set<String> criticalPathIds = const {},
  }) {
    List<CourseTreeNode> flatList = [];
    void flatten(CourseTreeNode? node) {
      if (node == null) return;
      flatList.add(node);
      for (final child in node.children) {
        flatten(child);
      }
    }

    if (root != null) {
      flatten(root);
      // Aplicar filtros
      flatList =
          flatList.where((node) {
            final typeOk =
                (node.course.info.courseType == CourseType.mandatory &&
                    showMandatory) ||
                (node.course.info.courseType == CourseType.elective &&
                    showElective);
            final approvalOk =
                approvalFilter == 'todos' ||
                (approvalFilter == 'aprobado' &&
                    node.course.isApproved == true) ||
                (approvalFilter == 'no_aprobado' &&
                    node.course.isApproved == false);
            return typeOk && approvalOk;
          }).toList();
    }
    if (root == null) {
      return Center(child: Text('No hay cursos relacionados'));
    }
    if (flatList.isEmpty) {
      return Center(child: Text('No hay cursos que coincidan con los filtros'));
    }
    // Agrupar por ciclo
    Map<String, List<CourseTreeNode>> grouped = {};
    for (final node in flatList) {
      final ciclo = node.course.info.termRomanNumeral;
      grouped.putIfAbsent(ciclo, () => []).add(node);
    }
    final sortedKeys = grouped.keys.toList()..sort((a, b) => a.compareTo(b));
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: sortedKeys.length,
            itemBuilder: (context, idx) {
              final ciclo = sortedKeys[idx];
              final nodes = grouped[ciclo]!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: theme.colorScheme.surfaceVariant,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.book,
                          size: 18,
                          color: theme.colorScheme.primary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Ciclo $ciclo',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '(${nodes.length} ${nodes.length == 1 ? 'curso' : 'cursos'})',
                          style: TextStyle(
                            fontSize: 12,
                            color: theme.colorScheme.onSurfaceVariant
                                .withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ...nodes.map(
                    (node) => _buildFlatListTile(
                      context,
                      node,
                      highlightCriticalPath,
                      criticalPathIds,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFlatListTile(
    BuildContext context,
    CourseTreeNode node,
    bool highlightCriticalPath,
    Set<String> criticalPathIds,
  ) {
    final course = node.course;
    final theme = Theme.of(context);
    final isCritical =
        highlightCriticalPath &&
        criticalPathIds.contains(course.info.courseCode);
    return ListTile(
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      leading:
          (() {
            if (course.isApproved == true) {
              return Icon(
                Icons.check,
                color: isCritical ? Colors.orange : Colors.green,
              );
            }
            if (course.isApproved == false) {
              return Icon(
                Icons.close,
                color: isCritical ? Colors.orange : Colors.red,
              );
            }
            if (course.hasPrerequisitesApproved == true) {
              return Icon(
                Icons.lock_open_outlined,
                color: isCritical ? Colors.orange : theme.colorScheme.primary,
              );
            }
            return Icon(
              Icons.lock_outlined,
              color: isCritical ? Colors.orange : null,
            );
          })(),
      title: Text(
        course.info.courseName,
        style:
            isCritical
                ? theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                )
                : theme.textTheme.bodyLarge,
      ),
      subtitle: CourseSubtitleWidget(
        children: [
          course.info.courseType == CourseType.mandatory
              ? CourseSubtitleWidgetItem(
                text: 'Obligatorio',
                icon: Icons.school,
              )
              : CourseSubtitleWidgetItem(text: 'Electivo', icon: MdiIcons.leaf),
          CourseSubtitleWidgetItem(
            text:
                course.info.credits == 1
                    ? '1 crédito'
                    : '${course.info.credits} créditos',
          ),
        ],
      ),
      trailing:
          isCritical
              ? Tooltip(
                message: 'En ruta crítica',
                child: Icon(Icons.alt_route, color: Colors.orange, size: 20),
              )
              : null,
    );
  }

  Widget _buildTreeFiltered(
    BuildContext context,
    CourseTreeNode? root,
    bool showMandatory,
    bool showElective,
    String approvalFilter, {
    bool highlightCriticalPath = false,
    Set<String> criticalPathIds = const {},
  }) {
    String? message;
    CourseTreeNode? filtered;
    if (root == null) {
      message = 'No hay cursos relacionados';
    } else if (!showMandatory && !showElective) {
      message = 'Activa al menos un tipo de curso para ver resultados';
    } else {
      final noFilters =
          showMandatory && showElective && approvalFilter == 'todos';
      filtered =
          noFilters
              ? root
              : _filterTree(root, showMandatory, showElective, approvalFilter);
      if (filtered == null) {
        message = 'No hay cursos que coincidan con los filtros';
      }
    }
    if (message != null) {
      return Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Text(message, textAlign: TextAlign.center),
        ),
      );
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 1.1,
        child: SingleChildScrollView(
          child: _buildTree(
            context,
            node: filtered!,
            highlightCriticalPath: highlightCriticalPath,
            criticalPathIds: criticalPathIds,
          ),
        ),
      ),
    );
  }

  CourseTreeNode? _filterTree(
    CourseTreeNode node,
    bool showMandatory,
    bool showElective,
    String approvalFilter,
  ) {
    // Filtra recursivamente los nodos según los filtros activos
    bool matchesType =
        (node.course.info.courseType == CourseType.mandatory &&
            showMandatory) ||
        (node.course.info.courseType == CourseType.elective && showElective);
    bool matchesApproval =
        approvalFilter == 'todos' ||
        (approvalFilter == 'aprobado' && node.course.isApproved == true) ||
        (approvalFilter == 'no_aprobado' && node.course.isApproved == false);
    final filteredChildren =
        node.children
            .map(
              (child) => _filterTree(
                child,
                showMandatory,
                showElective,
                approvalFilter,
              ),
            )
            .whereType<CourseTreeNode>()
            .toList();
    if (matchesType && matchesApproval) {
      return CourseTreeNode(course: node.course, children: filteredChildren);
    } else if (filteredChildren.isNotEmpty) {
      // Si el nodo no cumple pero tiene hijos que sí, lo mostramos como rama
      return CourseTreeNode(course: node.course, children: filteredChildren);
    } else {
      // Si ni el nodo ni los hijos cumplen, lo excluimos
      return null;
    }
  }

  Widget _buildTree(
    BuildContext context, {
    required CourseTreeNode node,
    bool highlightCriticalPath = false,
    Set<String> criticalPathIds = const {},
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTreeItem(
          context,
          node: node,
          showRoot: false,
          highlightCriticalPath: highlightCriticalPath,
          criticalPathIds: criticalPathIds,
        ),
      ],
    );
  }

  Widget _buildTreeItem(
    BuildContext context, {
    required CourseTreeNode node,
    bool showRoot = true,
    bool highlightCriticalPath = false,
    Set<String> criticalPathIds = const {},
  }) {
    final course = node.course;
    final theme = Theme.of(context);
    final isCritical =
        highlightCriticalPath &&
        criticalPathIds.contains(course.info.courseCode);

    Widget buildRoot() {
      return SizedBox(
        width: MediaQuery.of(context).size.width - 8 * 8,
        child: ListTile(
          title: Text(
            course.info.courseName,
            style:
                isCritical
                    ? TextStyle(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    )
                    : null,
          ),
          leading:
              (() {
                if (course.isApproved == true) {
                  return Icon(
                    Icons.check,
                    color: isCritical ? Colors.orange : Colors.green,
                  );
                }
                if (course.isApproved == false) {
                  return Icon(
                    Icons.close,
                    color: isCritical ? Colors.orange : Colors.red,
                  );
                }
                if (course.hasPrerequisitesApproved == true) {
                  return Icon(
                    Icons.lock_open_outlined,
                    color:
                        isCritical ? Colors.orange : theme.colorScheme.primary,
                  );
                }
                return Icon(
                  Icons.lock_outlined,
                  color: isCritical ? Colors.orange : null,
                );
              })(),
          subtitle: CourseSubtitleWidget(
            children: [
              CourseSubtitleWidgetItem(
                text: 'Ciclo ${course.info.termRomanNumeral}',
                icon: Icons.book,
              ),
              course.info.courseType == CourseType.mandatory
                  ? CourseSubtitleWidgetItem(
                    text: 'Obligatorio',
                    icon: Icons.school,
                  )
                  : CourseSubtitleWidgetItem(
                    text: 'Electivo',
                    icon: MdiIcons.leaf,
                  ),
              CourseSubtitleWidgetItem(
                text:
                    course.info.credits == 1
                        ? '1 crédito'
                        : '${course.info.credits} créditos',
              ),
            ],
          ),
        ),
      );
    }

    Widget buildChildren() {
      final dividerColor = theme.dividerColor;
      final fontSize = theme.textTheme.bodyLarge?.fontSize ?? 0;
      final top = fontSize * 2.2;
      final width = fontSize;
      final thickness = 2.0;

      return Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:
              node.children.asMap().entries.map((entry) {
                final child = entry.value;
                final isLast = entry.key == node.children.length - 1;
                return Stack(
                  children: [
                    Positioned(
                      top: 0,
                      child: Container(
                        color: dividerColor,
                        width: thickness,
                        height: top,
                      ),
                    ),
                    if (!isLast)
                      Positioned(
                        top: top,
                        bottom: 0,
                        child: Container(
                          color: dividerColor,
                          width: thickness,
                          height: double.infinity,
                        ),
                      ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: top),
                          color: dividerColor,
                          width: width,
                          height: thickness,
                        ),
                        Expanded(
                          child: _buildTreeItem(
                            context,
                            node: child,
                            highlightCriticalPath: highlightCriticalPath,
                            criticalPathIds: criticalPathIds,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }).toList(),
        ),
      );
    }

    if (!showRoot) {
      return buildChildren();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [buildRoot(), if (node.children.isNotEmpty) buildChildren()],
    );
  }

  Widget _buildFilterChips(
    bool showMandatory,
    bool showElective,
    ValueChanged<bool> onMandatoryChanged,
    ValueChanged<bool> onElectiveChanged,
  ) {
    return Wrap(
      spacing: 8,
      children: [
        FilterChip(
          label: const Text('Obligatorios'),
          selected: showMandatory,
          onSelected: onMandatoryChanged,
          padding: const EdgeInsets.all(4),
        ),
        FilterChip(
          label: const Text('Electivos'),
          selected: showElective,
          onSelected: onElectiveChanged,
          padding: const EdgeInsets.all(4),
        ),
      ],
    );
  }

  Widget _buildApprovalChips(
    String approvalFilter,
    ValueChanged<String> onApprovalChanged,
  ) {
    return Wrap(
      spacing: 8,
      children: [
        ChoiceChip(
          label: const Text('Todos'),
          selected: approvalFilter == 'todos',
          onSelected: (v) => onApprovalChanged('todos'),
          padding: const EdgeInsets.all(4),
        ),
        ChoiceChip(
          label: const Text('Aprobados'),
          selected: approvalFilter == 'aprobado',
          onSelected: (v) => onApprovalChanged('aprobado'),
          padding: const EdgeInsets.all(4),
        ),
        ChoiceChip(
          label: const Text('No aprobados'),
          selected: approvalFilter == 'no_aprobado',
          onSelected: (v) => onApprovalChanged('no_aprobado'),
          padding: const EdgeInsets.all(4),
        ),
      ],
    );
  }

  Widget? _buildCriticalPathButton(CourseTreeNode tree) {
    if (tree.children.isEmpty) return null;
    return ElevatedButton.icon(
      icon: Icon(
        _highlightCriticalPath ? Icons.visibility_off : Icons.alt_route,
      ),
      label: Text(
        _highlightCriticalPath
            ? 'Ocultar ruta crítica'
            : 'Mostrar ruta crítica',
      ),
      onPressed: () => _toggleCriticalPath(tree),
    );
  }
}
