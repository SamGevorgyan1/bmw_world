import 'package:bmw_world/application/core/resources/data_state/data_state.dart';
import 'package:bmw_world/application/features/authentication/data/dto/register_request.dart';

import '../../data/dto/auth_response.dart';


abstract class AuthRepository {
  Future<DataState<AuthResponse>> login(String email, String password);
  Future<DataState<void>> register(RegisterRequest request);
  Future<DataState<void>> verify(String email, String verificationCode);
  Future<DataState<void>> sendVerificationCode(String email);
}
