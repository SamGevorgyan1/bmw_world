part of 'article_list_bloc.dart';

@immutable
class ArticleListState {
  final List<ArticleEntity>? articles;
  final Object? error;
  final bool isLoading;

  const ArticleListState({
    this.articles,
    this.error,
    this.isLoading = false,
  });



  factory ArticleListState.initial() => const ArticleListState(isLoading: true);

  ArticleListState articlesLoaded(List<ArticleEntity> articles) {
    return copyWith(articles: articles, isLoading: false);
  }

  ArticleListState articlesLoading() {
    return copyWith(isLoading: true);
  }

  ArticleListState articleError(Object error) {
    return copyWith(error: error);
  }

  ArticleListState copyWith({
    List<ArticleEntity>? articles,
    Object? error,
    bool? isLoading,
  }) {
    return ArticleListState(
      articles: articles ?? this.articles,
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
