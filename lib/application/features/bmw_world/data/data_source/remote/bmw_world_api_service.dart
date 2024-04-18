import 'package:bmw_world/application/core/constants/constants.dart';
import 'package:bmw_world/application/features/bmw_world/data/model/article.dart';
import 'package:bmw_world/application/features/bmw_world/data/model/car.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../model/post.dart';

part 'bmw_world_api_service.g.dart';

@RestApi(baseUrl: '')
abstract class BmwWorldApiService {
  factory BmwWorldApiService(Dio dio) = _BmwWorldApiService;

  /// Article APIs
  @GET(articleApiBaseURl)
  Future<HttpResponse<List<ArticleModel>>> getArticles();

  @GET("$articleApiBaseURl/{id}")
  Future<HttpResponse<ArticleModel>> getArticleById(@Path('id') int id);

  /// Post Apis
  @GET(postApiBaseURl)
  Future<HttpResponse<List<PostModel>>> getPosts();

  @GET('$postApiBaseURl/{id}')
  Future<HttpResponse<PostModel>> getPostById(@Path('id') int id);

  /// Car APIs
  @GET('$carApiBaseURl/{id}')
  Future<HttpResponse<CarModel>> getCarById(@Path('id') int id);
}
