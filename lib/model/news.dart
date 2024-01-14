import 'package:bmw_world/model/comment.dart';
import 'package:json_annotation/json_annotation.dart';

part 'news.g.dart';

@JsonSerializable()
class News {
  final int newsId;

  final String title;

  final String content;

  final int likes;

  final List<Comment> comments;

  final String imageUrl;

  final String author;

  final String createdAt;

  News(
    this.newsId,
    this.title,
    this.content,
    this.likes,
    this.comments,
    this.imageUrl,
    this.author,
    this.createdAt,
  );
}
