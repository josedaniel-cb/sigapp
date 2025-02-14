import 'package:flutter/material.dart';

/// Un pequeño widget que muestra un avatar circular
/// con las iniciales del curso y un color de fondo
/// derivado (hash) del nombre o código del curso.
class CourseAvatarWidget extends StatelessWidget {
  const CourseAvatarWidget({
    super.key,
    required this.courseName,
    required this.courseCode,
  });

  /// Nombre del curso, por ejemplo: "CALCULO INFINITESIMAL I"
  final String courseName;

  /// Código del curso, por ejemplo: "EC3446"
  /// (Se puede usar para el color, o para alguna otra lógica).
  final String courseCode;

  @override
  Widget build(BuildContext context) {
    // 1. Obtenemos las iniciales según tu propia lógica:
    final String initials = _extractInitials(courseName);

    // 2. Obtenemos un color desde la paleta (máx 10 colores),
    //    usando el courseCode, el courseName o ambos.
    final Color backgroundColor = _getBackgroundColor(courseCode);

    // return CircleAvatar(
    //   backgroundColor: backgroundColor,
    //   child: Text(
    //     initials,
    //     textAlign: TextAlign.center,
    //     style: const TextStyle(
    //       color: Colors.white,
    //       fontWeight: FontWeight.bold,
    //     ),
    //   ),
    // );

    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          initials,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 8 * 2,
          ),
        ),
      ),
    );
  }

  /// --------------------------------------------------------
  /// LÓGICA PARA EXTRAER INICIALES
  /// --------------------------------------------------------
  ///
  /// En este ejemplo:
  /// - Se ignoran ciertas palabras cortas ("de", "y", "la", etc.).
  /// - Si la última palabra es un numeral romano (I, II, III...),
  ///   se convierte a número decimal y se agrega con espacio al final.
  /// - Se toman, por simplicidad, las primeras dos palabras
  ///   (después de filtrar las cortas). Ajusta a tu preferencia.

  String _extractInitials(String name) {
    // Convertimos a mayúsculas por consistencia
    name = name.toUpperCase().trim();

    // Palabras a ignorar (puedes personalizarlas)
    const ignoredWords = {
      'DE',
      'DEL',
      'LA',
      'LAS',
      'LO',
      'LOS',
      'EL',
      'Y',
      'E',
      'A',
      'O',
      'EN',
      'UN',
      'UNA',
      'UNOS',
      'UNAS'
    };

    // Posibles numerales romanos que quieras soportar
    // (puedes extender con IV, IX, etc. según tu caso)
    final romanMap = <String, int>{
      'I': 1,
      'II': 2,
      'III': 3,
      'IV': 4,
      'V': 5,
      'VI': 6,
      'VII': 7,
      'VIII': 8,
      'IX': 9,
      'X': 10,
    };

    // Separamos por espacios
    final parts = name.split(RegExp(r'\s+'));
    if (parts.isEmpty) return '';

    // Revisamos si la última parte es un numeral romano
    String? romanNumber;
    if (romanMap.containsKey(parts.last)) {
      romanNumber = parts.removeLast(); // lo sacamos del arreglo
    }

    // Filtramos las palabras ignoradas
    final significantWords =
        parts.where((w) => !ignoredWords.contains(w)).toList();

    // Si no quedó nada, forzamos al menos la 1ra palabra original
    if (significantWords.isEmpty && parts.isNotEmpty) {
      significantWords.add(parts.first);
    }

    // Tomamos como máximo 2 palabras (o las que quieras)
    if (significantWords.length > 2) {
      significantWords.removeRange(2, significantWords.length);
    }

    // Construimos las iniciales:
    // - 1 letra por cada palabra significativa (puedes ajustar a 2, 3 letras, etc.)
    String initials = significantWords.map((w) => w.substring(0, 1)).join();

    // Si había un numeral romano, lo convertimos a decimal y lo agregamos
    if (romanNumber != null) {
      final decimal = romanMap[romanNumber]!;
      initials += ' $decimal';
    }

    return initials;
  }

  /// --------------------------------------------------------
  /// LÓGICA PARA OBTENER COLOR DE FONDO
  /// --------------------------------------------------------
  ///
  /// Este ejemplo usa un máximo de 10 colores en una paleta
  /// y selecciona uno en función del hashCode del courseCode.
  /// Puedes usar en su lugar el courseName o combinar ambos.

  Color _getBackgroundColor(String code) {
    // Paleta de ejemplo (puedes usar MaterialColors, BrandColors, etc.)
    final palette = <Color>[
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.teal,
      Colors.brown,
      Colors.deepOrange,
      Colors.indigo,
      Colors.pink,
    ];

    // Indice basado en el hashCode del code
    // abs() para evitar valores negativos.
    final index = code.hashCode.abs() % palette.length;
    return palette[index];
  }
}
