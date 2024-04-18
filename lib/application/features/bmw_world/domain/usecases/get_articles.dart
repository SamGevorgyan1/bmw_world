import 'package:bmw_world/application/core/resources/data_state/data_state.dart';
import 'package:bmw_world/application/core/usecase/use_case.dart';
import 'package:bmw_world/application/features/bmw_world/domain/repository/bmw_world_repository.dart';

import '../entities/article_entity.dart';

class GetArticlesUseCase implements UseCase<DataState<List<ArticleEntity>>, void> {
  final BmwWorldRepository _bmwWorldRepository;

  const GetArticlesUseCase(this._bmwWorldRepository);

  @override
  Future<DataState<List<ArticleEntity>>> call({void params}) {
    return _bmwWorldRepository.getArticles();
  }
}
