import 'package:bmw_world/domain/bloc/article_bloc.dart';
import 'package:bmw_world/domain/bloc/auth_bloc.dart';
import 'package:bmw_world/ui/widgets/auth/auth_widget.dart';
import 'package:bmw_world/ui/widgets/auth/login/auth_view_cubit.dart';
import 'package:bmw_world/ui/widgets/auth/login/login_widget.dart';
import 'package:bmw_world/ui/widgets/auth/register/register_widget.dart';
import 'package:bmw_world/ui/widgets/loader/loader_view_cibit.dart';
import 'package:bmw_world/ui/widgets/loader/loader_widget.dart';
import 'package:bmw_world/ui/widgets/main/article/article_cubit.dart';
import 'package:bmw_world/ui/widgets/main/article/article_details/article_details.dart';
import 'package:bmw_world/ui/widgets/main/article/article_details/article_details_view_model.dart';
import 'package:bmw_world/ui/widgets/main/main_widget.dart';
import 'package:bmw_world/ui/widgets/main/car_info/car_info_view_model.dart';
import 'package:bmw_world/ui/widgets/main/car_info/car_info_widget.dart';
import 'package:bmw_world/ui/widgets/main/article/article_details/article_widget.dart';
import 'package:bmw_world/ui/widgets/main/notification/notification_widget.dart';
import 'package:bmw_world/ui/widgets/main/post/post_view_model.dart';
import 'package:bmw_world/ui/widgets/main/post/post_widget.dart';
import 'package:bmw_world/ui/widgets/main/profile/change_password/change_password_model.dart';
import 'package:bmw_world/ui/widgets/main/profile/change_password/change_password_widget.dart';
import 'package:bmw_world/ui/widgets/main/profile/favorite/favorite_widget.dart';
import 'package:bmw_world/ui/widgets/main/profile/profile_widget.dart';
import 'package:bmw_world/ui/widgets/main/profile/setting/setting_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class ScreenFactory {
  AuthBloc? _authBloc;
  Widget makeAuthWidget() {
    return const AuthWidget();
  }

  Widget makeLoader() {
    final authBloc = _authBloc ?? AuthBloc(AuthCheckStatusInProgressState());
    _authBloc = authBloc;
    return BlocProvider<LoaderViewCubit>(
      create: (_) => LoaderViewCubit(
        LoaderViewCubitState.unknown,
        authBloc,
      ),
      child: const LoaderWidget(),
    );
  }

  Widget makeLoginWidget() {
    final authBloc = _authBloc ?? AuthBloc(AuthCheckStatusInProgressState());
    _authBloc = authBloc;
    return BlocProvider<AuthViewCubit>(
      create: (_) => AuthViewCubit(
        AuthViewCubitFormFillInProgressState(),
        authBloc,
      ),
      child: const LoginWidget(),
    );
  }

  Widget makeRegisterWidget() {
    return const RegisterWidget();
  }

  Widget makeMainWidget() {
    return const MainWidget();
  }

  Widget makePostWidget() {
    return ChangeNotifierProvider(
      create: (context) => PostViewModel(),
      lazy: false,
      child: const PostWidget(),
    );
  }

  Widget makeProfileWidget() {
    return const ProfileWidget();
  }

  Widget makeArticleWidget() {
    final articleBloc = ArticleBloc(ArticleState());
    return BlocProvider<ArticleCubit>(
      create: (_) => ArticleCubit(articleBloc: articleBloc),
      child: const ArticleWidget(),
    );
  }

  Widget makeSettingInWidget() {
    return const SettingWidget();
  }

  Widget makeFavoriteWidget() {
    return const FavoriteWidget();
  }

  Widget makeNotificationWidget() {
    return const NotificationWidget();
  }

  Widget makeChangePasswordWidget() {
    return ChangeNotifierProvider(
      create: (context) => ChangePasswordModel(),
      lazy: false,
      child: const ChangePasswordWidget(),
    );
  }

  Widget makeCarInfoWidget(int carId) {
    return ChangeNotifierProvider(
      create: (context) => CarInfoModel(),
      lazy: false,
      child: CarInfoWidget(carId: carId),
    );
  }

  Widget makeArticleDetailsWidget(int articleId) {
    return ChangeNotifierProvider(
      create: (context) => ArticleDetailsViewModel(),
      lazy: false,
      child: ArticleDetailsWidget(articleId: articleId),
    );
  }
}
