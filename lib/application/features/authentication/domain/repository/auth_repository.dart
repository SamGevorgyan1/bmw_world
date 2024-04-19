import 'package:bmw_world/application/core/resources/data_state/data_state.dart';
import 'package:bmw_world/application/features/authentication/domain/dto/register_request.dart';
import 'package:bmw_world/application/features/authentication/domain/model/user.dart';


abstract class AuthRepository {
  Future<DataState<User>> login(String email, String password);
  Future<DataState<void>> register(RegisterRequest request);
  Future<DataState<void>> verify(String email, String verificationCode);
  Future<DataState<void>> sendVerificationCode(String email);
  Future<DataState<void>> logout();
}
