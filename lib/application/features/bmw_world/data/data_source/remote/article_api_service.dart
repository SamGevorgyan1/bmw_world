
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:bmw_world/application/features/bmw_world/data/model/article.dart';

import '../../../../../core/constants/constants.dart';

part 'article_api_service.g.dart';

@RestApi(baseUrl: articleApiBaseURl)
abstract class ArticleApiService {
  factory ArticleApiService(Dio dio) = _ArticleApiService;

  @GET('')
  Future<HttpResponse<List<ArticleModel>>> getAll();

  @GET('/{id}')
  Future<HttpResponse<ArticleModel>> get(@Path('id') int id);
}
