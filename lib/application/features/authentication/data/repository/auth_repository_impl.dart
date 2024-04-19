import 'package:bmw_world/application/core/helper/helper.dart';
import 'package:bmw_world/application/core/resources/data_state/data_state.dart';
import 'package:bmw_world/application/features/authentication/data/api/auth_api_service.dart';
import 'package:bmw_world/application/features/authentication/data/authentication_storage_provider/authentication_provider.dart';
import 'package:bmw_world/application/features/authentication/domain/dto/login_request.dart';
import 'package:bmw_world/application/features/authentication/domain/dto/register_request.dart';
import 'package:bmw_world/application/features/authentication/domain/model/user.dart';
import 'package:bmw_world/application/features/authentication/domain/repository/auth_repository.dart';
import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApiService _authApiService;
  final AuthenticationProvider _authProvider;

  AuthRepositoryImpl(this._authApiService, this._authProvider);

  @override
  Future<DataState<User>> login(String email, String password) async {
    try {
      final httpResponse =
          await _authApiService.login(LoginRequest(email: email, password: password).toJson());
      final dataState = await handleResponse(httpResponse.response, httpResponse.data);

      if (dataState is DataSuccess) {
        final data = dataState.data!;
        _setAccessToken(data.accessToken!);
        final user = await _setUser(data.accessToken!);
        return DataState.success(user);
      } else {
        return DataState.error(dataState.exception!);
      }
    } catch (e) {
      return DataState.error(e);
    }
  }

  @override
  Future<DataState<void>> register(RegisterRequest request) async {
    try {
      final httpResponse = await _authApiService.register(request.toJson());
      return handleResponse<void>(httpResponse.response, 1);
    } catch (error) {
      return DataState.error(error);
    }
  }

  @override
  Future<DataState<void>> sendVerificationCode(String email) async {
    try {
      final httpResponse = await _authApiService.sendVerificationCode(email);
      return handleResponse<void>(httpResponse.response, 1);
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
      return handleResponse<void>(httpResponse.response, 1);
    } catch (error) {
      return DataState.error(error);
    }
  }

  @override
  Future<DataState<void>> logout() async {
    try {
      await _authProvider.deleteUser();
      await _authProvider.deleteAccessToken();
      return DataState.success(1);
    } catch (error) {
      return DataState.error(error);
    }
  }

  Future<void> _setAccessToken(String accessToken) async {
    await _authProvider.setAccessToken(accessToken);
  }

  Future<User> _setUser(String accessToken) async {
    final decodedToken = JwtDecoder.decode(accessToken);
    final user = User.fromJson(decodedToken);
    await _authProvider.setUser(user);
    return user;
  }
}
