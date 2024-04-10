import 'package:json_annotation/json_annotation.dart';

part 'auth_response.g.dart';

@JsonSerializable()
class AuthResponse {
  @JsonKey(name: "access_token")
  final String? accessToken;
  @JsonKey(name: "refresh_token")
  final String? refreshToken;
  @JsonKey(name: "expires_in")
  final int? expiresIn;
  @JsonKey(name: "refresh_expires_in")
  final int? refreshExpiresIn;

  AuthResponse({
     this.accessToken,
     this.refreshToken,
     this.expiresIn,
     this.refreshExpiresIn,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) => _$AuthResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);
}
