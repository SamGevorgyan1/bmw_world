import 'package:bmw_world/application/features/authentication/data/data_provider/user_provider.dart';
import 'package:bmw_world/application/features/authentication/data/model/user.dart';

import '../../../../core/usecase/use_case.dart';

class GetUserUseCase implements UseCase<User?, void> {
  final UserProvider _userProvider;

  const GetUserUseCase(this._userProvider);

  @override
  Future<User?> call({void params}) async {
    return await _userProvider.getUser();
  }
}
