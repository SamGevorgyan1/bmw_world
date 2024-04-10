import 'package:bmw_world/application/features/bmw_world/domain/entities/post_entity.dart';

import '../../../../../../core/resources/data_state/data_state.dart';

abstract class PostLocalService {
 // Future<DataState<PostEntity>> create(PostEntity postEntity);
  Future<DataState<List<PostEntity>>> createList(List<PostEntity> postEntities);
  Future<DataState<List<PostEntity>>> getAll();
  Future<void> deleteAll();
}
