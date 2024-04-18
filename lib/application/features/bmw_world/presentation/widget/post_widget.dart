import 'package:bmw_world/application/features/bmw_world/domain/entities/post_entity.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PostWidget extends StatelessWidget {
  final PostEntity post;
  final VoidCallback? onTap;

  const PostWidget({super.key, required this.post, this.onTap});

  @override
  Widget build(BuildContext context) {
    final content = post.content ?? "";
    final title = post.title ?? "";
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PostTitle(title: title),
              const SizedBox(height: 10),
              PostImage(imageUrl: post.imageUrl ?? ""),
              const SizedBox(height: 10),
              PostContent(content: content),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "${post.likes}",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.favorite)),
                   Text(
                    "100",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.comment)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PostTitle extends StatelessWidget {
  const PostTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style:  Theme.of(context).textTheme.headlineLarge,
    );
  }
}

class PostContent extends StatelessWidget {
  const PostContent({super.key, required this.content});

  final String content;

  @override
  Widget build(BuildContext context) {
    return Text(
      content,
      style:  Theme.of(context).textTheme.bodyLarge,
    );
  }
}

class PostImage extends StatelessWidget {
  const PostImage({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        errorWidget: (context, url, error) {
          return const Center(
            child: Text(
              "Not available",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        },
      ),
    );
  }
}
