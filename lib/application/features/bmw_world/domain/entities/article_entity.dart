import 'package:bmw_world/application/core/resources/converter/data_converter.dart';

class ArticleEntity implements DataConverter {
  final int? id;
  final String? title;
  final String? mainImage;
  final String? mainContent;

  ArticleEntity({this.id, this.title, this.mainImage, this.mainContent});

  @override
  ArticleEntity fromMap(Map<String, dynamic> map) {
    return ArticleEntity(
      id: map['id'],
      title: map['title'],
      mainImage: map['mainImage'],
      mainContent: map['mainContent'],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'mainImage': mainImage,
      'mainContent': mainContent,
    };
  }
}
