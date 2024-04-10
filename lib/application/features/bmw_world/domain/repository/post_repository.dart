import 'package:bmw_world/application/features/bmw_world/domain/entities/post_entity.dart';

import '../../../../core/resources/data_state/data_state.dart';

abstract class PostRepository {
  Future<DataState<List<PostEntity>>> getPosts();
}
