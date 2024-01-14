import 'package:bmw_world/domain/api_client/network_client.dart';
import 'package:bmw_world/model/_car.dart';

class CarApi {
  final NetworkClient _networkClient = NetworkClient();

  Future<Car> getCarById(int carId) async {
    final url = '/car/$carId';

    try {
      final car = await _networkClient.get(url, (json) => Car.fromJson(json));
      return car;
    } catch (e) {
      rethrow;
    }
  }
}
