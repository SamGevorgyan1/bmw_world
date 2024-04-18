part of 'post_bloc.dart';

abstract class PostState {
  final List<PostEntity>? posts;
  final Object? exception;

  const PostState({this.posts, this.exception});
}

class PostsLoading extends PostState {
  const PostsLoading();
}

class PostsDone extends PostState {
  const PostsDone(List<PostEntity> posts) : super(posts: posts);
}

class PostsError extends PostState {
  const PostsError(Object exception) : super(exception: exception);
}
