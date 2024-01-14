import 'package:bmw_world/domain/api_client/car_api.dart';
import 'package:bmw_world/model/_car.dart';

class CarRepository {
  final _carApi = CarApi();

  Future<Car> getCarById(int carId) {
    return _carApi.getCarById(carId);
  }
}
