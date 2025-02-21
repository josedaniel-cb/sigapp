import 'package:sigapp/auth/domain/value-objects/api_path_and_method.dart';
import 'package:sigapp/auth/domain/value-objects/api_response.dart';

abstract class SessionLifecycleService {
  // bool evaluateSessionExpiration(
  //     {required Map<String, List<String>> headers, required int statusCode});
  void configureSurveyAssertionInterceptors({
    required Future<void> Function(ApiResponse response) ensureNoPendingSurvey,
  });
  void configureSessionInterceptors({
    required Future<void> Function() awaitOngoingSessionRefresh,
    required List<ApiPathAndMethod> excludedEndpointsFromRefresh,
    required void Function() onSessionExpired,
  });
  bool evaluateIsSurveyAvailable(ApiResponse response);
}
