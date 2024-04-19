import 'package:bmw_world/application/features/authentication/data/authentication_storage_provider/authentication_provider.dart';
import 'package:bmw_world/application/features/authentication/domain/usecase/login_usecase.dart';
import 'package:bmw_world/application/features/authentication/domain/usecase/logout_usecase.dart';
import 'package:bmw_world/application/features/authentication/domain/usecase/registration_usecase.dart';
import 'package:bmw_world/application/features/authentication/domain/usecase/send_verify_code_usecase.dart';
import 'package:bmw_world/application/features/authentication/domain/usecase/verify_usecase.dart';
import 'package:bmw_world/application/features/authentication/presentation/screen/auth_bloc/auth_bloc.dart';
import 'package:bmw_world/application/features/authentication/presentation/screen/login/bloc/login_bloc.dart';
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
import '../dio_interceptor.dart';
import '../features/bmw_world/data/repository/bmw_world_repository_impl.dart';

final sl = GetIt.instance;

void initializeDependencies() {
  // Secure
  sl.registerSingleton<FlutterSecureStorage>(const FlutterSecureStorage());

  // Data Provider
  sl.registerSingleton<AuthenticationProvider>(AuthenticationProvider(sl()));

  // Dio
  Dio dio = Dio(BaseOptions(baseUrl: bmwWoldApiUrl));
  dio.interceptors.add(DioInterceptor());
  sl.registerSingleton<Dio>(dio);

  // Auth
  sl.registerSingleton<AuthApiService>(AuthApiService(sl()));
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl(sl(), sl()));

  // Authentication UseCases
  sl.registerSingleton<RegistrationUseCase>(RegistrationUseCase(sl()));
  sl.registerSingleton<VerifyUseCase>(VerifyUseCase(sl()));
  sl.registerSingleton<SendVerifyCodeUseCase>(SendVerifyCodeUseCase(sl()));
  sl.registerSingleton<LoginUseCase>(LoginUseCase(sl()));
  sl.registerSingleton<LogoutUseCase>(LogoutUseCase(sl()));

  // Authentication blocs
  sl.registerFactory<AuthBloc>(() => AuthBloc(sl()));
  sl.registerFactory<RegisterBloc>(() => RegisterBloc(sl(), sl(), sl(), sl()));
  sl.registerFactory<LoginBloc>(() => LoginBloc(sl()));

  // Post local
  sl.registerSingleton<PostDatabase>(PostDatabase());
  sl.registerSingleton<PostLocalService>(PostLocalServiceImpl(sl()));

  // Article local
  sl.registerSingleton<ArticleDatabase>(ArticleDatabase());
  sl.registerSingleton<ArticleLocalService>(ArticleLocalServiceImpl(sl()));

  // Repository
  sl.registerSingleton<BmwWorldApiService>(BmwWorldApiService(sl()));
  sl.registerSingleton<BmwWorldRepository>(BmwWorldRepositoryImpl(sl(), sl(), sl()));

  // Post
  sl.registerSingleton<GetPostsUseCase>(GetPostsUseCase(sl()));
  sl.registerFactory<PostBloc>(() => PostBloc(sl()));

  // Article
  sl.registerSingleton<GetArticlesUseCase>(GetArticlesUseCase(sl()));
  sl.registerFactory<ArticleListBloc>(() => ArticleListBloc(sl()));

  // Article details
  sl.registerSingleton<GetArticleUseCase>(GetArticleUseCase(sl()));
  sl.registerFactory<ArticleDetailsBloc>(() => ArticleDetailsBloc(sl()));

  // Car details
  sl.registerSingleton<GetCarUseCase>(GetCarUseCase(sl()));
  sl.registerFactory<CarDetailsBloc>(() => CarDetailsBloc(sl()));

  // Profile
  sl.registerSingleton<GetUserUseCase>(GetUserUseCase(sl()));
  sl.registerFactory<ProfileBloc>(() => ProfileBloc(sl(), sl()));
}
