import 'package:bmw_world/application/features/bmw_world/domain/entities/article_entity.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ArticleWidget extends StatelessWidget {
  const ArticleWidget({super.key, required this.article, required this.onTap});

  final VoidCallback onTap;
  final ArticleEntity article;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CachedNetworkImage(
        imageUrl: article.mainImage ?? "",
        imageBuilder: (context, imageProvider) {
          return Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(article.title ?? "", style: Theme.of(context).textTheme.headlineSmall),
            ),
          );
        },
      ),
    );
  }
}
