// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostModel _$PostModelFromJson(Map<String, dynamic> json) => PostModel(
      id: json['id'] as int?,
      carId: json['carId'] as int?,
      title: json['title'] as String?,
      content: json['content'] as String?,
      likes: json['likes'] as int?,
      imageUrl: json['imageUrl'] as String?,
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$PostModelToJson(PostModel instance) => <String, dynamic>{
      'id': instance.id,
      'carId': instance.carId,
      'title': instance.title,
      'content': instance.content,
      'likes': instance.likes,
      'imageUrl': instance.imageUrl,
      'createdAt': instance.createdAt,
    };
