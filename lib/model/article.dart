import 'package:bmw_world/model/article_content.dart';
import 'package:json_annotation/json_annotation.dart';

part 'article.g.dart';

@JsonSerializable()
class Article {
  final int articleId;
  final String title;
  final String mainImageUri;
  final String mainContent;
  final List<ArticleContent> articleContents;
  final String createdAt;

  Article(this.articleId, this.title, this.mainImageUri, this.mainContent,
      this.articleContents, this.createdAt);

  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);
  Map<String, dynamic> toJson() => _$ArticleToJson(this);
}
