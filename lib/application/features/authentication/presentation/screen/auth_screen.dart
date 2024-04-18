import 'package:bmw_world/application/features/authentication/presentation/screen/login/login_screen.dart';
import 'package:bmw_world/application/features/authentication/presentation/screen/register/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../generated/l10n.dart';
import '../../../../../resources/resources.dart';
import '../../../bmw_world/presentation/screen/main_screen.dart';
import 'login/bloc/auth_bloc.dart';

const backgroundImagePath =
    "https://i.pinimg.com/564x/2e/df/34/2edf3481e56839b7536f9013ff045a44.jpg";

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  void onPressedLogin(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  void onPressedRegister(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthorizedState) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const MainScreen()),
            (route) => false,
          );
        }
      },
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImages.bmwWelcomeBackground),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  /// Login Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => onPressedLogin(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.withOpacity(0.8),
                        foregroundColor: Theme.of(context).colorScheme.surface,
                      ),
                      child: Text(S.of(context).login),
                    ),
                  ),
                  const SizedBox(height: 10),

                  /// Register Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => onPressedRegister(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.withOpacity(0.3),
                        foregroundColor: Theme.of(context).colorScheme.surface,
                      ),
                      child: Text(S.of(context).register),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
