import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:sigapp/auth/domain/services/navigation_service.dart';
import 'package:toastification/toastification.dart';

@Singleton(as: NavigationService)
class NavigationServiceImpl implements NavigationService {
  final GoRouter _router;

  NavigationServiceImpl(this._router);

  @override
  void refreshNavigation([String? message, bool? isError]) {
    if (message != null) {
      toastification.show(
        title: Text(message),
        type: (isError ?? false)
            ? ToastificationType.error
            : ToastificationType.info,
        autoCloseDuration: const Duration(seconds: 8),
      );
    }
    _router.refresh();
  }
}
