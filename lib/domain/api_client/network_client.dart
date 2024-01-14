import 'dart:io';
import 'package:bmw_world/configuration/configuration.dart';
import 'package:bmw_world/domain/data_provider/session_data_provider.dart';
import 'package:bmw_world/exception/api_client_exception.dart';
import 'package:dio/dio.dart';

class NetworkClient {
  final Dio _dio = Dio();

  Uri _makeUri(String path, [Map<String, dynamic>? parameters]) =>
      parameters != null
          ? Uri.parse('${Configuration.baseUrl}$path')
              .replace(queryParameters: parameters)
          : Uri.parse('${Configuration.baseUrl}$path');

  Future<T> _handleRequest<T>(
    String path,
    T Function(dynamic json) parser, {
    Map<String, dynamic>? parameters,
    Map<String, dynamic>? bodyParameters,
    String method = 'get',
  }) async {
    try {
      final url = _makeUri(path, parameters);

      Response response;

      final SessionDataProvider sessionDataProvider = SessionDataProvider();
      final token = await sessionDataProvider.getToken();
      print(token);

      if (method == 'post') {
        response = await _dio.post(
          url.toString(),
          queryParameters: parameters,
          data: bodyParameters,
          options: Options(
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
            },
          ),
        );
      } else {
        response = await _dio.get(
          url.toString(),
          queryParameters: parameters,
          options: Options(
            headers: {
              if (token != null) "Authorization": "Bearer $token",
            },
          ),
        );
      }

      print("dio work");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final dynamic json = response.data;
        _validateResponse(response, json);
        return parser(json);
      } else {
        throw DioError(
          requestOptions: RequestOptions(path: url.toString()),
          response: response,
          type: DioErrorType.other,
          error: 'Failed to load data, status code: ${response.statusCode}',
        );
      }
    } catch (error) {
      throw DioError(
        requestOptions: RequestOptions(path: ''),
        response: Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 500,
          statusMessage: 'Internal Server Error',
          data: {'error': 'An unexpected error occurred'},
        ),
        type: DioErrorType.other,
        error: 'Unexpected error: $error',
      );
    }
  }

  Future<T> get<T>(
    String path,
    T Function(dynamic json) parser, {
    Map<String, dynamic>? parameters,
  }) async =>
      _handleRequest(path, parser, parameters: parameters);

  Future<T> post<T>(
    String path,
    T Function(dynamic json) parser, {
    Map<String, dynamic>? parameters,
    Map<String, dynamic>? bodyParameters,
  }) async =>
      _handleRequest(
        path,
        parser,
        parameters: parameters,
        bodyParameters: bodyParameters,
        method: 'post',
      );
  void _validateResponse(Response<dynamic> response, dynamic json) {
    if (response.statusCode == 401) {
      final dynamic status = json['message'];
      final code = status is int ? status : 0;
      if (code == 30) {
        throw ApiClientException(
          ApiClientExceptionType.auth,
          message: 'Authentication failed',
        );
      } else if (code == 3) {
        throw ApiClientException(ApiClientExceptionType.sessionExpired);
      } else {
        throw ApiClientException(ApiClientExceptionType.other);
      }
    } else if (response.statusCode == 400) {
      final dynamic errorMessage = json['message'];
      print(errorMessage);
      throw ApiClientException(ApiClientExceptionType.auth,
          message: errorMessage);
    }
  }
}
