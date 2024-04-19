import 'package:bmw_world/application/core/resources/data_state/data_state.dart';
import 'package:bmw_world/application/core/usecase/use_case.dart';
import 'package:bmw_world/application/features/authentication/domain/dto/register_request.dart';
import 'package:bmw_world/application/features/authentication/domain/repository/auth_repository.dart';

class RegistrationUseCase implements UseCase<DataState<void>, RegisterRequest> {
  final AuthRepository _authRepository;

  const RegistrationUseCase(this._authRepository);

  @override
  Future<DataState<void>> call({RegisterRequest? params}) async {
    if (params == null) {
      throw ArgumentError('Params cannot be null');
    }
    return await _authRepository.register(params);
  }
}
