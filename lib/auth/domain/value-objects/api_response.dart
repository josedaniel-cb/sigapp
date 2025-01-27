class ApiResponse {
  final int statusCode;
  final Map<String, List<String>> headers;

  ApiResponse({required this.statusCode, required this.headers});
}
