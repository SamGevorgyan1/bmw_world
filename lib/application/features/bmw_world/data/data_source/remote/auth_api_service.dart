import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../../core/constants/constants.dart';
import '../../dto/auth_response.dart';
import '../../dto/login_request.dart';

part 'auth_api_service.g.dart';

@RestApi(baseUrl: authApiBaseURl)
abstract class AuthApiService {
  factory AuthApiService(Dio dio) = _AuthApiService;

  @POST('/login')
  Future<HttpResponse<AuthResponse>> login(@Body() LoginRequest request);
}
