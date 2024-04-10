import 'dart:io';

import 'package:bmw_world/application/core/constants/constants.dart';
import 'package:bmw_world/application/core/resources/data_state/data_state.dart';
import 'package:bmw_world/application/features/bmw_world/data/data_source/remote/auth_api_service.dart';
import 'package:bmw_world/application/features/bmw_world/domain/repository/auth_repository.dart';

import 'package:dio/dio.dart';

import '../dto/auth_response.dart';


class AuthRepositoryImpl implements AuthRepository {
  final AuthApiService _authApiService;

  AuthRepositoryImpl(this._authApiService);

  @override
  Future<DataState<AuthResponse>> login(String email, String password) async {
    final requestBody = {
      'email': email,
      'password': password,
    };
    try {
      Dio dio = Dio();
      final httpResponse = await dio.post(
        "$baseUrl$authApiBaseURl/login",
        data: requestBody,
      );
      if (httpResponse.statusCode == HttpStatus.ok) {
        return DataSuccess(AuthResponse(accessToken: httpResponse.data["access_token"]));
      } else {
        return DataFailed(
          DioException(
            error: httpResponse.statusMessage,
            response: httpResponse,
            requestOptions: httpResponse.requestOptions,
          ),
        );
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
