import 'package:json_annotation/json_annotation.dart';

part 'article_content.g.dart';

@JsonSerializable()
class ArticleContentModel {
  final int id;
  @JsonKey(name: "imageUrl")
  final String image;
  final String title;
  final String content;

  ArticleContentModel(this.id, this.image, this.title, this.content);

  factory ArticleContentModel.fromJson(Map<String, dynamic> json) =>
      _$ArticleContentModelFromJson(json);
}
