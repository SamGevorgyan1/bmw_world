import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/constants/constants.dart';
import '../dto/auth_response.dart';

part 'auth_api_service.g.dart';

@RestApi(baseUrl: authApiBaseURl)
abstract class AuthApiService {
  factory AuthApiService(Dio dio) = _AuthApiService;

  @POST('/login')
  Future<HttpResponse<AuthResponse>> login(@Body() Map<String, dynamic> registerBody);

  @POST('/register')
  Future<HttpResponse<void>> register(@Body() Map<String, dynamic> registerBody);

  @POST("/verify")
  Future<HttpResponse<void>> verify(@Query("verifyCode") String verifyCode, @Query("email") String email);

  @POST("/send-verification-code")
  Future<HttpResponse<void>> sendVerificationCode(@Query("email") String email);
}
