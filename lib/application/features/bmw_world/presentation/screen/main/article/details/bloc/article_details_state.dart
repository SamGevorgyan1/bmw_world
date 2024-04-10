part of 'article_details_bloc.dart';

@immutable
 class ArticleDetailsState {

  final ArticleModel? article;
  final Object? error;
  final bool isLoading;

  const ArticleDetailsState({
    this.article,
    this.error,
    this.isLoading = false,
  });

  factory ArticleDetailsState.initial() => const ArticleDetailsState(isLoading: true);

  ArticleDetailsState articleLoaded(ArticleModel article) {
    return copyWith(article: article, isLoading: false);
  }

  ArticleDetailsState articleLoading() {
    return copyWith(isLoading: true);
  }

  ArticleDetailsState articleError(Object error) {
    return copyWith(error: error);
  }

  ArticleDetailsState copyWith({
    ArticleModel? article,
    Object? error,
    bool? isLoading,
  }) {
    return ArticleDetailsState(
      article: article ?? this.article,
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

