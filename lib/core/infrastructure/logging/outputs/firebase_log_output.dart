import 'package:logger/logger.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

/// Custom LogOutput to send logs to Firebase Crashlytics
///
/// In development: does nothing (logs go to console)
/// In production: sends critical errors to Crashlytics and informational logs as breadcrumbs
class FirebaseLogOutput extends LogOutput {
  @override
  void output(OutputEvent event) {
    // Critical errors → recordError in Crashlytics
    if (event.level.index >= Level.error.index) {
      // Use original error and stackTrace if available
      final error =
          event.origin.error ?? event.origin.message ?? event.lines.join('\n');
      final stackTrace = event.origin.stackTrace;

      FirebaseCrashlytics.instance.recordError(
        error,
        stackTrace,
        fatal: event.level == Level.fatal,
      );
      return; // Don't duplicate as breadcrumb
    }

    // Informative logs → add as breadcrumbs
    final message = event.origin.message ?? event.lines.join('\n');
    FirebaseCrashlytics.instance.log(message);
  }
}
