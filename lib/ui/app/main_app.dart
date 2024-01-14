import 'package:bmw_world/generated/l10n.dart';
import 'package:bmw_world/ui/navigation/main_navigation.dart';

import 'package:bmw_world/ui/widgets/main/post/filter_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

class MainApp extends StatelessWidget {
  static final mainNavigation = MainNavigation();
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => FilterViewModel()),
        ],
        child: MaterialApp(
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          locale: const Locale('en'),
          supportedLocales: S.delegate.supportedLocales,
          routes: mainNavigation.routes,
          initialRoute: MainNavigationRouteNames.loaderWidget,
        ));
  }
}
