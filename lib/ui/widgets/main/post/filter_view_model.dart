import 'package:bmw_world/domain/repository/post_repository.dart';
import 'package:bmw_world/model/_car.dart';
import 'package:bmw_world/model/post.dart';
import 'package:bmw_world/ui/widgets/main/post/post_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilterViewModel extends ChangeNotifier {
  final _postRepsoitory = PostRepository();

  Color? _color;
  String? _fromYear;
  String? _toYear;
  String? _model;
  String? _colorName;
  Map<String, String>? _parameters;
  int? _resultCount;

  Color? get color => _color;
  String? get fromYear => _fromYear;
  String? get toYear => _toYear;
  String? get model => _model;
  String? get colorName => _colorName;
  Map<String, String>? get parameters => _parameters;
  int? get resultCount => _resultCount;

  void setColor(Color color) {
    _color = color;
    notifyListeners();
  }

  void setColorName(String colorName, BuildContext context) {
    _colorName = colorName;
    updateParameters(context);
  }

  void setFromYear(String fromYear, BuildContext context) {
    _fromYear = fromYear;
    updateParameters(context);
  }

  void setToYear(String toYear, BuildContext context) {
    _toYear = toYear;
    updateParameters(context);
  }

  void setModel(String model, BuildContext context) {
    _model = model;
    updateParameters(context);
  }

  void clearAllFilter(BuildContext context) {
    _color = null;
    _fromYear = null;
    _toYear = null;
    _model = null;
    _colorName = null;
    _resultCount = null;
    _getAllPost(context);
    notifyListeners();
  }

  Future<void> updateParameters(BuildContext context) async {
    try {
      _parameters = {
        if (_model != null) "model": "$_model",
        if (_colorName != null) "color": "$_colorName",
      };

      final response = await _postRepsoitory.getAllPost(_parameters);
      _updatePost(context, response);

      _resultCount = response.length;

      notifyListeners();

      for (var post in response) {
        _printCarDetails(post.car);
      }
    } catch (error) {
      print("Error: $error");
    }
  }

  Future<void> _getAllPost(BuildContext context) async {
    final posts = await _postRepsoitory.getAllPost(null);
    _updatePost(context, posts);
  }

  void _updatePost(BuildContext context, List<Post> posts) {
    Provider.of<PostViewModel>(context, listen: false).updatePosts(posts);
  }

  void _printCarDetails(Car? car) {
    print(car?.name);
    print(car?.model);
    print(car?.color);
    print(car?.engineSize);
    print(car?.horsePower);
  }
}
