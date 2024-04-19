import 'package:bmw_world/application/core/resources/data_state/data_state.dart';
import 'package:bmw_world/application/core/usecase/use_case.dart';
import 'package:bmw_world/application/features/authentication/domain/repository/auth_repository.dart';
import 'package:bmw_world/application/features/authentication/domain/value_object/verify_params.dart';

class VerifyUseCase implements UseCase<DataState, VerifyParams> {
  final AuthRepository _authRepository;

  VerifyUseCase(this._authRepository);

  @override
  Future<DataState> call({VerifyParams? params}) async {
    if (params == null) {
      throw ArgumentError('Params cannot be null');
    }
    return _authRepository.verify(params.email, params.verificationCode);
  }
}
