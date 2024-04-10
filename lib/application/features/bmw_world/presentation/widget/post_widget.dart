import 'package:bmw_world/application/features/bmw_world/data/model/post.dart';
import 'package:bmw_world/application/features/bmw_world/domain/entities/post_entity.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PostWidget extends StatelessWidget {
  final PostEntity post;
  final VoidCallback? onTap;

  const PostWidget({super.key, required this.post, this.onTap});

  @override
  Widget build(BuildContext context) {
    final content = post.content ??"";
    final title = post.title ??"";
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
               PostContent(content:content),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "${post.likes}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.favorite)),
                  const Text(
                    "100",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
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
      style: const TextStyle(
        fontSize: 19,
        fontWeight: FontWeight.bold,
      ),
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
      style: const TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.normal,
      ),
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
              "_errorText",
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

const String postContentText =
    "Now in its sixth generation, the new BMW M5 Competition has taken an iconic design language and accentuated it with eye-catching elements";

const String titleText = "Bmw M5 Competition";
