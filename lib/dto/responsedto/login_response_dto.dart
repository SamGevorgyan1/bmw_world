import 'package:json_annotation/json_annotation.dart';

part 'login_response_dto.g.dart';

@JsonSerializable()
class LoginResponseDTO {
  final String sessionId;
  final String authToken;
  final bool result;

  LoginResponseDTO(this.sessionId, this.authToken, this.result);

  factory LoginResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseDTOFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResponseDTOToJson(this);
}
