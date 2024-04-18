import 'package:bmw_world/application/features/bmw_world/domain/entities/article_entity.dart';
import '../../../../../../core/resources/data_state/data_state.dart';

abstract class ArticleLocalService {
  Future<DataState<List<ArticleEntity>>> createList(List<ArticleEntity> articleEntities);
  Future<DataState<List<ArticleEntity>>> getAll();
  Future<void> deleteAll();
}
