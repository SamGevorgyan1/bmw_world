import 'package:bmw_world/model/_car.dart';
import 'package:bmw_world/model/comment.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';

@JsonSerializable()
class Post {
  final int postId;

  final String content;

  final int likes;

  final Car? car;

  final List<Comment> comments;

  final String imageUrl;

  final String createdAt;

  Post({
    required this.postId,
    required this.content,
    required this.likes,
    required this.comments,
    required this.imageUrl,
    required this.createdAt,
    this.car,
  });

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
  Map<String, dynamic> toJson() => _$PostToJson(this);
}
