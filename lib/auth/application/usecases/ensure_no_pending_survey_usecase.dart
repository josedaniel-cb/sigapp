import 'package:injectable/injectable.dart';
import 'package:sigapp/auth/domain/value-objects/api_response.dart';
import 'package:sigapp/auth/domain/exceptions/session_exception.dart';

@injectable
class EnsureNoPendingSurveyUseCase {
  Future<void> execute(ApiResponse response) async {
    final String? locationValue = response.headers['location']?.first;

    if (locationValue == null) {
      return;
    }

    throw SessionException.pendingSurveyError(
      message:
          'Tienes encuestas pendientes que deben completarse en la versión web de SIGA',
      originalError: 'Redirección a encuesta pendiente: $locationValue',
    );
  }
}
