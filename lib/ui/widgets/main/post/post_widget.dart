import 'package:bmw_world/model/_car.dart';
import 'package:bmw_world/model/post.dart';
import 'package:bmw_world/ui/theme/app_color.dart';
import 'package:bmw_world/ui/widgets/main/post/filter_widget.dart';
import 'package:bmw_world/ui/widgets/main/post/post_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostWidget extends StatefulWidget {
  const PostWidget({Key? key}) : super(key: key);

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  bool isFilterVisible = false;

  @override
  void initState() {
    super.initState();

    if (!Provider.of<PostViewModel>(context, listen: false).isDataLoaded) {
      Provider.of<PostViewModel>(context, listen: false).fetchPosts(context);
    }
  }

  Future<void> _handleRefresh(BuildContext context) async {
    await Provider.of<PostViewModel>(context, listen: false)
        .fetchPosts(context);
  }

  void _showFilterDialog() {
    setState(() {
      isFilterVisible = !isFilterVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        backgroundColor: AppColor.blueDark,
        title: const Text('BMW World'),
      ),
      body: Consumer<PostViewModel>(
        builder: (context, viewModel, child) {
          return RefreshIndicator(
            displacement: 40.0,
            onRefresh: () => _handleRefresh(context),
            child: Column(
              children: [
                _FilterButtonWidget(
                  onTapFilter: _showFilterDialog,
                ),
                if (isFilterVisible)
                  const SizedBox(
                    width: double.infinity,
                    height: 550,
                    child: FilterWidget(),
                  ),
                _CarListWidget(
                  posts: viewModel.posts,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CarListWidget extends StatelessWidget {
  final List<Post> posts;
  const _CarListWidget({Key? key, required this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          return GestureDetector(
            onTap: () => Provider.of<PostViewModel>(context, listen: false)
                .onTapItem(context, post.car?.carId ?? 0),
            child: _PostWidget(post: post),
          );
        },
      ),
    );
  }
}

class _FilterButtonWidget extends StatefulWidget {
  final VoidCallback onTapFilter;
  const _FilterButtonWidget({Key? key, required this.onTapFilter})
      : super(key: key);

  @override
  State<_FilterButtonWidget> createState() => _FilterButtonWidgetState();
}

class _FilterButtonWidgetState extends State<_FilterButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Text(
          "Filter",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        IconButton(
          onPressed: widget.onTapFilter,
          icon: const Icon(Icons.filter_3_sharp),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_upward),
        ),
      ],
    );
  }
}

class _PostWidget extends StatelessWidget {
  final Post post;
  const _PostWidget({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imageUri = post.car?.imageUri[0] ?? "";
    final car = post.car;
    return GestureDetector(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _CarTitleWidget(car: car),
              const SizedBox(height: 10),
              _CarImageWidget(imageUri: imageUri),
              const SizedBox(height: 15),
              const _PostContentWidget(),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}

class _PostContentWidget extends StatelessWidget {
  const _PostContentWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Now in its sixth generation, the new BMW M5 Competition has taken an iconic design language and accentuated it with eye-catching elements",
      overflow: TextOverflow.ellipsis,
      maxLines: 3,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: Color(0xFF333333),
      ),
    );
  }
}

class _CarImageWidget extends StatelessWidget {
  const _CarImageWidget({Key? key, required this.imageUri}) : super(key: key);

  final String imageUri;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.network(
        imageUri,
        fit: BoxFit.cover,
      ),
    );
  }
}

class _CarTitleWidget extends StatelessWidget {
  const _CarTitleWidget({Key? key, required this.car}) : super(key: key);

  final Car? car;

  @override
  Widget build(BuildContext context) {
    return Text(
      "${car?.model} ${car?.year} ",
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w800,
        color: Color(0xFF333333),
      ),
    );
  }
}
