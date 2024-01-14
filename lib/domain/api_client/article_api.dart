import 'package:bmw_world/configuration/configuration.dart';
import 'package:bmw_world/domain/api_client/network_client.dart';
import 'package:bmw_world/model/article.dart';

class ArticleApi {
  final _networkClient = NetworkClient();

  Future<List<Article>> getAllArticle() async {
    const String uri = Configuration.articlesUri;

    final articles = await _networkClient.get(uri, (json) {
      if (json is List) {
        return json.map((e) => Article.fromJson(e)).toList();
      } else {
        throw Exception("Invalid response format");
      }
    });
    return articles;
  }

  Future<Article> getArticleById(int articleId) async {
    const String articleBaseUri = Configuration.baseArticleUri;

    final String uri = "$articleBaseUri/$articleId";

    try {
      return await _networkClient.get(uri, (json) => Article.fromJson(json));
    } catch (error) {
      rethrow;
    }
  }
}
