class ApiException implements Exception {
  final String message;
  final int statusCode;
  final String? responseData;

  ApiException({required this.message, required this.statusCode, this.responseData});

  @override
  String toString() => 'ApiException: $message (Status: $statusCode)';
}

class NetworkException extends ApiException {
  NetworkException() : super(message: 'No internet connection', statusCode: 0);
}

class TimeoutException extends ApiException {
  TimeoutException() : super(message: 'Request timed out', statusCode: 408);
}
