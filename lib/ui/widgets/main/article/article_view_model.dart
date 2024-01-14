import 'package:bmw_world/domain/repository/article_repository.dart';
import 'package:bmw_world/model/article.dart';
import 'package:bmw_world/ui/navigation/main_navigation.dart';
import 'package:flutter/material.dart';

class ArticleViewModel extends ChangeNotifier {
  final _articleRepository = ArticleRepository();

  List<Article> _articles = [];
  bool _isLoading = false;
  bool _hasError = false;
  bool isDataLoaded = false;

  bool get isLoading => _isLoading;
  bool get hasError => _hasError;
  List<Article> get articles => _articles;

  Future<void> fetchArticles() async {
    _isLoading = true;
    _hasError = false;

    _articles = await _articleRepository.getAllArticle();

    _isLoading = false;
    isDataLoaded = true;
    notifyListeners();

    _isLoading = false;
    _hasError = true;

    notifyListeners();
  }

  void onTapItem(BuildContext context, int articleId) {
    Navigator.of(context).pushNamed(
        MainNavigationRouteNames.articleDetailsWidget,
        arguments: articleId);
  }
}
