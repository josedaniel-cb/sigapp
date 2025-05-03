import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigapp/core/infrastructure/ui/widgets/error_state.dart';
import 'package:sigapp/core/infrastructure/ui/widgets/loading_state.dart';
import 'package:sigapp/shared/infrastructure/partials/user_avatar_button.dart';
import 'package:sigapp/student/domain/entities/student_academic_report.dart';
import 'package:sigapp/student/infrastructure/pages/components/generic_pie_chart.dart';
import 'package:sigapp/student/infrastructure/pages/student_cubit.dart';
import 'dart:math' as math;

class StudentPageView extends StatefulWidget {
  const StudentPageView({super.key});

  @override
  State<StudentPageView> createState() => _StudentPageViewState();
}

class _StudentPageViewState extends State<StudentPageView> {
  late final StudentPageViewCubit _cubit;

  @override
  void initState() {
    _cubit = BlocProvider.of<StudentPageViewCubit>(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _cubit.setup();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StudentPageViewCubit, StudentPageViewState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Estudiante'),
                UserAvatarButtonWidget(),
              ],
            ),
          ),
          body: state.map(
            loading: (_) => const LoadingStateWidget(),
            success: (state) => _buildSuccessState(context, state),
            error: (state) => ErrorStateWidget(
              message: state.message,
              onRetry: () => _cubit.setup(),
            ),
          ),
        );
      },
      listener: (context, state) {
        if (state is SuccessState) {
          // Do something
        } else if (state is ErrorState) {
          // Do something
        }
      },
    );
  }

  Widget _buildSuccessState(
    BuildContext context,
    SuccessState state,
  ) {
    final info = state.academicReport;

    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        _buildStudentInfoSection(info),
        const SizedBox(height: 16),
        _buildStatsSection(info),
        const SizedBox(height: 16),
        _buildCreditsSection(context, info),
        // const SizedBox(height: 16),
        // _buildMoreInfoSection(context, info),
      ],
    );
  }

  Widget _buildCreditsSection(BuildContext context, AcademicReport info) {
    final textTheme = Theme.of(context).textTheme;

    // Mandatory
    final totalMandatory = info.curriculumMandatoryCredits;
    final passedMandatory = info.mandatoryCreditsOfPassedCourses;

    // Elective
    final totalElective = info.curriculumElectiveCredits;
    final passedElective = info.electiveCreditsOfPassedCourses;

    // Approved
    final mandatoryApproved =
        math.min(passedMandatory, totalMandatory).toDouble();
    final electiveApproved = math.min(passedElective, totalElective).toDouble();

    // Pending
    final mandatoryPending =
        math.max(totalMandatory - passedMandatory, 0).toDouble();
    final electivePending =
        math.max(totalElective - passedElective, 0).toDouble();

    // Over
    final mandatoryOver =
        math.max(passedMandatory - totalMandatory, 0).toDouble();
    final electiveOver = math.max(passedElective - totalElective, 0).toDouble();

    // Over message
    var overMsg = '';
    if (mandatoryOver > 0 && electiveOver > 0) {
      overMsg =
          'Has excedido $mandatoryOver créditos obligatorios y $electiveOver créditos electivos.';
    } else if (mandatoryOver > 0) {
      overMsg = 'Has excedido $mandatoryOver créditos obligatorios.';
    } else if (electiveOver > 0) {
      overMsg = 'Has excedido $electiveOver créditos electivos.';
    }

    final rawData = [
      [
        mandatoryApproved,
        'Oblig. Aprobados\n${(mandatoryApproved + mandatoryOver).toInt()}/$totalMandatory',
        Colors.teal,
      ],
      [
        mandatoryPending,
        'Oblig. Pendientes\n${mandatoryPending.toInt()}/$totalMandatory',
        Colors.black38,
      ],
      [
        electiveApproved,
        'Elect. Aprobados\n${(electiveApproved + electiveOver).toInt()}/$totalElective',
        Colors.cyan,
      ],
      [
        electivePending,
        'Elect. Pendientes\n${electivePending.toInt()}/$totalElective',
        Colors.black12,
      ],
    ];

    final filteredEntries = List.generate(rawData.length, (i) => i)
        .where((i) => rawData[i][0] as double > 0)
        .map((i) => (
              value: rawData[i][0] as double,
              label: rawData[i][1] as String,
              color: rawData[i][2] as Color
            ))
        .toList();

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Distribución de Créditos',
              style: textTheme.titleMedium,
            ),
            if (overMsg.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  overMsg,
                  style:
                      textTheme.bodyMedium?.copyWith(color: Colors.redAccent),
                ),
              ),
            const SizedBox(height: 16),
            // AspectRatio(
            //   aspectRatio: 1.5,
            //   child: GenericPieChart(
            //     values: filteredEntries.map((e) => e.value).toList(),
            //     labels: filteredEntries.map((e) => e.label).toList(),
            //     colors: filteredEntries.map((e) => e.color).toList(),
            //   ),
            // ),
            LayoutBuilder(
              builder: (context, constraints) {
                return SizedBox(
                  height: constraints.maxWidth * 0.8,
                  child: GenericPieChart(
                    values: filteredEntries.map((e) => e.value).toList(),
                    labels: filteredEntries.map((e) => e.label).toList(),
                    colors: filteredEntries.map((e) => e.color).toList(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Column _buildStatsSection(AcademicReport info) {
    return Column(
      children: [
        Row(
          children: [
            _buildStatCard(
              title: 'PPA (Aprobado)',
              value: info.cumulativeWeightedAverageOfPassedCourses
                  .toStringAsFixed(2),
              color: Colors.blue,
            ),
            const SizedBox(width: 8),
            _buildStatCard(
              title: 'Créditos Aprobados',
              value: '${info.totalCreditsOfPassedCourses}',
              color: Colors.green,
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            _buildStatCard(
              title: 'Último PPA',
              value: info.lastCumulativeWeightedAverage.toStringAsFixed(2),
              color: Colors.blue,
            ),
            const SizedBox(width: 8),
            _buildStatCard(
              title: 'PPA (Acumulado)',
              value: info.cumulativeWeightedAverage.toStringAsFixed(2),
              color: Colors.blue,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStudentInfoSection(AcademicReport info) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 36,
              child: Text(
                info.firstName.substring(0, 1).toUpperCase(),
                style: const TextStyle(fontSize: 24),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${info.firstName}\n${info.lastName}',
                    style: textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  (() {
                    final data = [
                      ['Código', info.code],
                      ['Facultad', info.faculty],
                      ['Escuela', info.school],
                      ['Promoción', info.cohort],
                    ];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: data
                          .map(
                            (e) => Padding(
                              padding: const EdgeInsets.only(top: 2.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 100,
                                    child: Text(
                                      '${e[0]}:',
                                      style: textTheme.bodyMedium,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      e[1],
                                      style: textTheme.bodyMedium?.copyWith(
                                        fontWeight: FontWeight.w500,
                                      ),
                                      softWrap: true,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                    );
                  })(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required MaterialColor color,
  }) {
    final textTheme = Theme.of(context).textTheme;
    return Expanded(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          child: Column(
            children: [
              Text(
                title,
                style: textTheme.bodyMedium?.copyWith(
                  color: color.shade700,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: textTheme.titleLarge?.copyWith(
                  color: color.shade900,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
