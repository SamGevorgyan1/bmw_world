import 'package:bmw_world/application/features/bmw_world/data/model/post.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../../core/constants/constants.dart';

part 'post_api_service.g.dart';

@RestApi(baseUrl: postApiBaseURl)
abstract class PostApiService {
  factory PostApiService(Dio dio) = _PostApiService;

  @GET('')
  Future<HttpResponse<List<PostModel>>> getAll();
}
