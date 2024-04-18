import 'package:bmw_world/application/core/extension/validator.dart';
import 'package:bmw_world/application/features/authentication/presentation/screen/register/verification_screen.dart';
import 'package:flutter/material.dart';
import 'package:bmw_world/application/features/authentication/presentation/widgets/app_bar_widget.dart';
import 'package:bmw_world/generated/l10n.dart';
import 'package:bmw_world/resources/resources.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../di/injection_container.dart';
import '../../../../../core/helper/error_handler.dart';
import '../../widgets/error_widget.dart';
import '../../widgets/text_field_widget.dart';
import 'bloc/register_bloc.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<RegisterBloc>(),
      child: BlocSelector<RegisterBloc, RegisterState, bool>(
        selector: (state) => state.isRegistrationSuccess ?? false,
        builder: (context, registrationSuccess) {
          if (registrationSuccess) {
            WidgetsBinding.instance.addPostFrameCallback(
              (_) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (c) {
                      return BlocProvider.value(
                        value: BlocProvider.of<RegisterBloc>(context),
                        child: const VerificationScreen(),
                      );
                    },
                  ),
                );
              },
            );
          }
          return const _RegisterContent();
        },
      ),
    );
  }
}

class _RegisterContent extends StatefulWidget {
  const _RegisterContent({Key? key}) : super(key: key);

  @override
  _RegisterContentState createState() => _RegisterContentState();
}

class _RegisterContentState extends State<_RegisterContent> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _passwordController = TextEditingController();

  void onPressedRegister(BuildContext context) {
    final registerBloc = BlocProvider.of<RegisterBloc>(context);
    if (_formKey.currentState!.validate()) {
      registerBloc.add(
        RegisterEvent.registerButtonPressed(
          email: _emailController.text,
          fistName: _firstNameController.text,
          lastName: _lastNameController.text,
          password: _passwordController.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = context.read<RegisterBloc>().state;
    bool isLoading = state.isLoading ?? false;

    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state.registerError != null) {
          final errorMessage = getExceptionMessage(
            exception: state.registerError,
            conflictMessage: "User Already exists",
          );
          ScaffoldMessenger.of(context).showSnackBar(
            errorSnackBarWidget(context, errorMessage),
          );
        }
      },
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.bmwBackgroundInterior),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          // backgroundColor: Colors.transparent,
          appBar: CustomAppBarWidget(
            title: S.of(context).alreadyHaveAccount,
            buttonTitle: S.of(context).login,
            callback: () {},
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  /// Email
                  buildTextFormField(
                    controller: _emailController,
                    textInputType: TextInputType.emailAddress,
                    labelText: S.of(context).email,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return S.of(context).plsEnterEmail;
                      }
                      if (!value.isValidEmail) {
                        return S.of(context).plsEnterValidEmail;
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  /// Fist Name
                  buildTextFormField(
                    controller: _firstNameController,
                    labelText: S.of(context).yourName,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return S.of(context).plsEnterFirstName;
                      }
                      if (!value.isValidFirstName) {
                        return S.of(context).plsEnterValidFirstName;
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  /// Last Name
                  buildTextFormField(
                    controller: _lastNameController,
                    labelText: S.of(context).yourLastname,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return S.of(context).plsEnterLastName;
                      }
                      if (!value.isValidLastName) {
                        return S.of(context).plsEnterValidLastName;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  /// Password
                  buildTextFormField(
                    controller: _passwordController,
                    labelText: S.of(context).password,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return S.of(context).plsEnterPassword;
                      }
                      if (!value.isValidLastName) {
                        return S.of(context).plsEnterValidPassword;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  /// Register Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : () => onPressedRegister(context),
                      child: isLoading
                          ? const CircularProgressIndicator()
                          : Text(S.of(context).register),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
