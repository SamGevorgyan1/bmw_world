import 'package:bmw_world/application/features/bmw_world/data/data_provider/token_provider.dart';
import 'package:bmw_world/application/features/bmw_world/data/data_source/dao/postdb2.dart';
import 'package:bmw_world/application/features/bmw_world/data/data_source/local/service/post_local_service.dart';
import 'package:bmw_world/application/features/bmw_world/data/data_source/local/service/impl/post_local_service_impl.dart';
import 'package:bmw_world/application/features/bmw_world/data/data_source/remote/auth_api_service.dart';
import 'package:bmw_world/application/features/bmw_world/data/data_source/remote/car_api_service.dart';
import 'package:bmw_world/application/features/bmw_world/data/data_source/remote/post_api_service.dart';
import 'package:bmw_world/application/features/bmw_world/data/repository/article_repository_impl.dart';
import 'package:bmw_world/application/features/bmw_world/data/repository/auth_repository_impl.dart';
import 'package:bmw_world/application/features/bmw_world/data/repository/car_repository_impl.dart';
import 'package:bmw_world/application/features/bmw_world/data/repository/post_repository_impl.dart';
import 'package:bmw_world/application/features/bmw_world/domain/repository/auth_repository.dart';
import 'package:bmw_world/application/features/bmw_world/domain/repository/car_repository.dart';
import 'package:bmw_world/application/features/bmw_world/domain/repository/post_repository.dart';
import 'package:bmw_world/application/features/bmw_world/domain/usecases/get_article.dart';
import 'package:bmw_world/application/features/bmw_world/domain/usecases/get_articles.dart';
import 'package:bmw_world/application/features/bmw_world/domain/usecases/get_car.dart';
import 'package:bmw_world/application/features/bmw_world/domain/usecases/get_posts.dart';
import 'package:bmw_world/application/features/bmw_world/presentation/screen/main/article/bloc/article_list_bloc.dart';
import 'package:bmw_world/application/features/bmw_world/presentation/screen/auth/bloc/auth_bloc.dart';
import 'package:bmw_world/application/features/bmw_world/presentation/screen/main/post/bloc/post_bloc.dart';
import 'package:bmw_world/application/features/bmw_world/presentation/screen/main/article/details/bloc/article_details_bloc.dart';
import 'package:bmw_world/application/features/bmw_world/presentation/screen/main/car/bloc/car_details_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

import 'core/constants/constants.dart';
import 'features/bmw_world/data/data_source/dao/post_database.dart';
import 'features/bmw_world/data/data_source/remote/article_api_service.dart';
import 'dio_interceptor.dart';
import 'features/bmw_world/domain/repository/article_repository.dart';

final sl = GetIt.instance;

void initializeDependencies() {
  // Secure
  sl.registerSingleton<FlutterSecureStorage>(const FlutterSecureStorage());

  // Data Provider
  sl.registerSingleton<TokenProvider>(TokenProvider(sl()));

  // Dio
  Dio dio = Dio(BaseOptions(baseUrl: baseUrl));
  dio.interceptors.add(DioInterceptor());
  sl.registerSingleton<Dio>(dio);

  // Auth
  sl.registerSingleton<AuthApiService>(AuthApiService(sl()));
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl(sl()));
  sl.registerSingleton<AuthBloc>(AuthBloc(sl(), sl()));

  // Post local
  sl.registerSingleton<PostDatabase>(PostDatabase());
  sl.registerSingleton<PostDb2>(PostDb2());
  sl.registerSingleton<PostLocalService>(PostLocalServiceImpl(sl()));

  // Post
  sl.registerSingleton<PostApiService>(PostApiService(sl()));
  sl.registerSingleton<PostRepository>(PostRepositoryImpl(sl(), sl()));
  sl.registerSingleton<GetPostsUseCase>(GetPostsUseCase(sl()));
  sl.registerFactory<PostBloc>(() => PostBloc(sl()));

  // Article
  sl.registerSingleton<ArticleApiService>(ArticleApiService(sl()));
  sl.registerSingleton<ArticleRepository>(ArticleRepositoryImpl(sl()));
  sl.registerSingleton<GetArticlesUseCase>(GetArticlesUseCase(sl()));
  sl.registerFactory<ArticleListBloc>(() => ArticleListBloc(sl()));

  // Article details
  sl.registerFactory<GetArticleUseCase>(() => GetArticleUseCase(sl()));
  sl.registerFactory<ArticleDetailsBloc>(() => ArticleDetailsBloc(sl()));

  // Car details
  sl.registerSingleton<CarApiService>(CarApiService(sl()));
  sl.registerSingleton<CarRepository>(CarRepositoryImpl(sl()));
  sl.registerSingleton<GetCarUseCase>(GetCarUseCase(sl()));
  sl.registerFactory<CarDetailsBloc>(() => CarDetailsBloc(sl()));
}
