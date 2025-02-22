import 'package:flutter/material.dart';

class ColorsUtils {
  ColorsUtils._();

  static Color getTextColorForBackground(Color backgroundColor) {
    double calculateLuminance(Color color) {
      final double r = color.r / 255;
      final double g = color.g / 255;
      final double b = color.b / 255;
      return 0.299 * r + 0.287 * g + 0.114 * b;
    }

    return calculateLuminance(backgroundColor) > 0.5
        ? Colors.black
        : Colors.white;
  }
}
