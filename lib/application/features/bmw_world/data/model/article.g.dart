// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleModel _$ArticleModelFromJson(Map<String, dynamic> json) => ArticleModel(
      json['id'] as int?,
      json['title'] as String?,
      json['mainImageUrl'] as String?,
      json['mainContent'] as String?,
    )..articleContents = (json['articleContents'] as List<dynamic>?)
        ?.map((e) => ArticleContentModel.fromJson(e as Map<String, dynamic>))
        .toList();

Map<String, dynamic> _$ArticleModelToJson(ArticleModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'mainImageUrl': instance.mainImage,
      'mainContent': instance.mainContent,
      'articleContents': instance.articleContents,
    };
