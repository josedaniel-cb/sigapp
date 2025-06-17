import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'outputs/firebase_log_output.dart';

/// Configuración centralizada del Logger package
/// Se configura automáticamente por entorno:
/// - kDebugMode: logs bonitos en console
/// - kReleaseMode: logs a Firebase Crashlytics
Logger createLogger() {
  return Logger(
    filter: kReleaseMode ? ProductionFilter() : DevelopmentFilter(),
    printer:
        kReleaseMode
            ? SimplePrinter()
            : PrettyPrinter(
              methodCount: 2,
              errorMethodCount: 8,
              lineLength: 120,
              colors: true,
              printEmojis: true,
              dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
            ),
    output: MultiOutput([
      if (kDebugMode) ConsoleOutput(),
      if (kReleaseMode) FirebaseLogOutput(),
    ]),
  );
}
