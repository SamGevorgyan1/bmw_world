import 'dart:io';
import 'package:bmw_world/application/core/resources/data_state/data_state.dart';
import 'package:bmw_world/application/features/bmw_world/data/data_source/local/service/post_local_service.dart';
import 'package:bmw_world/application/features/bmw_world/data/data_source/remote/post_api_service.dart';
import 'package:bmw_world/application/features/bmw_world/domain/entities/post_entity.dart';
import 'package:bmw_world/application/features/bmw_world/domain/repository/post_repository.dart';
import 'package:dio/dio.dart';

class PostRepositoryImpl implements PostRepository {
  final PostApiService _postApiService;
  final PostLocalService _postLocalService;

  const PostRepositoryImpl(this._postApiService, this._postLocalService);

  @override
  Future<DataState<List<PostEntity>>> getPosts() async {
    try {
      final httpResponse = await _postApiService.getAll();
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        await _postLocalService.deleteAll();
        await _postLocalService.createList(httpResponse.data);
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
          DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            requestOptions: httpResponse.response.requestOptions,
          ),
        );
      }
    } on DioException catch (e) {
      final localDataState = await _postLocalService.getAll();
      if (localDataState is DataSuccess<List<PostEntity>>) {
        return DataSuccess(localDataState.data);
      } else if (localDataState is DataFailed<List<PostEntity>>) {
        return DataFailed(e);
      } else {
        return DataFailed(Exception('Unknown error occurred.'));
      }
    }
  }
}
