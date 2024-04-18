part of 'article_details_bloc.dart';

@immutable
sealed class ArticleDetailsEvent{
  const ArticleDetailsEvent();
  factory ArticleDetailsEvent.loadArticle({required int id}) =>  _LoadArticleDetailsEvent(id);

}
class _LoadArticleDetailsEvent extends ArticleDetailsEvent {
  const _LoadArticleDetailsEvent(this.id);
  final int id;

}