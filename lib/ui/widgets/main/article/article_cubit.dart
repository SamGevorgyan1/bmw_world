import 'package:bmw_world/domain/bloc/article_bloc.dart';
import 'package:bmw_world/model/article.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArticleCubitState {
  final List<ArticleRow> articles;

  ArticleCubitState({required this.articles});
}

class ArticleRow {
  final int id;
  final String imageUrl;
  final String title;

  ArticleRow({required this.id, required this.imageUrl, required this.title});
}

class ArticleCubit extends Cubit<ArticleCubitState> {
  @override
  bool isClosed = false;
  late ArticleBloc articleBloc;

  ArticleCubit({required this.articleBloc})
      : super(ArticleCubitState(articles: <ArticleRow>[])) {
    _setupBlocListener();
  }

  void _setupBlocListener() {
    articleBloc.stream.listen((event) {
      if (event is ArticleLoadedState) {
        _onState(event);
      }
    });
  }

  Future<void> loadArticles() async {
    if (articleBloc.isClosed) {
      articleBloc = ArticleBloc(ArticleLoadingState());
      _setupBlocListener();
    }

    articleBloc.add(ArticleEventFetchList());
  }

  void _onState(ArticleLoadedState state) {
    if (!isClosed) {
      final articles = state.articles.map(_makeArticleRow).toList();
      final newState = ArticleCubitState(articles: articles);
      emit(newState);
    } else {
      print('Attempted to emit state after closing ArticleCubit');
    }
  }

  @override
  Future<void> close() {
    isClosed = true;
    articleBloc.close();
    return super.close();
  }

  ArticleRow _makeArticleRow(Article article) {
    return ArticleRow(
      id: article.articleId,
      imageUrl: article.mainImageUri,
      title: article.title,
    );
  }
}
