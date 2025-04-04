import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sigapp/courses/domain/entities/academic_history_term.dart';
import 'package:sigapp/courses/domain/entities/course_type.dart';
import 'package:sigapp/courses/infrastructure/pages/career/widgets/course_subtitle.dart';
import 'package:sigapp/courses/infrastructure/pages/courses/partials/empty_courses.dart';
import 'package:sigapp/student/domain/entities/student_academic_report.dart';

class CareerPageAcademicHistoryWidget extends StatelessWidget {
  const CareerPageAcademicHistoryWidget({
    super.key,
    required this.academicHistory,
    required this.report,
  });

  final List<AcademicHistoryTerm> academicHistory;
  final AcademicReport report;

  @override
  Widget build(BuildContext context) {
    if (academicHistory.isEmpty) {
      return EmptyCoursesWidget(
        message: 'No disponible en este momento',
      );
    }
    return ListView(
      children: [
        if (academicHistory.length > 1) _buildChart(context, academicHistory),
        ...academicHistory.map(
          (term) {
            return ExpansionTile(
              title: Text('Semestre ${term.term.name}'),
              children: [
                if (term.statistics != null)
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
                                    context,
                                    title: 'Promedio ponderado',
                                    data: [
                                      ..._maybeAddAverages(
                                        normal: term
                                            .statistics!.termWeightedAverage,
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
                                    context,
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
                                        normal: term
                                            .statistics!.electiveCreditsTaken,
                                        pass: term
                                            .statistics!.electiveCreditsPassed,
                                        normalLabel: 'Electivos',
                                        passLabel: 'Electivos (aprobados)',
                                      ),
                                      [
                                        'Obligatorios convalidados',
                                        term.statistics!
                                            .mandatoryCreditsValidated
                                            .toString(),
                                      ],
                                      [
                                        'Electivos convalidados',
                                        term.statistics!
                                            .electiveCreditsValidated
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
                                        total:
                                            report.curriculumMandatoryCredits,
                                      ),
                                      ..._maybeAddCredits(
                                        normal: term.statistics!
                                            .totalElectiveCreditsTaken,
                                        pass: term.statistics!
                                            .totalElectiveCreditsPassed,
                                        normalLabel: 'Total electivos',
                                        passLabel:
                                            'Total electivos (aprobados)',
                                        total: report.curriculumElectiveCredits,
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
                      title:
                          Text('${course.courseName} (${course.courseCode})'),
                      subtitle: CourseSubtitleWidget(children: [
                        CourseSubtitleWidgetItem(
                          icon: course.courseType == CourseType.mandatory
                              ? MdiIcons.school
                              : MdiIcons.leaf,
                          text: course.courseType == CourseType.mandatory
                              ? 'Obligatorio'
                              : 'Electivo',
                        ),
                        CourseSubtitleWidgetItem(
                          text: course.credits == 1
                              ? '1 crédito'
                              : '${course.credits} créditos',
                        ),
                        if (course.programCurriculumCourse != null)
                          CourseSubtitleWidgetItem(
                            icon: Icons.book,
                            text:
                                'Ciclo ${course.programCurriculumCourse!.info.termRomanNumeral}',
                          ),
                      ]),
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
        ),
      ],
    );
  }

  Widget _buildStatisticsSection(
    BuildContext context, {
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
        ...data.map((entry) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(entry[0]),
                SizedBox(width: 8),
                Text(entry[1]),
              ],
            ))
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
  List<List<String>> _maybeAddCredits(
      {required int normal,
      required int pass,
      required String normalLabel,
      required String passLabel,
      int? total}) {
    final totalLabel = total != null ? ' de $total' : '';
    if (normal == pass) {
      return [
        [normalLabel, '$normal$totalLabel'],
      ];
    } else {
      return [
        [normalLabel, '$normal$totalLabel'],
        [passLabel, '$pass$totalLabel'],
      ];
    }
  }

  Widget _buildChart(
    BuildContext context,
    List<AcademicHistoryTerm> academicHistory,
  ) {
    // Filter only those terms that have statistics
    final termsWithStats =
        academicHistory.where((t) => t.statistics != null).toList();
    if (termsWithStats.isEmpty) {
      return const SizedBox.shrink();
    }

    // We'll keep track of both lines: semestral average and cumulative average
    final List<FlSpot> semestralSpots = [];
    final List<FlSpot> acumuladoSpots = [];

    // We'll determine min and max for Y (averages),
    // while X (semesters) is straightforward: from 1 to numberOfTerms
    double minY = double.infinity;
    double maxY = double.negativeInfinity;

    for (var i = 0; i < termsWithStats.length; i++) {
      final stats = termsWithStats[i].statistics!;
      final semesterIndex = (i + 1).toDouble(); // X: semester number

      // Y values for semestral and cumulative weighted averages
      final semestral = stats.termWeightedAverage;
      final acumulado = stats.cumulativeWeightedAverage;

      // Build the spots for the chart
      semestralSpots.add(FlSpot(semesterIndex, semestral));
      acumuladoSpots.add(FlSpot(semesterIndex, acumulado));

      // Update min and max for Y
      if (semestral < minY) minY = semestral;
      if (semestral > maxY) maxY = semestral;
      if (acumulado < minY) minY = acumulado;
      if (acumulado > maxY) maxY = acumulado;
    }

    // We add some margin so the lines don't stick to the borders
    const marginFactor = 0.1;
    final yRange = maxY - minY;
    final double finalMinY =
        (yRange > 0) ? minY - yRange * marginFactor : minY - 1;
    final double finalMaxY =
        (yRange > 0) ? maxY + yRange * marginFactor : maxY + 1;

    // For X, we can assume 1 to termsWithStats.length, plus a little margin
    final double finalMinX = 0.5;
    final double finalMaxX = termsWithStats.length + 0.5;

    final semestralColor = Colors.blue;
    final lineSemestral = LineChartBarData(
      spots: semestralSpots,
      isCurved: true,
      barWidth: 3,
      isStrokeCapRound: true,
      dotData: const FlDotData(show: true),
      belowBarData: BarAreaData(show: false),
      color: semestralColor,
    );

    final acumuladoColor = Colors.red;
    final lineAcumulado = LineChartBarData(
      spots: acumuladoSpots,
      isCurved: true,
      barWidth: 3,
      isStrokeCapRound: true,
      dotData: const FlDotData(show: true),
      belowBarData: BarAreaData(show: false),
      color: acumuladoColor,
    );

    return Container(
      padding: EdgeInsets.only(left: 16, right: 16, top: 16),
      child: Column(
        children: [
          // Text(
          //   'Promedio ponderado semestral vs acumulado',
          //   style: Theme.of(context).textTheme.labelLarge,
          // ),
          // semestral: blue
          // acumulado: red
          RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.labelLarge,
              children: [
                TextSpan(text: 'Promedio ponderado '),
                TextSpan(
                  text: 'semestral',
                  style: TextStyle(color: semestralColor),
                ),
                TextSpan(text: ' vs '),
                TextSpan(
                  text: 'acumulado',
                  style: TextStyle(color: acumuladoColor),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          SizedBox(
            height: 300,
            child: LineChart(
              LineChartData(
                minX: finalMinX,
                maxX: finalMaxX,
                minY: finalMinY,
                maxY: finalMaxY,
                lineBarsData: [
                  lineSemestral,
                  lineAcumulado,
                ],
                gridData: FlGridData(show: true),
                borderData: FlBorderData(
                  show: true,
                  border: const Border(
                    left: BorderSide(color: Colors.black12),
                    bottom: BorderSide(color: Colors.black12),
                    right: BorderSide(color: Colors.transparent),
                    top: BorderSide(color: Colors.transparent),
                  ),
                ),
                titlesData: FlTitlesData(
                  // Bottom axis: semesters
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 1,
                      reservedSize: 30,
                      getTitlesWidget: (value, _) {
                        final semesterNumber = value.toInt();
                        if (semesterNumber < 1 ||
                            semesterNumber > termsWithStats.length) {
                          return const SizedBox.shrink();
                        }
                        return Text('S$semesterNumber',
                            style: const TextStyle(fontSize: 12));
                      },
                    ),
                  ),
                  // Left axis: weighted average
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      getTitlesWidget: (value, _) {
                        // Round or format as needed
                        return Text(value.toStringAsFixed(1),
                            style: const TextStyle(fontSize: 12));
                      },
                    ),
                  ),
                  topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
