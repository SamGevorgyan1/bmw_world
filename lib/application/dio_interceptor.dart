import 'package:dio/dio.dart';

import 'features/bmw_world/data/data_provider/token_provider.dart';

import 'injection_container.dart';

class DioInterceptor extends Interceptor {

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await TokenProvider(sl()).getAccessToken();

   // options.headers.addAll({
   //   "Content-Type": "application/json",
   // });
    if (token != null) {
      options.headers.addAll({
        "Authorization": "Bearer $token",
      });
    }
    return super.onRequest(options, handler);
  }
}