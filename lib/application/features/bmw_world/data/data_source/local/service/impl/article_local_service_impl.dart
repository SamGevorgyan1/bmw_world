import 'package:bmw_world/application/core/resources/data_state/data_state.dart';
import 'package:bmw_world/application/features/bmw_world/data/data_source/dao/article_database.dart';

import 'package:bmw_world/application/features/bmw_world/domain/entities/article_entity.dart';

import '../article_local_service.dart';

class ArticleLocalServiceImpl implements ArticleLocalService {
  final ArticleDatabase _articleDatabase;

  const ArticleLocalServiceImpl(this._articleDatabase);

  @override
  Future<DataState<List<ArticleEntity>>> createList(List<ArticleEntity> articleEntities) async {
    try {
      for (final article in articleEntities) {
        await _articleDatabase.insert(article);
      }
      return DataSuccess(articleEntities);
    } catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<List<ArticleEntity>>> getAll() async {
    try {
      final dataState = await _articleDatabase.getAll();
      return DataSuccess(dataState.data!);
    } catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<void> deleteAll() async {
    await _articleDatabase.deleteAll();
  }
}
