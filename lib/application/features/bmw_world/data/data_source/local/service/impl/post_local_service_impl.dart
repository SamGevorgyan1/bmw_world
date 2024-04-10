import 'package:bmw_world/application/core/resources/data_state/data_state.dart';
import 'package:bmw_world/application/features/bmw_world/domain/entities/post_entity.dart';
import '../../../dao/postdb2.dart';
import '../post_local_service.dart';

class PostLocalServiceImpl implements PostLocalService {
  final PostDb2 postDb2;

  const PostLocalServiceImpl(this.postDb2);

  @override
  Future<DataState<PostEntity>> create(PostEntity postEntity) async {
    try {
      final postId = await postDb2.insert(postEntity);
      if (postId != null) {
        return DataSuccess(postEntity);
      } else {
        return DataFailed(Exception('Failed to create post.'));
      }
    } catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<List<PostEntity>>> createList(List<PostEntity> postEntities) async {
    try {
      for (final post in postEntities) {
        await postDb2.insert(post);
      }
      return DataSuccess(postEntities);
    } catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<List<PostEntity>>> getAll() async {
    try {
      final dataState = await postDb2.getAll();
      return DataSuccess(dataState.data!);
    } catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<void> deleteAll() async {
    await postDb2.deleteAll();
  }
}
