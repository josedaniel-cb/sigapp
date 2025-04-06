import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sigapp/courses/domain/entities/academic_history_term.dart';
import 'dart:math' as math;

final Map<String, String> coursePrefixes = {
  'SI': 'Ingeniería de Sistemas',
  'ED': 'Educación General',
  'MA': 'Matemáticas',
  'CS': 'Ciencias Sociales',
  'FI': 'Física',
  'CA': 'Administración',
  'IO': 'Ingeniería de Operaciones',
  'CO': 'Contabilidad',
  'ES': 'Estadística',
  'II': 'Ingeniería Industrial',
  'EM': 'Economía',
  'EA': 'Economía',
  'CB': 'Ciencias Biológicas',
  'DP': 'Derecho',
  'AA': 'Administración y Logística',
  'QU': 'Química',
  'EC': 'Economía',
  'CG': 'Contabilidad',
  'DE': 'Derecho',
};

class GradesPerCourseCategoryChart extends StatelessWidget {
  const GradesPerCourseCategoryChart(
      {super.key, required this.academicHistory});

  final List<AcademicHistoryTerm> academicHistory;

  @override
  Widget build(BuildContext context) {
    return _buildChart(context, academicHistory);
  }

  Widget _buildChart(
    BuildContext context,
    List<AcademicHistoryTerm> academicHistory,
  ) {
    // Extraer todos los courses de todos los términos
    final List<AcademicHistoryCourse> allCourses = [];
    for (final term in academicHistory) {
      allCourses.addAll(term.courses);
    }

    // Agrupar courses por el "tipo de curso" (parte alfabética de courseCode)
    final Map<String, List<double>> courseTypeGrades = {};
    final RegExp regex = RegExp(r'^[A-Za-z]+');
    for (final course in allCourses) {
      final match = regex.firstMatch(course.courseCode);
      if (match != null) {
        final type = match.group(0)!;
        courseTypeGrades.putIfAbsent(type, () => []).add(course.grade);
      }
    }

    // Ordenar los tipos para tener un orden consistente en el eje X
    final List<String> sortedKeys = courseTypeGrades.keys.toList()
      ..sort((a, b) {
        final maxA = courseTypeGrades[a]!.reduce((x, y) => x > y ? x : y);
        final maxB = courseTypeGrades[b]!.reduce((x, y) => x > y ? x : y);
        return maxB.compareTo(maxA); // De mayor a menor
      });

    // Crear los grupos de barras para el gráfico
    final List<BarChartGroupData> barGroups = [];
    double globalMaxGrade = 0.0;
    int index = 0;
    for (final type in sortedKeys) {
      final grades = courseTypeGrades[type]!;
      final double minGrade = grades.reduce((a, b) => a < b ? a : b);
      final double maxGrade = grades.reduce((a, b) => a > b ? a : b);
      globalMaxGrade = math.max(globalMaxGrade, maxGrade);

      List<BarChartRodData> rods = [];
      if (minGrade == maxGrade) {
        // Nota única: barra morada
        rods.add(
          BarChartRodData(
            toY: minGrade,
            width: 6,
            color: Colors.purple,
            borderRadius: BorderRadius.circular(0),
          ),
        );
      } else {
        // Dos barras: una para la nota mínima (azul) y otra para la máxima (roja)
        rods.add(
          BarChartRodData(
            toY: minGrade,
            width: 6,
            color: Colors.blue,
            borderRadius: BorderRadius.circular(0),
          ),
        );
        rods.add(
          BarChartRodData(
            toY: maxGrade,
            width: 6,
            color: Colors.red,
            borderRadius: BorderRadius.circular(0),
          ),
        );
      }
      barGroups.add(
        BarChartGroupData(
          x: index,
          barRods: rods,
        ),
      );
      index++;
    }

    // Definir el valor máximo del eje Y con un pequeño margen
    const double marginFactor = 0.1;
    final double tentativeMaxY =
        (globalMaxGrade > 0) ? globalMaxGrade * (1 + marginFactor) : 20;
    final double finalMaxY = math.min(20, tentativeMaxY); // Nunca más de 20

    // Definir el valor mínimo del eje Y
    final double globalMinGrade = allCourses.isNotEmpty
        ? allCourses.map((c) => c.grade).reduce((a, b) => a < b ? a : b)
        : 0;
    final double tentativeMinY = globalMinGrade - 1;
    final double finalMinY = tentativeMinY < 0 ? 0 : tentativeMinY;
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Notas por Categoría de Cursos',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Agregar la leyenda con tres elementos:
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LegendsListWidget(
                legends: [
                  Legend('Nota única', Colors.purple),
                  Legend('Mínima', Colors.blue),
                  Legend('Máxima', Colors.red),
                ],
              )
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            // height: 300,
            height: sortedKeys.length * 35,
            child: BarChart(
              BarChartData(
                // Hacemos la gráfica horizontal rotándola 90 grados
                rotationQuarterTurns: 1,
                alignment: BarChartAlignment.spaceAround,
                maxY: finalMaxY,
                minY: finalMinY,
                barGroups: barGroups,
                gridData: FlGridData(show: true),
                borderData: FlBorderData(
                  show: true,
                  border: const Border(
                    left: BorderSide(color: Colors.black12),
                    bottom: BorderSide(color: Colors.black12),
                    top: BorderSide(color: Colors.transparent),
                    right: BorderSide(color: Colors.transparent),
                  ),
                ),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      getTitlesWidget: (value, meta) {
                        return SideTitleWidget(
                          meta: meta,
                          child: Text(
                            value.toStringAsFixed(1),
                            style: const TextStyle(fontSize: 12),
                          ),
                        );
                      },
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 120,
                      getTitlesWidget: (value, meta) {
                        int idx = value.toInt();
                        if (idx < 0 || idx >= sortedKeys.length) {
                          return const SizedBox.shrink();
                        }
                        final prefix = sortedKeys[idx];
                        final displayName = coursePrefixes.containsKey(prefix)
                            ? '($prefix) ${coursePrefixes[prefix]}'
                            : prefix;
                        return SideTitleWidget(
                          meta: meta,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text(
                              displayName,
                              style: const TextStyle(fontSize: 10),
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                barTouchData: BarTouchData(
                  enabled: true,
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipColor: (group) => Colors.grey.shade200,
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      String label = '';
                      if (barGroups[groupIndex].barRods.length > 1) {
                        label = (rodIndex == 0) ? 'Min: ' : 'Max: ';
                      }
                      return BarTooltipItem(
                        '$label${rod.toY.toStringAsFixed(2)}',
                        const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton(
                onPressed: () {
                  _showInfoDialog(context);
                },
                child: Text('¿Qué significa esto?'),
              )
            ],
          )
        ],
      ),
    );
  }

  void _showInfoDialog(BuildContext context) {
    final Map<String, List<AcademicHistoryCourse>> courseGroups = {};
    final RegExp regex = RegExp(r'^[A-Za-z]+');

    for (final term in academicHistory) {
      for (final course in term.courses) {
        final match = regex.firstMatch(course.courseCode);
        if (match != null) {
          final type = match.group(0)!;
          courseGroups.putIfAbsent(type, () => []).add(course);
        }
      }
    }

    // Ordenar las agrupaciones por cantidad de cursos (de mayor a menor)
    final sortedGroups = courseGroups.entries.toList()
      ..sort((a, b) => b.value.length.compareTo(a.value.length));

    showDialog(
      context: context,
      builder: (context) {
        if (kDebugMode) {
          // Imprimir en consola para depuración
          for (final entry in sortedGroups) {
            final category = entry.key;
            final courses = entry.value;
            print('Categoría: $category (${courses.length} cursos)');
            for (final course in courses) {
              print('  - ${course.courseName} (${course.courseCode})');
            }
          }
        }

        return AlertDialog(
          title: const Text("Detalle de Categorías"),
          content: Container(
            width: double.maxFinite,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Las categorías se deducen del prefijo alfabético de cada código de curso. "
                    "Por ejemplo, 'EC' en 'ECXXXX' podría interpretarse como Economía. "
                    "Esta clasificación no es oficial, solo se basa en la agrupación de códigos.",
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 12),
                  ...sortedGroups.map((entry) {
                    final category = entry.key;
                    final courses = entry.value;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Categoría: $category",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        if (coursePrefixes.containsKey(category))
                          Text(
                            "${coursePrefixes[category]}",
                            style: const TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ...courses.map((course) => Padding(
                              padding: const EdgeInsets.only(left: 8.0, top: 2),
                              child: Text(
                                  "${course.courseName} (${course.courseCode})"),
                            )),
                        const SizedBox(height: 10),
                      ],
                    );
                  }).toList(),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cerrar"),
            ),
          ],
        );
      },
    );
  }
}

class Legend {
  final String name;
  final Color color;

  Legend(this.name, this.color);
}

class LegendsListWidget extends StatelessWidget {
  final List<Legend> legends;

  const LegendsListWidget({super.key, required this.legends});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 8,
      children: legends.map((legend) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: legend.color,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              legend.name,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        );
      }).toList(),
    );
  }
}
