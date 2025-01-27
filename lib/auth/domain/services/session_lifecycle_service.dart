import 'package:sigapp/auth/domain/value-objects/api_path_and_method.dart';

abstract class SessionLifecycleService {
  bool evaluateSessionExpiration(
      {required Map<String, List<String>> headers, required int statusCode});
  void setup({
    required Future<void> Function() completeSessionRefresh,
    required List<ApiPathAndMethod> excludedRequests,
    required void Function() onSessionExpired,
  });
  void signOutRouter();
}
