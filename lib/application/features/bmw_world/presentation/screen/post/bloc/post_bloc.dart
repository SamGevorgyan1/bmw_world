import 'package:bloc/bloc.dart';
import 'package:bmw_world/application/features/bmw_world/domain/entities/post_entity.dart';
import '../../../../domain/usecases/get_posts.dart';

part 'post_event.dart';

part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final GetPostsUseCase _getPostsUseCase;

  PostBloc(this._getPostsUseCase) : super(const PostsLoading()) {
    on<GetPosts>(onGetPosts);
  }

  void onGetPosts(GetPosts event, Emitter<PostState> emit) async {
    try {
      final dataState = await _getPostsUseCase();
      dataState.when(
        success: (data) => emit(PostsDone(data)),
        failure: (exception) => emit(PostsError(exception)),
      );
    } catch (error) {
      emit(PostsError(error));
    }
  }
}
