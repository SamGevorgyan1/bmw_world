import 'package:bmw_world/domain/repository/post_repository.dart';
import 'package:bmw_world/model/post.dart';
import 'package:bmw_world/ui/navigation/main_navigation.dart';
import 'package:flutter/material.dart';

class PostViewModel extends ChangeNotifier {
  final _postRepository = PostRepository();

  List<Post> _posts = [];
  bool _isLoading = false;
  bool _hasError = false;
  bool isDataLoaded = false;

  List<Post> get posts => _posts;
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;

  Future<void> fetchPosts(BuildContext context) async {
    try {
      _isLoading = true;
      _hasError = false;

      _posts = await _postRepository.getAllPost(null);
      notifyListeners();
      _isLoading = false;
      isDataLoaded = true;
      notifyListeners();
    } catch (error) {
      _isLoading = false;
      _hasError = true;
      notifyListeners();
    }
  }

  void onTapItem(BuildContext context, int carId) {
    Navigator.of(context)
        .pushNamed(MainNavigationRouteNames.carInfoWidget, arguments: carId);
  }

  void updatePosts(List<Post> newPosts) {
    _posts = newPosts;
    notifyListeners();
  }
}
