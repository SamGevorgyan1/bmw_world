import 'package:bmw_world/model/article_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bmw_world/model/article.dart';
import 'package:bmw_world/ui/widgets/main/article/article_details/article_details_view_model.dart';

class ArticleDetailsWidget extends StatefulWidget {
  final int articleId;

  const ArticleDetailsWidget({Key? key, required this.articleId})
      : super(key: key);

  @override
  State<ArticleDetailsWidget> createState() => _ArticleDetailsWidgetState();
}

class _ArticleDetailsWidgetState extends State<ArticleDetailsWidget> {
  @override
  void initState() {
    super.initState();
    Provider.of<ArticleDetailsViewModel>(context, listen: false)
        .fetchArticleDetails(widget.articleId);
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ArticleDetailsViewModel>(context);
    final article = viewModel.article;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: screenHeight,
            floating: false,
            pinned: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon:
                  const Icon(Icons.chevron_left, color: Colors.black, size: 40),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: _ArticleImageTitleWidget(
                imageUri: article?.mainImageUri ?? "",
                title: article?.title ?? "",
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const SizedBox(height: 30),
                    _ArticleContentWidget(article: article),
                  ],
                );
              },
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class _ArticleContentWidget extends StatelessWidget {
  final Article? article;

  const _ArticleContentWidget({Key? key, required this.article})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final articleContents = article?.articleContents;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          _MainArticleWidget(
              createdAt: article?.createdAt ?? "",
              content: article?.mainContent ?? ""),
          const SizedBox(height: 30),
          for (var item in articleContents ?? <ArticleContent>[])
            _ArticleItemWidget(articleContent: item),
        ],
      ),
    );
  }
}

class _ArticleItemWidget extends StatelessWidget {
  final ArticleContent articleContent;

  const _ArticleItemWidget({Key? key, required this.articleContent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          child: Image.network(articleContent.imageUri),
        ),
        Text(
          articleContent.title,
          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 20),
        Text(
          articleContent.content,
          style: const TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}

class _MainArticleWidget extends StatelessWidget {
  final String createdAt;
  final String content;

  const _MainArticleWidget(
      {Key? key, required this.createdAt, required this.content})
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
          style: const TextStyle(color: Colors.grey, fontSize: 18),
        )
      ],
    );
  }
}

class _ArticleImageTitleWidget extends StatefulWidget {
  final String imageUri;
  final String title;

  const _ArticleImageTitleWidget(
      {Key? key, required this.imageUri, required this.title})
      : super(key: key);

  @override
  State<_ArticleImageTitleWidget> createState() =>
      _ArticleImageTitleWidgetState();
}

class _ArticleImageTitleWidgetState extends State<_ArticleImageTitleWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _controller, curve: Curves.bounceInOut));
    _controller.repeat(reverse: true, period: const Duration(seconds: 3));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(widget.imageUri),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 300,
            left: 20,
            child: SizedBox(
              width: 300,
              child: Text(
                widget.title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                    fontWeight: FontWeight.w500),
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
                      child: const Icon(Icons.arrow_upward,
                          size: 30, color: Colors.white),
                    );
                  },
                ),
                const SizedBox(width: 5),
                const Text(
                  "10 min reading time",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
