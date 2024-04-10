import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:bmw_world/application/features/bmw_world/data/model/article.dart';
import 'package:bmw_world/application/features/bmw_world/domain/usecases/get_articles.dart';

import '../../../../../../../core/resources/data_state/data_state.dart';

part 'article_list_event.dart';

part 'article_list_state.dart';

class ArticleListBloc extends Bloc<ArticleListEvent, ArticleListState> {
  final GetArticlesUseCase _articlesUseCase;

  ArticleListBloc(this._articlesUseCase) : super(ArticleListState.initial()) {
    on<_LoadArticleListEvent>(_onGetArticles);
  }

  FutureOr<void> _onGetArticles(_LoadArticleListEvent event, Emitter<ArticleListState> emit) async {
    final dataState = await _articlesUseCase();
    
    if (dataState is DataSuccess) {
      emit(state.articlesLoaded(dataState.data!));
    } else {
      emit(state.articleError(dataState.exception!));
    }
  }
}
