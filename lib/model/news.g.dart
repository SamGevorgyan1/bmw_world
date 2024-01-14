// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

News _$NewsFromJson(Map<String, dynamic> json) => News(
      json['newsId'] as int,
      json['title'] as String,
      json['content'] as String,
      json['likes'] as int,
      (json['comments'] as List<dynamic>)
          .map((e) => Comment.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['imageUrl'] as String,
      json['author'] as String,
      json['createdAt'] as String,
    );

Map<String, dynamic> _$NewsToJson(News instance) => <String, dynamic>{
      'newsId': instance.newsId,
      'title': instance.title,
      'content': instance.content,
      'likes': instance.likes,
      'comments': instance.comments,
      'imageUrl': instance.imageUrl,
      'author': instance.author,
      'createdAt': instance.createdAt,
    };
