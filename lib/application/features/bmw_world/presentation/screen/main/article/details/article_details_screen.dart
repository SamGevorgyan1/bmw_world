import 'package:bmw_world/application/features/bmw_world/data/model/article_content.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bmw_world/application/features/bmw_world/presentation/screen/main/article/details/bloc/article_details_bloc.dart';

import '../../../../../../../injection_container.dart';

class ArticleDetailsScreen extends StatelessWidget {
  const ArticleDetailsScreen({Key? key, required this.articleId}) : super(key: key);
  final int articleId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<ArticleDetailsBloc>(
        create: (_) => sl<ArticleDetailsBloc>()..add(ArticleDetailsEvent.loadArticle(id: articleId)),
        child: BlocBuilder<ArticleDetailsBloc, ArticleDetailsState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.error!=null) {
              return Container(color: Colors.red);
            } else if (state.article!=null) {
              return const ArticleDetailsView();
            }
            return Container(color: Colors.green);
          },
        ),
      ),
    );
  }
}

class ArticleDetailsView extends StatelessWidget {
  const ArticleDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArticleDetailsBloc, ArticleDetailsState>(
  builder: (context, state) {
    final  article = state.article!;
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: MediaQuery.of(context).size.height,
          floating: false,
          pinned: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: const FlexibleSpaceBar(
            background: _ArticleImage(imagePath: imagePath2),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {

              final content = article.articleContents!;
              return Column(
                children: [
                  _MainArticleWidget(
                    content: article.mainContent!,
                    createdAt: "",
                  ),
                  ArticleContent(
                    article: content[index],
                  ),
                  const SizedBox(height: 10),
                ],
              );
            },
            childCount: article.articleContents?.length,
          ),
        ),
      ],
    );
  },
);
  }
}

class _MainArticleWidget extends StatelessWidget {
  final String createdAt;
  final String content;

  const _MainArticleWidget({Key? key, required this.createdAt, required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          content,
          style: const TextStyle(fontSize: 25),
        ),
        const SizedBox(height: 20),
        Text(
          createdAt,
          style: const TextStyle( fontSize: 18),
        )
      ],
    );
  }
}

class ArticleContent extends StatelessWidget {
  final ArticleContentModel article;

  const ArticleContent({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Image.network(article.image),
        ),
        Text(
          article.title,
          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 20),
        Text(
          article.content,
          style: const TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}

class _ArticleImage extends StatefulWidget {
  const _ArticleImage({Key? key, required this.imagePath}) : super(key: key);

  final String imagePath;

  @override
  State<_ArticleImage> createState() => _ArticleImageState();
}

class _ArticleImageState extends State<_ArticleImage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animation = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.bounceInOut));
    _controller.repeat(reverse: true, period: const Duration(seconds: 3));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: CachedNetworkImageProvider(widget.imagePath),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          bottom: 100,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, -20 * _animation.value),
                    child: const Icon(Icons.arrow_upward, size: 30, color: Colors.white),
                  );
                },
              ),
              const SizedBox(width: 5),
              const Text(
                "10 min reading time",
                style: TextStyle(

                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

const String imagePath2 =
    "https://www.bmw.com/content/dam/bmw/marketBMWCOM/bmw_com/categories/Design/RLH/rlh-01-stage-portrait.jpg?imwidth=768";
