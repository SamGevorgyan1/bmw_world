import 'package:bmw_world/application/core/resources/data_state/data_state.dart';
import 'package:bmw_world/application/core/usecase/use_case.dart';
import 'package:bmw_world/application/features/bmw_world/data/model/car.dart';
import 'package:bmw_world/application/features/bmw_world/domain/repository/bmw_world_repository.dart';

class GetCarUseCase implements UseCase<DataState<CarModel>, int> {
  final BmwWorldRepository _bmwWorldRepository;

  const GetCarUseCase(this._bmwWorldRepository);

  @override
  Future<DataState<CarModel>> call({int params = 1}) {
    return _bmwWorldRepository.getCarById(params);
  }
}
