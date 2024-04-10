part of 'article_list_bloc.dart';

@immutable
sealed class ArticleListEvent{
  const ArticleListEvent();
  factory ArticleListEvent.loadArticleList() => const _LoadArticleListEvent();
}
class _LoadArticleListEvent extends ArticleListEvent {
  const _LoadArticleListEvent();
}
