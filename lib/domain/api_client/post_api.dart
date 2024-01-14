import 'package:bmw_world/configuration/configuration.dart';
import 'package:bmw_world/domain/api_client/network_client.dart';
import 'package:bmw_world/model/post.dart';

class PostApi {
  final _networkClient = NetworkClient();

  Future<List<Post>> getAllPost(Map<String, String>? parameters) async {
    final posts = await _networkClient.get(
      Configuration.postLisUrl,
      parameters: parameters,
      (json) {
        if (json is List) {
          return json.map((posts) => Post.fromJson(posts)).toList();
        } else {
          throw Exception("Invalid response format");
        }
      },
    );
    return posts;
  }
}
