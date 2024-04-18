import '../../../../core/resources/data_state/data_state.dart';
import '../../data/model/article.dart';
import '../../data/model/car.dart';
import '../entities/article_entity.dart';
import '../entities/post_entity.dart';

abstract class BmwWorldRepository {
  Future<DataState<List<ArticleEntity>>> getArticles();

  Future<DataState<ArticleModel>> getArticleById(int id);

  Future<DataState<List<PostEntity>>> getPosts();

  Future<DataState<CarModel>> getCarById(int id);
}
