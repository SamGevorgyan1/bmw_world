import 'package:dio/dio.dart';

String getExceptionMessage({
  Object? exception,
  String badRequestMessage = "Bad request",
  String conflictMessage = "Conflict exception",
  String defaultMessage = "Something Went Wrong"
}) {
  if (exception is DioException) {
    switch (exception.response?.statusCode) {
      case 400:
        return badRequestMessage;
      case 409:
        return conflictMessage;
      default:
        return defaultMessage;
    }
  }
  return defaultMessage;
}
