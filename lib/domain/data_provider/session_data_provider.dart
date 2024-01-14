import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class _Keys {
  static const sessionId = 'session_id';
  static const token = 'token';
}

class SessionDataProvider {
  static const _secureStorage = FlutterSecureStorage();

  Future<String?> getSessionId() => _secureStorage.read(key: _Keys.sessionId);

  Future<void> setSessionId(String value) {
    return _secureStorage.write(key: _Keys.sessionId, value: value);
  }

  Future<void> deleteSessionId() {
    return _secureStorage.delete(key: _Keys.sessionId);
  }

  Future<String?> getToken() async {
    final token = await _secureStorage.read(key: _Keys.token);
    return token;
  }

  Future<void> setToken(String value) {
    return _secureStorage.write(
      key: _Keys.token,
      value: value,
    );
  }

  Future<void> deleteToken() {
    return _secureStorage.delete(key: _Keys.token);
  }
}
