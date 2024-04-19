import 'dart:io';
import 'package:bmw_world/application/features/authentication/data/authentication_storage_provider/authentication_provider.dart';
import 'package:dio/dio.dart';
import 'di/injection_container.dart';

class DioInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await sl<AuthenticationProvider>().getAccessToken();
    // options.headers.addAll({
    //   HttpHeaders.contentTypeHeader: "application/json",
    // });

    if (token != null) {
      options.headers.addAll({
        HttpHeaders.authorizationHeader: "Bearer $token",
      });
    }
    return super.onRequest(options, handler);
  }
}
