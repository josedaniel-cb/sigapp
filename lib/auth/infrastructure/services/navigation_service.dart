import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:sigapp/auth/domain/services/navigation_service.dart';

@Singleton(as: NavigationService)
class NavigationServiceImpl implements NavigationService {
  final GoRouter _router;

  NavigationServiceImpl(this._router);

  @override
  void refreshNavigation() {
    _router.refresh();
  }
}
