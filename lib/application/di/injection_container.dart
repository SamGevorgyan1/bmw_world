import 'package:bmw_world/application/features/authentication/data/data_provider/token_provider.dart';
import 'package:bmw_world/application/features/authentication/data/data_provider/user_provider.dart';
import 'package:bmw_world/application/features/authentication/presentation/screen/register/bloc/register_bloc.dart';
import 'package:bmw_world/application/features/bmw_world/data/data_source/dao/article_database.dart';
import 'package:bmw_world/application/features/bmw_world/data/data_source/dao/post_database.dart';
import 'package:bmw_world/application/features/bmw_world/data/data_source/local/service/article_local_service.dart';
import 'package:bmw_world/application/features/bmw_world/data/data_source/local/service/impl/article_local_service_impl.dart';
import 'package:bmw_world/application/features/bmw_world/data/data_source/local/service/post_local_service.dart';
import 'package:bmw_world/application/features/bmw_world/data/data_source/local/service/impl/post_local_service_impl.dart';
import 'package:bmw_world/application/features/authentication/data/api/auth_api_service.dart';
import 'package:bmw_world/application/features/bmw_world/data/data_source/remote/bmw_world_api_service.dart';
import 'package:bmw_world/application/features/authentication/data/repository/auth_repository_impl.dart';
import 'package:bmw_world/application/features/authentication/domain/repository/auth_repository.dart';
import 'package:bmw_world/application/features/bmw_world/domain/repository/bmw_world_repository.dart';
import 'package:bmw_world/application/features/bmw_world/domain/usecases/get_article.dart';
import 'package:bmw_world/application/features/bmw_world/domain/usecases/get_articles.dart';
import 'package:bmw_world/application/features/bmw_world/domain/usecases/get_car.dart';
import 'package:bmw_world/application/features/bmw_world/domain/usecases/get_posts.dart';
import 'package:bmw_world/application/features/bmw_world/domain/usecases/get_user.dart';
import 'package:bmw_world/application/features/bmw_world/presentation/screen/article/bloc/article_list_bloc.dart';
import 'package:bmw_world/application/features/bmw_world/presentation/screen/post/bloc/post_bloc.dart';
import 'package:bmw_world/application/features/bmw_world/presentation/screen/article/details/bloc/article_details_bloc.dart';
import 'package:bmw_world/application/features/bmw_world/presentation/screen/car/bloc/car_details_bloc.dart';
import 'package:bmw_world/application/features/bmw_world/presentation/screen/profile/bloc/profile_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import '../core/constants/constants.dart';
import '../features/authentication/presentation/screen/login/bloc/auth_bloc.dart';
import '../dio_interceptor.dart';
import '../features/bmw_world/data/repository/bmw_world_repository_impl.dart';

final sl = GetIt.instance;

void initializeDependencies() {
  // Secure
  sl.registerSingleton<FlutterSecureStorage>(const FlutterSecureStorage());

  // Data Provider
  sl.registerSingleton<TokenProvider>(TokenProvider(sl()));
  sl.registerSingleton<UserProvider>(UserProvider(sl()));

  // Dio
  Dio dio = Dio(BaseOptions(baseUrl: bmwWoldApiUrl));
  dio.interceptors.add(DioInterceptor());
  sl.registerSingleton<Dio>(dio);

  // Post local
  sl.registerSingleton<PostDatabase>(PostDatabase());
  sl.registerSingleton<PostLocalService>(PostLocalServiceImpl(sl()));

  // Article local
  sl.registerSingleton<ArticleDatabase>(ArticleDatabase());
  sl.registerSingleton<ArticleLocalService>(ArticleLocalServiceImpl(sl()));

  // Auth
  sl.registerSingleton<AuthApiService>(AuthApiService(sl()));
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl(sl()));
  sl.registerSingleton<AuthBloc>(AuthBloc(sl(), sl(), sl()));
  sl.registerSingleton<RegisterBloc>(RegisterBloc(sl()));

  // Api
  sl.registerSingleton<BmwWorldApiService>(BmwWorldApiService(sl()));

  // Repository
  sl.registerSingleton<BmwWorldRepository>(BmwWorldRepositoryImpl(sl(), sl(), sl()));

  // Post
  sl.registerSingleton<GetPostsUseCase>(GetPostsUseCase(sl()));
  sl.registerFactory<PostBloc>(() => PostBloc(sl()));

  // Article
  sl.registerSingleton<GetArticlesUseCase>(GetArticlesUseCase(sl()));
  sl.registerFactory<ArticleListBloc>(() => ArticleListBloc(sl()));

  // Article details
  sl.registerFactory<GetArticleUseCase>(() => GetArticleUseCase(sl()));
  sl.registerFactory<ArticleDetailsBloc>(() => ArticleDetailsBloc(sl()));

  // Car details
  sl.registerSingleton<GetCarUseCase>(GetCarUseCase(sl()));
  sl.registerFactory<CarDetailsBloc>(() => CarDetailsBloc(sl()));

  // Profile
  sl.registerSingleton<GetUserUseCase>(GetUserUseCase(sl()));
  sl.registerFactory<ProfileBloc>(() => ProfileBloc(sl()));
}
