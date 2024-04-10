// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleContentModel _$ArticleContentModelFromJson(Map<String, dynamic> json) =>
    ArticleContentModel(
      json['id'] as int,
      json['imageUrl'] as String,
      json['title'] as String,
      json['content'] as String,
    );

Map<String, dynamic> _$ArticleContentModelToJson(
        ArticleContentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'imageUrl': instance.image,
      'title': instance.title,
      'content': instance.content,
    };
