import 'package:bmw_world/configuration/configuration.dart';
import 'package:bmw_world/domain/api_client/network_client.dart';
import 'package:bmw_world/dto/responsedto/login_response_dto.dart';

class AuthApiClient {
  final _networkClient = NetworkClient();

  Future<LoginResponseDTO> login(String email, String password) async {
    const uri = Configuration.baseLoginUri;

    final requestBody = {
      'email': email,
      'password': password,
    };
    final response =
        await _networkClient.post(uri, bodyParameters: requestBody, (json) {
      return LoginResponseDTO.fromJson(json);
    });

    return response;
  }
}
