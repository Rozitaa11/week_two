class AppException implements Exception {
  final String message;
  final int? statusCode;

  AppException(this.message, {this.statusCode});

  @override
  String toString() => message;
}

class NetworkException extends AppException {
  NetworkException(String message) : super(message);
}

class TimeoutException extends AppException {
  TimeoutException() : super("Request timeout");
}

class ServerException extends AppException {
  ServerException(String message, int statusCode)
    : super(message, statusCode: statusCode);
}
