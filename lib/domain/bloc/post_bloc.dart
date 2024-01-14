import 'package:bmw_world/domain/repository/post_repository.dart';
import 'package:bmw_world/model/post.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class PostEvent {}

class PostEventFetchList extends PostEvent {}

class PostEventReloadList extends PostEvent {}

abstract class PostState {}

class PostStateLoading extends PostState {}

class PostErrorState extends PostState {
  final String errorMessage;

  PostErrorState({required this.errorMessage});
}

class PostStateLoaded extends PostState {
  final List<Post> posts;

  PostStateLoaded({required this.posts});
}

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository _postRepository = PostRepository();

  PostBloc(PostState initialState) : super(initialState);

  Stream<PostState> mapEventToState(PostEvent event) async* {
    if (event is PostEventFetchList) {
      yield* _mapFetchListToState(event);
    }
  }

  Stream<PostState> _mapFetchListToState(PostEventFetchList event) async* {
    yield PostStateLoading();

    try {
      final posts = await _postRepository.getAllPost(null);
      yield PostStateLoaded(posts: posts);
    } catch (e) {
      yield PostErrorState(errorMessage: e.toString());
    }
  }
}
