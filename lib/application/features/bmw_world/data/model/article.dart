import 'package:json_annotation/json_annotation.dart';

import 'article_content.dart';

part 'article.g.dart';

@JsonSerializable()
class ArticleModel {
  final int? id;
  final String? title;
  @JsonKey(name: "mainImageUrl")
  final String? mainImage;
  final String? mainContent;
  List<ArticleContentModel>? articleContents;

  ArticleModel(
    this.id,
    this.title,
    this.mainImage,
    this.mainContent,
  );

  factory ArticleModel.fromJson(Map<String, dynamic> json) => _$ArticleModelFromJson(json);
}
