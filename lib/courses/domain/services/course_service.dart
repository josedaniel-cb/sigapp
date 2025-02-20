import 'package:injectable/injectable.dart';

@singleton
class CourseService {
  /// --------------------------------------------------------
  /// LOGIC TO EXTRACT INITIALS
  /// --------------------------------------------------------
  ///
  /// In this example:
  /// - Certain short words ("de", "y", "la", etc.) are ignored.
  /// - If the last word is a Roman numeral (I, II, III...),
  ///   it is converted to a decimal number and added with a space at the end.
  /// - For simplicity, the first two words are taken
  ///   (after filtering the short ones). Adjust to your preference.
  String extractInitials(String name) {
    // Convert to uppercase for consistency
    name = name.toUpperCase().trim();

    // Words to ignore (you can customize them)
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

    // Possible Roman numerals you want to support
    // (you can extend with IV, IX, etc. according to your case)
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

    // Split by spaces
    final parts = name.split(RegExp(r'\s+'));
    if (parts.isEmpty) return '';

    // Check if the last part is a Roman numeral
    String? romanNumber;
    if (romanMap.containsKey(parts.last)) {
      romanNumber = parts.removeLast(); // remove it from the array
    }

    // Filter the ignored words
    final significantWords =
        parts.where((w) => !ignoredWords.contains(w)).toList();

    // If nothing is left, force at least the 1st original word
    if (significantWords.isEmpty && parts.isNotEmpty) {
      significantWords.add(parts.first);
    }

    // Take at most 2 words (or as many as you want)
    if (significantWords.length > 2) {
      significantWords.removeRange(2, significantWords.length);
    }

    // Build the initials:
    // - 1 letter for each significant word (you can adjust to 2, 3 letters, etc.)
    String initials = significantWords.map((w) => w.substring(0, 1)).join();

    // If there was a Roman numeral, convert it to decimal and add it
    if (romanNumber != null) {
      final decimal = romanMap[romanNumber]!;
      initials += ' $decimal';
    }

    return initials;
  }

  /// --------------------------------------------------------
  /// LOGIC TO GET BACKGROUND COLOR
  /// --------------------------------------------------------
  ///
  /// This example uses a maximum of 10 colors in a palette
  /// and selects one based on the hashCode of the courseCode.
  /// You can use the courseName instead or combine both.
  int getBackgroundColor(String name) {
    final palette = <int>[
      // Colors.red,
      0xFFF44336,
      // Colors.blue,
      0xFF2196F3,
      // Colors.green,
      0xFF4CAF50,
      // Colors.orange,
      0xFFFF9800,
      // Colors.purple,
      0xFF9C27B0,
      // Colors.teal,
      0xFF009688,
      // Colors.brown,
      0xFF795548,
      // Colors.deepOrange,
      0xFFFF5722,
      // Colors.indigo,
      0xFF3F51B5,
      // Colors.pink,
      0xFFE91E63,
    ];

    // Index based on the hashCode of the code
    // abs() to avoid negative values.
    final index = name.hashCode.abs() % palette.length;
    print(
        'CourseService.getBackgroundColor($name) => index: $index, color: ${palette[index].toRadixString(16)}');
    return palette[index];
  }
}
