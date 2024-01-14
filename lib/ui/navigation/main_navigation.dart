import 'package:bmw_world/domain/factories/screen_factory.dart';
import 'package:flutter/material.dart';

abstract class MainNavigationRouteNames {
  static const loaderWidget = "/loader";
  static const authWidget = "/auth";
  static const loginWidget = "/auth/login";
  static const registerWidget = "/auth/register";
  static const mainWidget = "/main";
  static const articleWidget = "/articleWidget";
  static const articleDetailsWidget = "/articleDetailsWidget";
  static const carWidget = "/car";
  static const carInfoWidget = "/carInfoWidget";
  static const notificationWidget = "/notification";
  static const profileWidget = "/profile";

  static const settingWidget = "/settingWidget";
  static const favoriteWidget = "/favoriteWidget";
  static const changePasswordWidget = "/changePasswordWidget";

  static const filterWidget = "/filterWidget";
}

class MainNavigation {
  static final _screenFactory = ScreenFactory();

  final routes = <String, Widget Function(BuildContext)>{
    MainNavigationRouteNames.authWidget: (_) => _screenFactory.makeAuthWidget(),
    MainNavigationRouteNames.loginWidget: (_) =>
        _screenFactory.makeLoginWidget(),
    MainNavigationRouteNames.registerWidget: (_) =>
        _screenFactory.makeRegisterWidget(),
    MainNavigationRouteNames.mainWidget: (_) => _screenFactory.makeMainWidget(),

    MainNavigationRouteNames.loaderWidget: (_) => _screenFactory.makeLoader(),

    MainNavigationRouteNames.settingWidget: (_) =>
        _screenFactory.makeSettingInWidget(),
    MainNavigationRouteNames.changePasswordWidget: (_) =>
        _screenFactory.makeChangePasswordWidget(),
    MainNavigationRouteNames.favoriteWidget: (_) =>
        _screenFactory.makeFavoriteWidget(),
    MainNavigationRouteNames.articleWidget: (_) =>
        _screenFactory.makeArticleWidget(),

    MainNavigationRouteNames.carWidget: (_) => _screenFactory.makePostWidget(),
    MainNavigationRouteNames.notificationWidget: (_) =>
        _screenFactory.makeNotificationWidget(),

    MainNavigationRouteNames.profileWidget: (_) =>
        _screenFactory.makeProfileWidget(),

    //
    MainNavigationRouteNames.carInfoWidget: (context) {
      final carId = ModalRoute.of(context)?.settings.arguments as int;
      return _screenFactory.makeCarInfoWidget(carId);
    },
    MainNavigationRouteNames.articleDetailsWidget: (context) {
      final articleId = ModalRoute.of(context)?.settings.arguments as int;
      return _screenFactory.makeArticleDetailsWidget(articleId);
    },
  };
}
