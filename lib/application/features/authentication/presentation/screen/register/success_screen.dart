import 'package:bmw_world/application/features/authentication/presentation/screen/login/login_screen.dart';
import 'package:bmw_world/application/features/authentication/presentation/screen/register/bloc/register_bloc.dart';
import 'package:bmw_world/application/features/bmw_world/presentation/screen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../generated/l10n.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({Key? key}) : super(key: key);

  void onPressedContinue(BuildContext context) {
    context.read<RegisterBloc>().add(RegisterEvent.login());
  }

  void onPressedBackToLogin(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state.isLoginSuccess!) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const MainScreen(),
            ),
            (route) => false,
          );
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.check_circle,
            size: 120,
            color: Colors.green,
          ),
          const SizedBox(height: 20),
          Text(
            S.of(context).successfully,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(height: 3),
          Text(
            S.of(context).emailAddressHasBeenVerified,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: ElevatedButton(
              onPressed: () => onPressedContinue(context),
              child: Text(S.of(context).continue_),
            ),
          ),
          const SizedBox(height: 10),
          TextButton.icon(
            icon: const Icon(Icons.arrow_left),
            onPressed: () => onPressedBackToLogin(context),
            label: Text(S.of(context).backToLogin),
          ),
        ],
      ),
    );
  }
}
