import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class _Keys {
  static const accessToken = "access_token";
  //static const refreshToken = "refresh_token";
}

class TokenProvider {
  final FlutterSecureStorage _secureStorage;

 const TokenProvider(this._secureStorage);

  Future<void> setAccessToken(String accessToken) async {
    return await _secureStorage.write(key: _Keys.accessToken, value: accessToken);
  }

  Future<String?> getAccessToken() async {
    return await _secureStorage.read(key: _Keys.accessToken);
  }

  Future<void> deleteAccessToken() async {
    return await _secureStorage.delete(key: _Keys.accessToken);
  }
}
