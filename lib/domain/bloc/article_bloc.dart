import 'package:bmw_world/domain/repository/article_repository.dart';
import 'package:bmw_world/model/article.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ArticleEvent {}

class ArticleEventFetchList extends ArticleEvent {}

class ArticleEventReloadList extends ArticleEvent {}

class ArticleState {}

class ArticleLoadingState extends ArticleState {}

class ArticleErrorState extends ArticleState {
  final String errorMessage;

  ArticleErrorState({required this.errorMessage});
}

class ArticleLoadedState extends ArticleState {
  final List<Article> articles;

  ArticleLoadedState({required this.articles});
}

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final _articleRepository = ArticleRepository();

  ArticleBloc(ArticleState initialState) : super(initialState) {
    on<ArticleEvent>(
      (event, emit) async {
        if (event is ArticleEventFetchList) {
          await onArticleLoadedState(event, emit);
        }
      },
    );
  }
  Future<void> onArticleLoadedState(
    ArticleEventFetchList event,
    Emitter<ArticleState> emit,
  ) async {
    emit(ArticleLoadingState());
    try {
      emit(ArticleLoadedState(
          articles: await _articleRepository.getAllArticle()));
    } catch (e) {
      emit(ArticleErrorState(errorMessage: e.toString()));
    }
  }
}
