import 'package:bmw_world/application/core/resources/data_state/data_state.dart';
import 'package:bmw_world/application/core/usecase/use_case.dart';
import 'package:bmw_world/application/features/bmw_world/data/model/article.dart';
import 'package:bmw_world/application/features/bmw_world/domain/repository/article_repository.dart';

class GetArticleUseCase implements UseCase<DataState<ArticleModel>, int> {
  final ArticleRepository _articleRepository;

  const GetArticleUseCase(this._articleRepository);

  @override
  Future<DataState<ArticleModel>> call({int params = 1}) {
    return _articleRepository.get(params);
  }
}
