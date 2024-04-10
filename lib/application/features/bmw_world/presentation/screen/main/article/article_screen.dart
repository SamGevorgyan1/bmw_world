import 'package:bmw_world/application/features/bmw_world/data/model/article.dart';
import 'package:bmw_world/application/features/bmw_world/presentation/screen/main/article/bloc/article_list_bloc.dart';
import 'package:bmw_world/application/features/bmw_world/presentation/widget/article_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../injection_container.dart';
import 'details/article_details_screen.dart';

class ArticleScreen extends StatelessWidget {
  const ArticleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => sl<ArticleListBloc>()..add(ArticleListEvent.loadArticleList()),
        child: BlocBuilder<ArticleListBloc, ArticleListState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const CircularProgressIndicator();
            }
            if (state.articles!=null) {
             return const ArticleScreenView();
            }
            if (state.error!=null) {
              return Container(color: Colors.red);
            }
            return Container(color: Colors.green);
          },
        ),
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
        final articles = state.articles;
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.6,
          ),
          itemCount: articles?.length ?? 1,
          itemBuilder: (context, index) {
            final id = articles?[index].id ?? 1;
            return ArticleWidget(
              onTap: () => onTapArticle(context, id),
              articleModel: articles?[index] ??
                  ArticleModel(
                    1,
                    "title",
                    "mainImage",
                    "mainContent",
                  ),
            );
          },
        );
      },
    );
  }
}
