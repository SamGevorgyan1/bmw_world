import 'package:bmw_world/application/features/bmw_world/data/model/post.dart';
import 'package:bmw_world/application/features/bmw_world/presentation/screen/main/car/car_details_screen.dart';
import 'package:bmw_world/application/features/bmw_world/presentation/widget/post_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../injection_container.dart';
import 'bloc/post_bloc.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: BlocProvider(
        create: (context) => sl<PostBloc>()..add(const GetPosts()),
        child: BlocBuilder<PostBloc, PostState>(
          builder: (context, state) {
            if (state is PostsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PostsDone) {
              return const PostView();
            } else if (state is PostsError) {
              return Center(
                child: Text('Error: ${state.exception ?? "Unknown error"}'),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}

class PostView extends StatelessWidget {
  const PostView({Key? key}) : super(key: key);

  void onTapItem(BuildContext context, int carId) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CarDetailsScreen(carId: carId)));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: state.posts?.length,
                itemBuilder: (context, index) {
                  final carId = state.posts?[index].carId;
                  return PostWidget(
                    onTap: () => onTapItem(context, carId ?? 1),
                    post: state.posts?[index] ?? PostModel(),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
