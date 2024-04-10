import 'package:bmw_world/application/core/resources/converter/data_converter.dart';

class PostEntity implements DataConverter<PostEntity>  {
  final int? id;
  final String? title;
  final String? content;
  final int? likes;
  final int? carId;
  final String? imageUrl;
  final String? createdAt;

  PostEntity({
    this.id,
    this.title,
    this.content,
    this.likes,
    this.carId,
    //this.comments,
    this.imageUrl,
    this.createdAt,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
      'likes': likes,
      'carId': carId,
      'imageUrl': imageUrl,
      'createdAt': createdAt,
    };
  }

  factory PostEntity.fromMap(Map<String, dynamic> map) {
    return PostEntity(
      id: map['id'],
      content: map['content'],
      likes: map['likes'],
      carId: map['carId'],
      imageUrl: map['imageUrl'],
      createdAt: map['createdAt'],
    );
  }

  @override
  PostEntity fromMap(Map<String, dynamic> map) {
    return PostEntity(
      id: map['id'],
      content: map['content'],
      likes: map['likes'],
      carId: map['carId'],
      imageUrl: map['imageUrl'],
      createdAt: map['createdAt'],
    );
  }
}
