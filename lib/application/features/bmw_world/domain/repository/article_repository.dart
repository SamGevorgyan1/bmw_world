import 'package:bmw_world/application/features/bmw_world/data/model/article.dart';

import '../../../../core/resources/data_state/data_state.dart';

abstract class ArticleRepository {
  Future<DataState<List<ArticleModel>>> getAll();

  Future<DataState<ArticleModel>> get(int id);
}
