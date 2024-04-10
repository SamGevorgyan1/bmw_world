import 'package:bmw_world/application/features/bmw_world/domain/entities/post_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';

@JsonSerializable()
class PostModel extends PostEntity{
  final int? id;
  final int? carId;
  final String? title;
  final String? content;
  final int? likes;
  final String? imageUrl;
  final String? createdAt;

  PostModel({
    this.id,
    this.carId,
    this.title,
    this.content,
    this.likes,
    this.imageUrl,
    this.createdAt,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) => _$PostModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostModelToJson(this);
}
