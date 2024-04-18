import 'package:bmw_world/application/core/resources/data_state/data_state.dart';
import 'package:bmw_world/application/features/bmw_world/data/data_source/local/service/article_local_service.dart';
import 'package:bmw_world/application/features/bmw_world/data/data_source/remote/bmw_world_api_service.dart';
import 'package:bmw_world/application/features/bmw_world/data/model/article.dart';
import 'package:bmw_world/application/features/bmw_world/data/model/car.dart';
import 'package:bmw_world/application/features/bmw_world/domain/entities/article_entity.dart';
import 'package:bmw_world/application/features/bmw_world/domain/entities/post_entity.dart';
import '../../../../core/helper/helper.dart';
import '../../domain/repository/bmw_world_repository.dart';
import '../data_source/local/service/post_local_service.dart';

class BmwWorldRepositoryImpl implements BmwWorldRepository {
  final BmwWorldApiService _apiService;
  final PostLocalService _postLocalService;
  final ArticleLocalService _articleLocalService;

  const BmwWorldRepositoryImpl(this._apiService, this._postLocalService, this._articleLocalService);

  @override
  Future<DataState<List<PostEntity>>> getPosts() async {
    try {
      final httpResponse = await _apiService.getPosts();
      await _postLocalService.deleteAll();
      await _postLocalService.createList(httpResponse.data);
      return handleResponse(httpResponse.response, httpResponse.data);
    } catch (e) {
      return await _postLocalService.getAll();
    }
  }

  @override
  Future<DataState<CarModel>> getCarById(int id) async {
    try {
      final httpResponse = await _apiService.getCarById(id);
      return handleResponse(httpResponse.response, httpResponse.data);
    } catch (e) {
      return DataState.error(e);
    }
  }

  @override
  Future<DataState<ArticleModel>> getArticleById(int id) async {
    try {
      final httpResponse = await _apiService.getArticleById(id);

      return handleResponse(httpResponse.response, httpResponse.data);
    } catch (e) {
      return DataState.error(e);
    }
  }

  @override
  Future<DataState<List<ArticleEntity>>> getArticles() async {
    try {
      final httpResponse = await _apiService.getArticles();
      await _articleLocalService.deleteAll();
      await _articleLocalService.createList(httpResponse.data);
      return handleResponse(httpResponse.response, httpResponse.data);
    } catch (e) {
      return  _articleLocalService.getAll();
    }
  }
}
