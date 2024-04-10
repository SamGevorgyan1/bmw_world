import 'package:bmw_world/application/features/bmw_world/presentation/screen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../../../injection_container.dart';
import '../../../data/data_provider/token_provider.dart';
import 'bloc/auth_bloc.dart';

class _AuthDataStorage {
  String email = "";
  String password = "";
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthorizedState) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const MainScreen()),
              (route) => false,
            );
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          bloc: sl<AuthBloc>(),
          builder: (context, state) {
            return Provider(
              create: (context) => _AuthDataStorage(),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  EmailTextField(),
                  PasswordTextField(),
                  LoginButton(),
                  DeleteButton(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class EmailTextField extends StatelessWidget {
  const EmailTextField({super.key});

  @override
  Widget build(BuildContext context) {
    final authDataStorage = context.read<_AuthDataStorage>();
    return TextField(
      onChanged: (text) => authDataStorage.email = text,
    );
  }
}

class PasswordTextField extends StatelessWidget {
  const PasswordTextField({super.key});

  @override
  Widget build(BuildContext context) {
    final authDataStorage = context.read<_AuthDataStorage>();
    return TextField(
      onChanged: (text) => authDataStorage.password = text,
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  void login(BuildContext context, String email, String password) {
    final authBloc = context.read<AuthBloc>();
    authBloc.add(AuthLoginEvent(login: email, password: password));
  }

  @override
  Widget build(BuildContext context) {
    final authDataStorage = context.read<_AuthDataStorage>();
    return ElevatedButton(
      onPressed: () => login(context, authDataStorage.email, authDataStorage.password),
      child: const Text("Login"),
    );
  }
}

class DeleteButton extends StatelessWidget {
  const DeleteButton({super.key});

  void delete(BuildContext context) {
    TokenProvider(sl()).deleteAccessToken();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => delete(context),
      child: const Text("Delete Token"),
    );
  }
}
