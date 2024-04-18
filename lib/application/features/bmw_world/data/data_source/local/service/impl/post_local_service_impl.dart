import 'package:bmw_world/application/core/resources/data_state/data_state.dart';
import 'package:bmw_world/application/features/bmw_world/domain/entities/post_entity.dart';
import '../../../dao/post_database.dart';
import '../post_local_service.dart';

class PostLocalServiceImpl implements PostLocalService {
  final PostDatabase _postDb;

  const PostLocalServiceImpl(this._postDb);


  @override
  Future<DataState<List<PostEntity>>> createList(List<PostEntity> postEntities) async {
    try {
      for (final post in postEntities) {
        await _postDb.insert(post);
      }
      return DataSuccess(postEntities);
    } catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<List<PostEntity>>> getAll() async {
    try {
      final dataState = await _postDb.getAll();
      return DataSuccess(dataState.data!);
    } catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<void> deleteAll() async {
    await _postDb.deleteAll();
  }
}
