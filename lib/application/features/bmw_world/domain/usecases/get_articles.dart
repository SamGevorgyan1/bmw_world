import 'package:bmw_world/application/core/resources/data_state/data_state.dart';
import 'package:bmw_world/application/core/usecase/use_case.dart';
import 'package:bmw_world/application/features/bmw_world/data/model/article.dart';
import 'package:bmw_world/application/features/bmw_world/domain/repository/article_repository.dart';

class GetArticlesUseCase implements UseCase<DataState<List<ArticleModel>>, void> {
  final ArticleRepository _articleRepository;

  const GetArticlesUseCase(this._articleRepository);

  @override
  Future<DataState<List<ArticleModel>>> call({void params}) {
    return _articleRepository.getAll();
  }
}
