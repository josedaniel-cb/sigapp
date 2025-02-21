// This goes here because it is related to business logic.
class PendingSurveyException implements Exception {
  PendingSurveyException();

  @override
  String toString() =>
      'Encuestas pendientes, por favor completarlas y volver a intentar.';
}
