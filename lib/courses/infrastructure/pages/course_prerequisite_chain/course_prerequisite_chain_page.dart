import 'package:flutter/material.dart';
import 'package:sigapp/courses/domain/entities/course_type.dart';
import 'package:sigapp/courses/domain/entities/program_curriculum_course_term.dart';
import 'package:sigapp/courses/infrastructure/pages/course_prerequisite_chain/partials/flat.dart';
import 'package:sigapp/courses/infrastructure/pages/course_prerequisite_chain/partials/tree.dart';
import 'package:sigapp/courses/infrastructure/services/course_chain_preferences.dart';
import 'package:sigapp/courses/infrastructure/pages/course_prerequisite_chain/partials/view_options_sheet.dart';
import 'package:sigapp/courses/infrastructure/pages/course_prerequisite_chain/partials/filter_chips.dart';
import 'package:sigapp/courses/infrastructure/pages/course_prerequisite_chain/partials/approval_chips.dart';
import 'package:sigapp/courses/infrastructure/pages/course_prerequisite_chain/partials/tab_section.dart';

enum CoursePrerequisiteChainViewMode { tree, list }

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

  bool _highlightCriticalPath = false;
  Set<String> _criticalPathIds = {};
  CoursePrerequisiteChainViewMode _viewMode =
      CoursePrerequisiteChainViewMode.tree;
  bool _loadingPrefs = true;

  bool _showMandatoryReq = true;
  bool _showElectiveReq = true;
  String _approvalFilterReq = 'todos';
  bool _showMandatoryDep = true;
  bool _showElectiveDep = true;
  String _approvalFilterDep = 'todos';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadPreferences();
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

  Future<void> _loadPreferences() async {
    final highlight = await CourseChainPreferences.getHighlightCriticalPath();
    final viewMode = await CourseChainPreferences.getViewMode();
    if (highlight) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final currentTree = widget.course.getPrerequisiteCoursesTree(
          programCurriculum: widget.programCurriculum,
        );
        final path = _findCriticalPath(currentTree);
        setState(() {
          _highlightCriticalPath = true;
          _criticalPathIds = path.map((n) => n.course.info.courseCode).toSet();
          _viewMode =
              viewMode == 'list'
                  ? CoursePrerequisiteChainViewMode.list
                  : CoursePrerequisiteChainViewMode.tree;
          _loadingPrefs = false;
        });
      });
    } else {
      setState(() {
        _highlightCriticalPath = false;
        _criticalPathIds = {};
        _viewMode =
            viewMode == 'list'
                ? CoursePrerequisiteChainViewMode.list
                : CoursePrerequisiteChainViewMode.tree;
        _loadingPrefs = false;
      });
    }
  }

  // --- Ruta crítica ---
  void _toggleCriticalPath(CourseTreeNode? root) async {
    if (!_highlightCriticalPath) {
      // Calcular la ruta crítica solo si se va a activar
      final path = _findCriticalPath(root);
      setState(() {
        _highlightCriticalPath = true;
        _criticalPathIds = path.map((n) => n.course.info.courseCode).toSet();
      });
      await CourseChainPreferences.setHighlightCriticalPath(true);
    } else {
      setState(() {
        _highlightCriticalPath = false;
        _criticalPathIds = {};
      });
      await CourseChainPreferences.setHighlightCriticalPath(false);
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
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // --- Widgets extraídos para mayor claridad ---
  Widget _buildLoading() =>
      const Scaffold(body: Center(child: CircularProgressIndicator()));

  PreferredSizeWidget _buildAppBar(TabController tabController) => AppBar(
    title: const Text('Cadena de requisitos'),
    bottom: TabBar(
      controller: tabController,
      tabs: const [Tab(text: 'Requisitos'), Tab(text: 'Dependientes')],
    ),
  );

  Widget _buildMainScaffold(
    BuildContext context,
    TabController tabController,
    CourseTreeNode? prerequisiteCoursesTree,
    CourseTreeNode? dependentCoursesTree,
  ) {
    return Scaffold(
      appBar: _buildAppBar(tabController),
      body: TabBarView(
        controller: tabController,
        children: [
          TabSectionWidget(
            tree: prerequisiteCoursesTree,
            showMandatory: _showMandatoryReq,
            showElective: _showElectiveReq,
            approvalFilter: _approvalFilterReq,
            onMandatoryChanged: (v) => setState(() => _showMandatoryReq = v),
            onElectiveChanged: (v) => setState(() => _showElectiveReq = v),
            onApprovalChanged: (v) => setState(() => _approvalFilterReq = v),
            isTreeView: _viewMode == CoursePrerequisiteChainViewMode.tree,
            highlightCriticalPath: _highlightCriticalPath,
            criticalPathIds: _criticalPathIds,
          ),
          TabSectionWidget(
            tree: dependentCoursesTree,
            showMandatory: _showMandatoryDep,
            showElective: _showElectiveDep,
            approvalFilter: _approvalFilterDep,
            onMandatoryChanged: (v) => setState(() => _showMandatoryDep = v),
            onElectiveChanged: (v) => setState(() => _showElectiveDep = v),
            onApprovalChanged: (v) => setState(() => _approvalFilterDep = v),
            isTreeView: _viewMode == CoursePrerequisiteChainViewMode.tree,
            highlightCriticalPath: _highlightCriticalPath,
            criticalPathIds: _criticalPathIds,
          ),
        ],
      ),
      floatingActionButton: _buildFab(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_loadingPrefs) return _buildLoading();
    final prerequisiteCoursesTree = widget.course.getPrerequisiteCoursesTree(
      programCurriculum: widget.programCurriculum,
    );
    final dependentCoursesTree = widget.course.getDependentCoursesTree(
      programCurriculum: widget.programCurriculum,
    );
    return _buildMainScaffold(
      context,
      _tabController,
      prerequisiteCoursesTree,
      dependentCoursesTree,
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
            return ViewOptionsSheetWidget(
              viewMode: _viewMode,
              highlightCriticalPath: _highlightCriticalPath,
              onTree: () => Navigator.pop(context, 'tree'),
              onList: () => Navigator.pop(context, 'list'),
              onCritical: () => Navigator.pop(context, 'critical'),
            );
          },
        );
        if (selected == 'tree') {
          setState(() => _viewMode = CoursePrerequisiteChainViewMode.tree);
          await CourseChainPreferences.setViewMode('tree');
        } else if (selected == 'list') {
          setState(() => _viewMode = CoursePrerequisiteChainViewMode.list);
          await CourseChainPreferences.setViewMode('list');
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
      tooltip: 'Opciones de visualización',
      child: const Icon(Icons.tune),
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
                FilterChipsWidget(
                  showMandatory: showMandatory,
                  showElective: showElective,
                  onMandatoryChanged: onMandatoryChanged,
                  onElectiveChanged: onElectiveChanged,
                ),
                ApprovalChipsWidget(
                  approvalFilter: approvalFilter,
                  onApprovalChanged: onApprovalChanged,
                ),
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
              _viewMode == CoursePrerequisiteChainViewMode.tree
                  ? _buildTreeFiltered(
                    context,
                    tree,
                    showMandatory,
                    showElective,
                    approvalFilter,
                    highlightCriticalPath: _highlightCriticalPath,
                    criticalPathIds: _criticalPathIds,
                  )
                  : FlatCourseChainWidget(
                    root: tree,
                    showMandatory: showMandatory,
                    showElective: showElective,
                    approvalFilter: approvalFilter,
                    highlightCriticalPath: _highlightCriticalPath,
                    criticalPathIds: _criticalPathIds,
                  ),
        ),
      ],
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
    return TreeCourseChainWidget(
      node: filtered!,
      highlightCriticalPath: highlightCriticalPath,
      criticalPathIds: criticalPathIds,
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
}
