import 'package:bmw_world/application/core/resources/data_state/data_state.dart';
import 'package:bmw_world/application/core/usecase/use_case.dart';
import 'package:bmw_world/application/features/bmw_world/domain/entities/post_entity.dart';
import 'package:bmw_world/application/features/bmw_world/domain/repository/bmw_world_repository.dart';

class GetPostsUseCase implements UseCase<DataState<List<PostEntity>>, void> {
  final BmwWorldRepository _bmwWorldRepository;

  const GetPostsUseCase(this._bmwWorldRepository);

  @override
  Future<DataState<List<PostEntity>>> call({void params}) {
    return _bmwWorldRepository.getPosts();
  }
}
