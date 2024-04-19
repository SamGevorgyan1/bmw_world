import 'package:bmw_world/application/core/resources/data_state/data_state.dart';
import 'package:bmw_world/application/core/usecase/use_case.dart';
import 'package:bmw_world/application/features/authentication/domain/repository/auth_repository.dart';
import 'package:bmw_world/application/features/authentication/domain/value_object/verify_params.dart';

class SendVerifyCodeUseCase implements UseCase<DataState, String> {
  final AuthRepository _authRepository;

  SendVerifyCodeUseCase(this._authRepository);

  @override
  Future<DataState> call({String? params}) async {
    if (params == null) {
      throw ArgumentError('Params cannot be null');
    }
    return await _authRepository.sendVerificationCode(params);
  }
}
