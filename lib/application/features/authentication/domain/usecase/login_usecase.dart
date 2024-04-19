import 'package:bmw_world/application/core/resources/data_state/data_state.dart';
import 'package:bmw_world/application/core/usecase/use_case.dart';
import 'package:bmw_world/application/features/authentication/domain/dto/login_request.dart';
import 'package:bmw_world/application/features/authentication/domain/repository/auth_repository.dart';
import '../model/user.dart';

class LoginUseCase implements UseCase<DataState<User>, LoginRequest> {
  final AuthRepository _authRepository;

  const LoginUseCase(this._authRepository);

  @override
  Future<DataState<User>> call({LoginRequest? params}) {
    if (params == null) {
      throw ArgumentError('Params cannot be null');
    }
    return _authRepository.login(params.email, params.password);
  }
}
