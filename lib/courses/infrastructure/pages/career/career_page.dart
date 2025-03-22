import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sigapp/core/infrastructure/ui/widgets/error_state.dart';
import 'package:sigapp/core/infrastructure/ui/widgets/loading_state.dart';
import 'package:sigapp/courses/domain/entities/academic_history_term.dart';
import 'package:sigapp/courses/domain/entities/course_type.dart';
import 'package:sigapp/courses/domain/entities/program_curriculum_course_term.dart';
import 'package:sigapp/courses/infrastructure/pages/career/career_page_cubit.dart';
import 'package:sigapp/shared/infrastructure/partials/user_avatar_button.dart';

class CareerPageView extends StatefulWidget {
  const CareerPageView({super.key});

  @override
  State<CareerPageView> createState() => _CareerPageViewState();
}

class _CareerPageViewState extends State<CareerPageView>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  late final CareerPageCubit _cubit;

  @override
  void initState() {
    _cubit = BlocProvider.of<CareerPageCubit>(context);
    _cubit.fetch();
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CareerPageCubit, CareerPageState>(
        builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Carrera'),
              UserAvatarButtonWidget(),
            ],
          ),
          bottom: TabBar(
            controller: _tabController,
            tabs: [
              Tab(
                icon: Icon(MdiIcons.notebookOutline),
                text: 'Plan de estudios',
              ),
              Tab(
                icon: Icon(MdiIcons.fileChartOutline),
                text: 'Historial académico',
              ),
            ],
          ),
        ),
        body: state.map(
          loading: (_) => LoadingStateWidget(),
          success: _buildReadyState,
          error: (s) => ErrorStateWidget(message: s.message),
        ),
      );
    });
  }

  Widget _buildReadyState(CareerPageSuccessState state) {
    return TabBarView(
      controller: _tabController,
      children: [
        _buildProgramCurriculum(
            state.programCurriculumProgress.programCurriculum),
        _buildAcademicHistory(state.programCurriculumProgress.academicHistory),
      ],
    );
  }

  Widget _buildProgramCurriculum(
      List<ProgramCurriculumTerm> programCurriculum) {
    return ListView(
      children: programCurriculum.map(
        (term) {
          return ExpansionTile(
            title: Text('Ciclo ${term.termRomanNumeral}'),
            children: term.courses.map(
              (course) {
                return ListTile(
                  title: Text(
                      '${course.info.courseCode} - ${course.info.courseName}'),
                  subtitle: Row(
                    children: [
                      Icon((() {
                        if (course.info.courseType == CourseType.elective) {
                          return MdiIcons.leaf;
                        }
                        return course.isApproved == true
                            ? Icons.lock_open
                            : Icons.lock;
                      })(), size: 16),
                      SizedBox(width: 4),
                      Text((() {
                        final data = [];
                        data.add(course.info.courseType == CourseType.mandatory
                            ? 'Obligatorio'
                            : 'Electivo');
                        data.add(course.info.credits > 1
                            ? '${course.info.credits} créditos'
                            : '${course.info.credits} crédito');
                        return data.join(' • ');
                      })())
                    ],
                  ),
                  trailing: course.isApproved == null
                      ? null
                      : course.isApproved!
                          ? Icon(Icons.check, color: Colors.green)
                          : Icon(Icons.close, color: Colors.red),
                );
              },
            ).toList(),
          );
        },
      ).toList(),
    );
  }

  Widget _buildAcademicHistory(List<AcademicHistoryTerm> academicHistory) {
    return ListView(
      children: academicHistory.map(
        (term) {
          return ExpansionTile(
            title: Text(
              'Semestre ${term.term.name}',
              // style: textTheme.bodyLarge?.copyWith(
              //   fontWeight: FontWeight.w500,
              // ),
            ),
            children: [
              if (term.statistics != null)
                // ListTile(
                //   title: Text('Promedio ponderado'),
                // ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 12),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                _buildStatisticsSection(
                                  title: 'Promedio ponderado',
                                  data: [
                                    ..._maybeAddAverages(
                                      normal:
                                          term.statistics!.termWeightedAverage,
                                      pass: term.statistics!
                                          .termWeightedAveragePassed,
                                      normalLabel: 'Semestral',
                                      passLabel: 'Semestral (aprobatorio)',
                                    ),
                                    ..._maybeAddAverages(
                                      normal: term.statistics!
                                          .cumulativeWeightedAverage,
                                      pass: term.statistics!
                                          .cumulativeWeightedAveragePassed,
                                      normalLabel: 'Acumulado',
                                      passLabel: 'Acumulado (aprobatorio)',
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),
                                _buildStatisticsSection(
                                  title: 'Créditos',
                                  data: [
                                    ..._maybeAddCredits(
                                      normal: term
                                          .statistics!.mandatoryCreditsTaken,
                                      pass: term
                                          .statistics!.mandatoryCreditsPassed,
                                      normalLabel: 'Obligatorios',
                                      passLabel: 'Obligatorios (aprobados)',
                                    ),
                                    ..._maybeAddCredits(
                                      normal:
                                          term.statistics!.electiveCreditsTaken,
                                      pass: term
                                          .statistics!.electiveCreditsPassed,
                                      normalLabel: 'Electivos',
                                      passLabel: 'Electivos (aprobados)',
                                    ),
                                    [
                                      'Obligatorios convalidados',
                                      term.statistics!.mandatoryCreditsValidated
                                          .toString(),
                                    ],
                                    [
                                      'Electivos convalidados',
                                      term.statistics!.electiveCreditsValidated
                                          .toString(),
                                    ],
                                    [
                                      'Total obligatorios convalidados',
                                      term.statistics!
                                          .totalMandatoryCreditsValidated
                                          .toString(),
                                    ],
                                    ..._maybeAddCredits(
                                      normal: term.statistics!
                                          .totalMandatoryCreditsTaken,
                                      pass: term.statistics!
                                          .totalMandatoryCreditsPassed,
                                      normalLabel: 'Total obligatorios',
                                      passLabel:
                                          'Total obligatorios (aprobados)',
                                    ),
                                    ..._maybeAddCredits(
                                      normal: term.statistics!
                                          .totalElectiveCreditsTaken,
                                      pass: term.statistics!
                                          .totalElectiveCreditsPassed,
                                      normalLabel: 'Total electivos',
                                      passLabel: 'Total electivos (aprobados)',
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ...term.courses.map(
                (course) {
                  return ListTile(
                    title: Text('${course.courseCode} - ${course.courseName}'),
                    subtitle: Row(
                      children: [
                        Icon((() {
                          if (course.courseType == CourseType.elective) {
                            return MdiIcons.leaf;
                          }
                          return course.isApproved == true
                              ? Icons.lock_open
                              : Icons.lock;
                        })(), size: 16),
                        SizedBox(width: 4),
                        Text((() {
                          final data = [];
                          data.add(course.courseType == CourseType.mandatory
                              ? 'Obligatorio'
                              : 'Electivo');
                          data.add(course.credits > 1
                              ? '${course.credits} créditos'
                              : '${course.credits} crédito');
                          return data.join(' • ');
                        })()),
                      ],
                    ),
                    trailing: Text(
                      course.grade.toStringAsFixed(2),
                      style: TextStyle(
                        color: course.isApproved ? Colors.green : Colors.red,
                      ),
                    ),
                  );
                },
              )
            ],
          );
        },
      ).toList(),
    );
  }

  Widget _buildStatisticsSection({
    required String title,
    required List<List<String>> data,
  }) {
    data = data.where((entry) {
      final value = double.tryParse(entry[1]) ?? 0.0;
      return value != 0.0;
    }).toList();

    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: textTheme.titleMedium,
        ),
        ...data
            .map((entry) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(entry[0]),
                    SizedBox(width: 8),
                    Text(entry[1]),
                  ],
                ))
            .toList()
      ],
    );
  }

  /// This method is used to generate the statistics section of the career page.
  List<List<String>> _maybeAddAverages({
    required double normal,
    required double pass,
    required String normalLabel,
    required String passLabel,
  }) {
    final normalFixed = double.parse(normal.toStringAsFixed(2));
    final passFixed = double.parse(pass.toStringAsFixed(2));

    if (normalFixed == passFixed) {
      return [
        [normalLabel, normal.toStringAsFixed(2)],
      ];
    } else {
      return [
        [normalLabel, normal.toStringAsFixed(2)],
        [passLabel, pass.toStringAsFixed(2)],
      ];
    }
  }

  /// This method is used to generate the statistics section of the career page.
  List<List<String>> _maybeAddCredits({
    required int normal,
    required int pass,
    required String normalLabel,
    required String passLabel,
  }) {
    if (normal == pass) {
      return [
        [normalLabel, normal.toString()],
      ];
    } else {
      return [
        [normalLabel, normal.toString()],
        [passLabel, pass.toString()],
      ];
    }
  }
}
