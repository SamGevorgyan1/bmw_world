// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post(
      postId: json['postId'] as int,
      content: json['content'] as String,
      likes: json['likes'] as int,
      comments: (json['comments'] as List<dynamic>)
          .map((e) => Comment.fromJson(e as Map<String, dynamic>))
          .toList(),
      imageUrl: json['imageUrl'] as String,
      createdAt: json['createdAt'] as String,
      car: json['car'] == null
          ? null
          : Car.fromJson(json['car'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'postId': instance.postId,
      'content': instance.content,
      'likes': instance.likes,
      'car': instance.car,
      'comments': instance.comments,
      'imageUrl': instance.imageUrl,
      'createdAt': instance.createdAt,
    };
