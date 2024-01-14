// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Article _$ArticleFromJson(Map<String, dynamic> json) => Article(
      json['articleId'] as int,
      json['title'] as String,
      json['mainImageUri'] as String,
      json['mainContent'] as String,
      (json['articleContents'] as List<dynamic>)
          .map((e) => ArticleContent.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['createdAt'] as String,
    );

Map<String, dynamic> _$ArticleToJson(Article instance) => <String, dynamic>{
      'articleId': instance.articleId,
      'title': instance.title,
      'mainImageUri': instance.mainImageUri,
      'mainContent': instance.mainContent,
      'articleContents': instance.articleContents,
      'createdAt': instance.createdAt,
    };
