import 'package:bmw_world/application/features/authentication/data/authentication_storage_provider/authentication_provider.dart';
import 'package:bmw_world/application/features/authentication/domain/model/user.dart';

import '../../../../core/usecase/use_case.dart';

class GetUserUseCase implements UseCase<User?, void> {
  final AuthenticationProvider _authProvider;

  const GetUserUseCase(this._authProvider);

  @override
  Future<User?> call({void params}) async {
    return await _authProvider.getUser();
  }
}
