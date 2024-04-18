import 'package:bmw_world/application/features/bmw_world/domain/entities/article_entity.dart';
import 'package:bmw_world/application/features/bmw_world/presentation/screen/article/bloc/article_list_bloc.dart';
import 'package:bmw_world/application/features/bmw_world/presentation/widget/article_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../di/injection_container.dart';
import 'details/article_details_screen.dart';

class ArticleScreen extends StatelessWidget {
  const ArticleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ArticleListBloc>()..add(ArticleListEvent.loadArticleList()),
      child: BlocBuilder<ArticleListBloc, ArticleListState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.articles != null) {
            return const ArticleScreenView();
          }
          if (state.error != null) {
            // TODO
            return const Center(child: Text('Articles not available'));
          }
          // TODO
          return const Center(child: Text('Articles not available'));
        },
      ),
    );
  }
}

class ArticleScreenView extends StatelessWidget {
  const ArticleScreenView({Key? key}) : super(key: key);

  void onTapArticle(BuildContext context, int articleId) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ArticleDetailsScreen(articleId: articleId),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArticleListBloc, ArticleListState>(
      builder: (context, state) {
        final articles = state.articles ?? [ArticleEntity()];
        return Scaffold(
          body: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.6,
            ),
            itemCount: articles.length,
            itemBuilder: (context, index) {
              final id = articles[index].id ?? 1;
              return ArticleWidget(
                  onTap: () => onTapArticle(context, id), article: articles[index]);
            },
          ),
        );
      },
    );
  }
}
