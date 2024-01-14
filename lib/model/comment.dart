import 'package:json_annotation/json_annotation.dart';

part 'comment.g.dart';

@JsonSerializable()
class Comment {
  final int commentId;
  final int likes;
  final String content;
  final String createdAt;

  Comment(
    this.commentId,
    this.likes,
    this.content,
    this.createdAt,
  );
  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);
  Map<String, dynamic> toJson() => _$CommentToJson(this);
}
