import 'package:bmw_world/application/features/authentication/domain/model/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class _Keys {
  static const accessToken = "accessTokenKey";
  static const userKey = "userKey";
}

class AuthenticationProvider{

  final FlutterSecureStorage _secureStorage;

  const AuthenticationProvider(this._secureStorage);

  Future<void> setAccessToken(String accessToken) async {
    return await _secureStorage.write(key: _Keys.accessToken, value: accessToken);
  }

  Future<String?> getAccessToken() async {
    return await _secureStorage.read(key: _Keys.accessToken);
  }

  Future<void> deleteAccessToken() async {
    return await _secureStorage.delete(key: _Keys.accessToken);
  }

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




