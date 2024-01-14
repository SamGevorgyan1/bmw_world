import 'package:bmw_world/ui/widgets/main/article/article_cubit.dart';
import 'package:bmw_world/ui/widgets/main/article/article_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ArticleWidget extends StatefulWidget {
  const ArticleWidget({Key? key}) : super(key: key);

  @override
  State<ArticleWidget> createState() => _ArticleWidgetState();
}

class _ArticleWidgetState extends State<ArticleWidget> {
  Future<void> _handleRefresh(BuildContext context) async {
    context.read<ArticleCubit>().loadArticles();
    return Future.delayed(const Duration(seconds: 1));
  }

  @override
  void didChangeDependencies() {
    context.read<ArticleCubit>().loadArticles();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ArticleCubit>(
        builder: (context, viewModel, child) {
          if (viewModel.state.articles.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          } else if (viewModel.isClosed) {
            return const Center(
              child: Text('Error loading cars'),
            );
          } else if (viewModel.state.articles.isEmpty) {
            return const Center(
              child: Text('No cars available'),
            );
          } else {
            return RefreshIndicator(
              displacement: 40.0,
              onRefresh: () => _handleRefresh(context),
              child: _ArticleListWidget(articles: viewModel.state.articles),
            );
          }
        },
      ),
    );
  }
}

class _ArticleListWidget extends StatelessWidget {
  final List<ArticleRow> articles;

  const _ArticleListWidget({Key? key, required this.articles})
      : super(key: key);

  void onTapItem(BuildContext context, int articleId) =>
      ArticleViewModel().onTapItem(context, articleId);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.6,
      ),
      shrinkWrap: true,
      itemCount: articles.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => onTapItem(context, articles[index].id),
          child: _ArticleWidget(
            imageUri: articles[index].imageUrl,
            titleText: articles[index].title,
          ),
        );
      },
    );
  }
}

class _ArticleWidget extends StatelessWidget {
  const _ArticleWidget({
    Key? key,
    required this.imageUri,
    required this.titleText,
  }) : super(key: key);

  final String imageUri;
  final String titleText;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 3, top: 3, bottom: 3),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(imageUri),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 20,
            left: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 3),
                SizedBox(
                  width: 150,
                  child: Text(
                    titleText,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
