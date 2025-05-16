import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sigapp/courses/domain/entities/course_type.dart';
import 'package:sigapp/courses/domain/entities/program_curriculum_course_term.dart';
import 'package:sigapp/courses/infrastructure/pages/career/widgets/course_subtitle.dart';
import 'dart:math' as math;

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
  bool _showMandatory = true;
  bool _showElective = true;
  String _approvalFilter = 'todos'; // 'todos', 'aprobado', 'no_aprobado'

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
    final showFilters =
        _tabController.index == 1; // Solo mostrar filtros en Dependientes
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadena de requisitos'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [Tab(text: 'Requisitos'), Tab(text: 'Dependientes')],
        ),
      ),
      body: Column(
        children: [
          if (showFilters)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 8,
                    children: [
                      FilterChip(
                        label: const Text('Obligatorios'),
                        selected: _showMandatory,
                        onSelected: (v) => setState(() => _showMandatory = v),
                      ),
                      FilterChip(
                        label: const Text('Electivos'),
                        selected: _showElective,
                        onSelected: (v) => setState(() => _showElective = v),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: [
                      ChoiceChip(
                        label: const Text('Todos'),
                        selected: _approvalFilter == 'todos',
                        onSelected:
                            (v) => setState(() => _approvalFilter = 'todos'),
                      ),
                      ChoiceChip(
                        label: const Text('Aprobados'),
                        selected: _approvalFilter == 'aprobado',
                        onSelected:
                            (v) => setState(() => _approvalFilter = 'aprobado'),
                      ),
                      ChoiceChip(
                        label: const Text('No aprobados'),
                        selected: _approvalFilter == 'no_aprobado',
                        onSelected:
                            (v) =>
                                setState(() => _approvalFilter = 'no_aprobado'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildTreeFiltered(
                  context,
                  prerequisiteCoursesTree,
                  'Cursos necesarios para llevar \'${widget.course.info.courseName}\'',
                ),
                _buildTreeFiltered(
                  context,
                  dependentCoursesTree,
                  'Cursos que requieren aprobar \'${widget.course.info.courseName}\'',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTreeFiltered(
    BuildContext context,
    CourseTreeNode? root,
    String subtitle,
  ) {
    if (root == null) {
      return const Center(child: Text('No hay cursos relacionados'));
    }
    // Si ambos chips están desactivados, no hay nada que mostrar
    if (!_showMandatory && !_showElective) {
      return const Center(
        child: Text('Activa al menos un tipo de curso para ver resultados'),
      );
    }
    // Si no hay filtros activos (ambos chips activos y filtro 'todos'), mostrar el árbol completo
    final noFilters =
        _showMandatory && _showElective && _approvalFilter == 'todos';
    final filtered = noFilters ? root : _filterTree(root);
    if (filtered == null) {
      return const Center(
        child: Text('No hay cursos que coincidan con los filtros'),
      );
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 1.1,
        child: SingleChildScrollView(
          child: _buildTree(
            context,
            node: filtered,
            title: '',
            subtitle: subtitle,
          ),
        ),
      ),
    );
  }

  CourseTreeNode? _filterTree(CourseTreeNode node) {
    // Filtra recursivamente los nodos según los filtros activos
    bool matchesType =
        (node.course.info.courseType == CourseType.mandatory &&
            _showMandatory) ||
        (node.course.info.courseType == CourseType.elective && _showElective);
    bool matchesApproval =
        _approvalFilter == 'todos' ||
        (_approvalFilter == 'aprobado' && node.course.isApproved == true) ||
        (_approvalFilter == 'no_aprobado' && node.course.isApproved == false);
    final filteredChildren =
        node.children.map(_filterTree).whereType<CourseTreeNode>().toList();
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

  Container _buildBody(
    CourseTreeNode? prerequisiteCoursesTree,
    CourseTreeNode? dependentCoursesTree,
    BuildContext context,
  ) {
    return Container(
      padding: const EdgeInsets.all(8),
      child:
          prerequisiteCoursesTree == null && dependentCoursesTree == null
              ? Center(child: Text('No hay cursos relacionados'))
              : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (prerequisiteCoursesTree != null)
                    _buildTree(
                      context,
                      node: prerequisiteCoursesTree,
                      title: 'Requisitos',
                      subtitle:
                          'Cursos necesarios para llevar ${widget.course.info.courseName}',
                    ),
                  if (prerequisiteCoursesTree != null &&
                      dependentCoursesTree != null)
                    SizedBox(height: 16),
                  if (dependentCoursesTree != null)
                    _buildTree(
                      context,
                      node: dependentCoursesTree,
                      title: 'Dependientes',
                      subtitle:
                          'Cursos que requieren aprobar ${widget.course.info.courseName}',
                    ),
                ],
              ),
    );
  }

  Widget _buildTree(
    BuildContext context, {
    required CourseTreeNode node,
    required String title,
    required String subtitle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (title.isNotEmpty) ...[
                Text(title, style: Theme.of(context).textTheme.titleMedium),
                SizedBox(height: 4),
              ],
              Text(subtitle, style: Theme.of(context).textTheme.bodyLarge),
            ],
          ),
        ),
        _buildTreeItem(context, node: node, showRoot: false),
      ],
    );
  }

  Widget _buildTreeItem(
    BuildContext context, {
    required CourseTreeNode node,
    bool showRoot = true,
  }) {
    final course = node.course;
    final theme = Theme.of(context);

    Widget buildRoot() {
      return SizedBox(
        // constraints: BoxConstraints(
        //   minWidth: MediaQuery.of(context).size.width,
        // ),
        width: MediaQuery.of(context).size.width - 8 * 8,
        child: ListTile(
          title: Text(course.info.courseName),
          leading:
              (() {
                if (course.isApproved == true) {
                  return const Icon(Icons.check, color: Colors.green);
                }
                if (course.isApproved == false) {
                  return const Icon(Icons.close, color: Colors.red);
                }
                if (course.hasPrerequisitesApproved == true) {
                  return Icon(
                    Icons.lock_open_outlined,
                    color: theme.colorScheme.primary,
                  );
                }
                return Icon(Icons.lock_outlined);
              })(),
          // subtitle: Text('Ciclo ${course.info.termRomanNumeral}'),
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
      // final dividerColor = Colors.teal;

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
                        Expanded(child: _buildTreeItem(context, node: child)),
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
}
