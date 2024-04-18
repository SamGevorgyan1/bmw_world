import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bmw_world/application/features/bmw_world/domain/usecases/get_articles.dart';

import '../../../../domain/entities/article_entity.dart';

part 'article_list_event.dart';

part 'article_list_state.dart';

class ArticleListBloc extends Bloc<ArticleListEvent, ArticleListState> {
  final GetArticlesUseCase _articlesUseCase;

  ArticleListBloc(this._articlesUseCase) : super(ArticleListState.initial()) {
    on<_LoadArticleListEvent>(_onGetArticles);
  }

  FutureOr<void> _onGetArticles(_LoadArticleListEvent event, Emitter<ArticleListState> emit) async {
    try {
      final dataState = await _articlesUseCase();

      dataState.when(
        success: (data) => emit(state.articlesLoaded(data)),
        failure: (exception) => emit(state.articleError(exception)),
      );
    } catch (error) {
      emit(state.articleError(error));
    }
  }
}
