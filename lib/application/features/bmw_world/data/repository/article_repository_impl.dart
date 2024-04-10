import 'dart:io';

import 'package:bmw_world/application/core/resources/data_state/data_state.dart';
import 'package:bmw_world/application/features/bmw_world/data/data_source/remote/article_api_service.dart';
import 'package:bmw_world/application/features/bmw_world/data/model/article.dart';
import 'package:dio/dio.dart';

import '../../domain/repository/article_repository.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final ArticleApiService _articleApiService;

  ArticleRepositoryImpl(this._articleApiService);

  @override
  Future<DataState<ArticleModel>> get(int id) async {
    try {
      final httpResponse = await _articleApiService.get(id);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
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
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<List<ArticleModel>>> getAll() async {
    try {
      final httpResponse = await _articleApiService.getAll();

      if (httpResponse.response.statusCode == HttpStatus.ok) {
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
      return DataFailed(e);
    }
  }

  Future<DataState<T>> _handleResponse<T>(Response response) {
    if (response.statusCode == HttpStatus.ok) {
      return Future.value(DataSuccess(response.data));
    } else {
      return Future.value(
        DataFailed(
          DioException(
            error: response.statusMessage,
            response: response,
            requestOptions: response.requestOptions,
          ),
        ),
      );
    }
  }
}
