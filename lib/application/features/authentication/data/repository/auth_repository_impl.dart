import 'package:bmw_world/application/core/helper/helper.dart';
import 'package:bmw_world/application/core/resources/data_state/data_state.dart';
import 'package:bmw_world/application/features/authentication/data/api/auth_api_service.dart';
import 'package:bmw_world/application/features/authentication/data/dto/login_request.dart';
import 'package:bmw_world/application/features/authentication/data/dto/register_request.dart';
import 'package:bmw_world/application/features/authentication/domain/repository/auth_repository.dart';

import 'package:dio/dio.dart';

import '../dto/auth_response.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApiService _authApiService;

  AuthRepositoryImpl(this._authApiService);

  @override
  Future<DataState<AuthResponse>> login(String email, String password) async {
    try {
      final httpResponse =
          await _authApiService.login(LoginRequest(email: email, password: password).toJson());
      return handleResponse(httpResponse.response, httpResponse.data);
    } catch (e) {
      return DataState.error(e);
    }
  }

  @override
  Future<DataState<void>> register(RegisterRequest request) async {
    try {
      final httpResponse = await _authApiService.register(request.toJson());
      return handleResponse<void>(httpResponse.response, null);
    } catch (error) {
      return DataState.error(error);
    }
  }

  @override
  Future<DataState<void>> sendVerificationCode(String email) async {
    try {
      final httpResponse = await _authApiService.sendVerificationCode(email);
      return handleResponse<void>(httpResponse.response, null);
    } on DioException catch (error) {
      return DataState.error(error);
    } catch (error) {
      return DataState.error(error);
    }
  }

  @override
  Future<DataState<void>> verify(String email, String verificationCode) async {
    try {
      final httpResponse = await _authApiService.verify(verificationCode, email);
      return handleResponse<void>(httpResponse.response, null);
    } catch (error) {
      return DataState.error(error);
    }
  }
}
