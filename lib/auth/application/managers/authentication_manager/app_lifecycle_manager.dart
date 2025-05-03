import 'package:flutter/widgets.dart';
import 'dart:developer' as developer;

/// Gestiona el ciclo de vida de la aplicación
class AppLifecycleManager with WidgetsBindingObserver {
  DateTime? _lastBackgroundTime;
  final Function(Duration) onAppResumed;
  final Function() onAppPaused;

  AppLifecycleManager({
    required this.onAppResumed,
    required this.onAppPaused,
  }) {
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _lastBackgroundTime = DateTime.now();
      onAppPaused();
      developer.log(
        'App entró en segundo plano',
        name: 'AppLifecycleManager',
      );
    } else if (state == AppLifecycleState.resumed) {
      final now = DateTime.now();
      final timeSinceBackground = _lastBackgroundTime != null
          ? now.difference(_lastBackgroundTime!)
          : const Duration(seconds: 0);

      developer.log(
        'App volvió a primer plano después de ${timeSinceBackground.inSeconds} segundos',
        name: 'AppLifecycleManager',
      );

      onAppResumed(timeSinceBackground);
    }
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
  }
}
