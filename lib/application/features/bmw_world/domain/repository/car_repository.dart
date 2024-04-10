import 'package:bmw_world/application/features/bmw_world/data/model/car.dart';

import '../../../../core/resources/data_state/data_state.dart';

abstract class CarRepository {
  const CarRepository();
  Future<DataState<CarModel>> get(int id);
}
