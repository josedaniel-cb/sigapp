import 'package:logger/logger.dart';
// import 'package:firebase_crashlytics/firebase_crashlytics.dart'; // Agregar cuando se implemente Firebase

/// LogOutput personalizado para enviar logs a Firebase Crashlytics
///
/// En desarrollo: no hace nada (logs van a console)
/// En producción: envía errores críticos a Crashlytics y logs informativos como breadcrumbs
class FirebaseLogOutput extends LogOutput {
  @override
  void output(OutputEvent event) {
    // TODO: Implementar cuando se agregue firebase_crashlytics
    // Por ahora, preparación para futuro

    for (final line in event.lines) {
      // Errores críticos → recordError en Crashlytics
      if (event.level.index >= Level.error.index) {
        // FirebaseCrashlytics.instance.recordError(
        //   line,
        //   null,
        //   fatal: event.level == Level.fatal,
        // );
      }

      // Todos los logs → breadcrumbs en Crashlytics
      // FirebaseCrashlytics.instance.log(line);
    }
  }
}
