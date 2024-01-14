import 'package:bmw_world/domain/api_client/article_api.dart';
import 'package:bmw_world/model/article.dart';

class ArticleRepository {
  final _articleApi = ArticleApi();

  Future<List<Article>> getAllArticle() async {
    return _articleApi.getAllArticle();
  }

  Future<Article> getArticleById(int articleId) async {
    return _articleApi.getArticleById(articleId);
  }
}
