import 'package:bmw_world/application/core/resources/data_state/data_state.dart';

import '../../data/dto/auth_response.dart';


abstract class AuthRepository {
  Future<DataState<AuthResponse>> login(String email, String password);
}
