import 'package:bmw_world/application/features/bmw_world/data/model/car.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../../core/constants/constants.dart';

part 'car_api_service.g.dart';

@RestApi(baseUrl: carApiBaseURl)
abstract class CarApiService {
  factory CarApiService(Dio dio) = _CarApiService;

  @GET('/{id}')
  Future<HttpResponse<CarModel>> get(@Path('id') int id);
}
