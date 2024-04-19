import 'package:bmw_world/application/core/resources/data_state/data_state.dart';
import 'package:bmw_world/application/core/usecase/use_case.dart';
import 'package:bmw_world/application/features/authentication/domain/repository/auth_repository.dart';

class LogoutUseCase extends UseCase<DataState<void>, void> {

  final AuthRepository _authRepository;

  LogoutUseCase(this._authRepository);

  @override
  Future<DataState<void>> call({void params})async {
    return await _authRepository.logout();
  }
}
