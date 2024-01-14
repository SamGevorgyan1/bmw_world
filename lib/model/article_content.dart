import 'package:json_annotation/json_annotation.dart';

part 'article_content.g.dart';

@JsonSerializable()
class ArticleContent {
  final int articleContentId;
  final String imageUri;
  final String title;
  final String content;
  final String createdAt;

  ArticleContent(this.articleContentId, this.imageUri, this.title, this.content,
      this.createdAt);

  factory ArticleContent.fromJson(Map<String, dynamic> json) =>
      _$ArticleContentFromJson(json);
  Map<String, dynamic> toJson() => _$ArticleContentToJson(this);
}
