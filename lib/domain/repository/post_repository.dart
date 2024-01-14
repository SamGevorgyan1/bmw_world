import 'package:bmw_world/domain/api_client/post_api.dart';
import 'package:bmw_world/model/post.dart';

class PostRepository {
  final _postApi = PostApi();

  Future<List<Post>> getAllPost(Map<String, String>? parameters) async {
    return await _postApi.getAllPost(parameters);
  }
}
