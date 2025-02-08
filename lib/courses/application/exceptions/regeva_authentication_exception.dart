// This goes here because it is related to application-level logic.
class RegevaAuthenticationException implements Exception {
  final String message;

  RegevaAuthenticationException(this.message);

  @override
  String toString() => 'RegevaAuthenticationException: $message';
}
