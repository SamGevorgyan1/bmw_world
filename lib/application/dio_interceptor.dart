import 'dart:io';
import 'package:dio/dio.dart';
import 'features/authentication/data/data_provider/token_provider.dart';
import 'di/injection_container.dart';

class DioInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await TokenProvider(sl()).getAccessToken();
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
