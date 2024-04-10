import 'package:bmw_world/application/config/themes/theme.dart';
import 'package:bmw_world/application/config/themes/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../../../../../generated/l10n.dart';
import '../screen/auth/bloc/auth_bloc.dart';
import '../screen/auth/login_screen.dart';
import '../../../../injection_container.dart';


ThemeManager themeManager = ThemeManager();

class MainApp extends StatefulWidget {

  const MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {


  @override
  void initState() {
    themeManager.addListener(themeListener);
    super.initState();
  }

  @override
  void dispose() {
    themeManager.removeListener(themeListener);
    super.dispose();
  }

  themeListener(){
    if(mounted){
      setState(() {

      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => sl.get<AuthBloc>(),
        ),
      ],
      child: MaterialApp(
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: themeManager.themeMode,
        locale: const Locale('en'),
        supportedLocales: S.delegate.supportedLocales,
        home: const LoginScreen(),
      ),
    );
  }
}
