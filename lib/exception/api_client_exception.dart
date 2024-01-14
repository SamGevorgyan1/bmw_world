enum ApiClientExceptionType {
  network,
  auth,
  other,
  sessionExpired,
}

class ApiClientException implements Exception {
  final ApiClientExceptionType type;
  final String? message;
  final int? errorCode;

  ApiClientException(this.type, {this.message, this.errorCode});
}


