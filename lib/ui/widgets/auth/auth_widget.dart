import 'package:bmw_world/ui/navigation/main_navigation.dart';
import 'package:bmw_world/ui/theme/app_style.dart';
import 'package:flutter/material.dart';

class AuthWidget extends StatelessWidget {
  const AuthWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _LoginButtonWidget(),
                SizedBox(height: 30),
                _RegisterButtonWidget(),
                SizedBox(height: 60),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LoginButtonWidget extends StatelessWidget {
  const _LoginButtonWidget({Key? key}) : super(key: key);
  void onPressLoginButton(BuildContext context) =>
      Navigator.pushNamed(context, MainNavigationRouteNames.loginWidget);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressLoginButton(context),
      style: AppStyle.buttonStyle(),
      child: const Text("Login"),
    );
  }
}

class _RegisterButtonWidget extends StatelessWidget {
  const _RegisterButtonWidget({Key? key}) : super(key: key);

  void onPressRegisterButton(BuildContext context) =>
      Navigator.pushNamed(context, MainNavigationRouteNames.registerWidget);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressRegisterButton(context),
      style: AppStyle.buttonStyle(),
      child: const Text("Register"),
    );
  }
}
