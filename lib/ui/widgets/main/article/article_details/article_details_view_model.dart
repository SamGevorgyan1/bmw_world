import 'package:bmw_world/domain/repository/article_repository.dart';
import 'package:bmw_world/model/article.dart';
import 'package:flutter/material.dart';

class ArticleDetailsViewModel extends ChangeNotifier {
  final ArticleRepository _articleRepository = ArticleRepository();
  Article? _article;
  bool _isLoading = false;
  bool _hasError = false;
  bool isDataLoaded = false;

  Article? get article => _article;
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;

  Future<void> fetchArticleDetails(int articleId) async {
    _isLoading = true;
    _hasError = false;

    try {
      _article = await _articleRepository.getArticleById(articleId);
      isDataLoaded = true;
    } catch (e) {
      _hasError = true;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
