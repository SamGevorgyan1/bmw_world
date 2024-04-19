import 'package:bmw_world/application/core/extension/validator.dart';
import 'package:bmw_world/application/di/injection_container.dart';
import 'package:bmw_world/application/features/authentication/presentation/widgets/app_bar_widget.dart';
import 'package:bmw_world/application/features/bmw_world/presentation/screen/main_screen.dart';
import 'package:bmw_world/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../core/helper/error_handler.dart';
import '../../widgets/error_widget.dart';
import 'bloc/login_bloc.dart';

/// Class for storing authentication data
class _AuthDataStorage {
  String email = "";
  String password = "";
}

/// Login screen widget
class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<LoginBloc>(),
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) => _handleAuthState(context, state),
        child: const _LoginScreenContent(),
      ),
    );
  }

  /// Handle authentication state
  void _handleAuthState(BuildContext context, LoginState state) {
    if (state.isLoginSuccess!) {
      /// Navigate to the main screen if authorized
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const MainScreen()),
        (route) => false,
      );
    }
    if (state.loginError != null) {
      /// Show error message if authentication fails
      final errorMessage = getExceptionMessage(
        exception: state.loginError,
        badRequestMessage: "Wrong email or password",
      );
      ScaffoldMessenger.of(context).showSnackBar(
        errorSnackBarWidget(context, errorMessage),
      );
    }
  }
}

/// Widget for the content of the login screen
class _LoginScreenContent extends StatelessWidget {
  const _LoginScreenContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => _AuthDataStorage(),
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.bmwBackgroundInterior),
            fit: BoxFit.cover,
          ),
        ),
        child: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            backgroundColor: Colors.transparent,
            extendBody: true,
            appBar: CustomAppBarWidget(
              title: S.of(context).dontHaveAnAccount,
              callback: () {},
              buttonTitle: S.of(context).getStarted,
            ),
            body: _buildLoginForm(context),
          ),
        ),
      ),
    );
  }

  /// Build the login form
  Center _buildLoginForm(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Image.asset(AppImages.icBmwActive),
              const SizedBox(height: 20),
              Text(
                S.of(context).welcomeBack,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 3),
              Text(
                S.of(context).enterDetailsBelow,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 30),
              const EmailTextField(),
              const SizedBox(height: 10),
              const PasswordTextField(),
              const SizedBox(height: 10),
              const SizedBox(
                width: double.infinity,
                child: LoginButton(),
              ),
              const ForgotPasswordButton(),
            ],
          ),
        ),
      ),
    );
  }
}

/// Widget for the "Forgot password?" button
class ForgotPasswordButton extends StatelessWidget {
  const ForgotPasswordButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Text(S.of(context).forgotPassword),
    );
  }
}

/// Widget for the email text field
class EmailTextField extends StatelessWidget {
  const EmailTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authDataStorage = context.read<_AuthDataStorage>();
    return TextField(
      onChanged: (text) => authDataStorage.email = text,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: S.of(context).email,
      ),
    );
  }
}

/// Widget for the password text field
class PasswordTextField extends StatelessWidget {
  const PasswordTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authDataStorage = context.read<_AuthDataStorage>();
    return TextField(
      onChanged: (text) => authDataStorage.password = text,
      decoration: InputDecoration(
        labelText: S.of(context).password,
      ),
      obscureText: true,
      enableSuggestions: false,
      autocorrect: false,
    );
  }
}

/// Widget for the login button
class LoginButton extends StatelessWidget {
  const LoginButton({Key? key}) : super(key: key);

  void onPressed(BuildContext context) {
    final loginBloc = BlocProvider.of<LoginBloc>(context);
    final authDataStorage = Provider.of<_AuthDataStorage>(context, listen: false);
    String errorMessage = "";
    final isValidEmail = authDataStorage.email.isValidEmail;
    final isValidPassword = authDataStorage.password.isValidPassword;

    if (!isValidEmail && !isValidPassword) {
      errorMessage = S().plsEnterValidEmailAndPassword;
    } else if (!isValidEmail) {
      errorMessage = S().plsEnterValidEmail;
    } else if (!isValidPassword) {
      errorMessage = S().plsEnterValidPassword;
    }

    if (!isValidEmail || !isValidPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        errorSnackBarWidget(context, errorMessage),
      );
      return;
    }
    loginBloc.add(
      LoginEvent.emailAndPassword(
        authDataStorage.email,
        authDataStorage.password,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        final child =
            state.isLoading! ? const CircularProgressIndicator() : Text(S.of(context).login);

        return ElevatedButton(
          onPressed: state.isLoading! ? null : () => onPressed(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Theme.of(context).colorScheme.surface,
          ),
          child: child,
        );
      },
    );
  }
}
