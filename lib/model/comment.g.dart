// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) => Comment(
      json['commentId'] as int,
      json['likes'] as int,
      json['content'] as String,
      json['createdAt'] as String,
    );

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'commentId': instance.commentId,
      'likes': instance.likes,
      'content': instance.content,
      'createdAt': instance.createdAt,
    };
