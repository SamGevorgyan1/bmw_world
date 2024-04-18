part of 'post_bloc.dart';

abstract class PostEvent {
  const PostEvent();
}

class GetPosts extends PostEvent {
  const GetPosts();
}
