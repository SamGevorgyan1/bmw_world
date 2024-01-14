// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleContent _$ArticleContentFromJson(Map<String, dynamic> json) =>
    ArticleContent(
      json['articleContentId'] as int,
      json['imageUri'] as String,
      json['title'] as String,
      json['content'] as String,
      json['createdAt'] as String,
    );

Map<String, dynamic> _$ArticleContentToJson(ArticleContent instance) =>
    <String, dynamic>{
      'articleContentId': instance.articleContentId,
      'imageUri': instance.imageUri,
      'title': instance.title,
      'content': instance.content,
      'createdAt': instance.createdAt,
    };
