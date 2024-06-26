import 'package:bloc/bloc.dart';
import 'package:bmw_world/application/features/bmw_world/data/model/article.dart';
import 'package:meta/meta.dart';

import '../../../../../domain/usecases/get_article.dart';

part 'article_details_event.dart';

part 'article_details_state.dart';

class ArticleDetailsBloc extends Bloc<ArticleDetailsEvent, ArticleDetailsState> {
  final GetArticleUseCase getArticleUseCase;

  ArticleDetailsBloc(this.getArticleUseCase) : super(ArticleDetailsState.initial()) {
    on<_LoadArticleDetailsEvent>(_onLoadArticle);
  }

  void _onLoadArticle(_LoadArticleDetailsEvent event, Emitter<ArticleDetailsState> emit) async {
    try {
      final dataState = await getArticleUseCase.call(params: event.id);

      dataState.when(
        success: (data)=>emit(state.articleLoaded(data)),
        failure: (exception)=> emit(state.articleError(exception)),
      );
    } catch (error) {
      emit(state.articleError(error));
    }
  }
}
