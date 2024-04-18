import 'package:bmw_world/application/features/authentication/data/model/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class _Keys {
  static const userKey = "userKey";
}

class UserProvider {
  final FlutterSecureStorage _secureStorage;

  const UserProvider(this._secureStorage);

  Future<void> setUser(User user) async {
    await _secureStorage.write(key: _Keys.userKey, value: user.toJsonString());
  }

  Future<User?> getUser() async {
    final userData = await _secureStorage.read(key: _Keys.userKey);
    if (userData != null) {
      return User.fromJsonString(userData);
    } else {
      return null;
    }
  }

  Future<void> deleteUser() async {
    await _secureStorage.delete(key: _Keys.userKey);
  }
}
