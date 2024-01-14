import 'package:bmw_world/generated/l10n.dart';
import 'package:bmw_world/ui/theme/app_color.dart';
import 'package:bmw_world/ui/theme/app_style.dart';
import 'package:bmw_world/ui/widgets/main/profile/change_password/change_password_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangePasswordWidget extends StatelessWidget {
  const ChangePasswordWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String passwordText =
        context.watch<ChangePasswordModel>().confirmPasswordController.text;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColor.background,
        appBar: AppBar(
          backgroundColor: AppColor.blueDark,
          title: Text(
            S().changePassword,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: Colors.white,
            ),
          ),
        ),
        body: SingleChildScrollView(
          reverse: true,
          child: Column(
            children: [
              const SizedBox(height: 100),
              const Padding(
                padding: EdgeInsets.only(right: 20, left: 20, top: 10),
                child: Column(
                  children: [
                    _CurrentPasswordFieldWidget(),
                    SizedBox(height: 20),
                    _NewPasswordFieldWidget(),
                    SizedBox(height: 20),
                    _ConfirmPasswordFieldWidget(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5),
                    const _ErrorMessage(),
                    const SizedBox(height: 10),
                    const _PasswordCheckTitleWidget(),
                    const SizedBox(height: 10),
                    PasswordValidation(passwordText: passwordText),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: const _SubmitButtonWidget(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ErrorMessage extends StatelessWidget {
  const _ErrorMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ChangePasswordModel>();

    String errorText = model.arePasswordsEqual ? model.errorMessage ?? "" : "";
    return Text(
      errorText,
      style: const TextStyle(
        color: Colors.redAccent,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class PasswordValidation extends StatelessWidget {
  final String passwordText;
  const PasswordValidation({Key? key, required this.passwordText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ChangePasswordModel>();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _PasswordValidationTitleWidget(
              text: "Min 8 Characters",
              isValid: model.hasMinLength,
            ),
            _PasswordValidationTitleWidget(
              text: "Lower-case Letter",
              isValid: model.hasLowerCase,
            ),
          ],
        ),
        const SizedBox(width: 30),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _PasswordValidationTitleWidget(
              text: "Number",
              isValid: model.hasNumber,
            ),
            _PasswordValidationTitleWidget(
              text: "Upper-case Letter",
              isValid: model.hasUpperCase,
            ),
          ],
        ),
      ],
    );
  }
}

class _PasswordValidationTitleWidget extends StatelessWidget {
  final String text;
  final bool isValid;

  const _PasswordValidationTitleWidget({
    Key? key,
    required this.text,
    required this.isValid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          isValid ? Icons.check : Icons.clear,
          color: isValid ? Colors.green : Colors.red,
        ),
        Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _PasswordCheckTitleWidget extends StatelessWidget {
  const _PasswordCheckTitleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      S().passwordMustContain,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class _SubmitButtonWidget extends StatelessWidget {
  const _SubmitButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<ChangePasswordModel>();

    return ElevatedButton(
      style: AppStyle.buttonStyle(),
      onPressed: () {
        model.checkEqualPasswords();
      },
      child: const Text(
        "SUBMIT",
        style: TextStyle(letterSpacing: 1),
      ),
    );
  }
}

class _ConfirmPasswordFieldWidget extends StatelessWidget {
  const _ConfirmPasswordFieldWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ChangePasswordModel>();
    return TextField(
      controller: model.confirmPasswordController,
      obscureText: model.isObscureText,
      decoration: AppStyle.passwordTextFieldStyle(
        S().confirmPassword,
        model.isObscureText,
        model.togglePasswordVisibility,
      ),
    );
  }
}

class _NewPasswordFieldWidget extends StatelessWidget {
  const _NewPasswordFieldWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ChangePasswordModel>();
    return TextField(
      controller: model.newPasswordController,
      obscureText: model.isObscureText,
      onChanged: (_) => model.validatePassword(),
      decoration: AppStyle.passwordTextFieldStyle(
        S().newPassword,
        model.isObscureText,
        model.togglePasswordVisibility,
      ),
    );
  }
}

class _CurrentPasswordFieldWidget extends StatelessWidget {
  const _CurrentPasswordFieldWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ChangePasswordModel>();
    return TextField(
      controller: model.currentPasswordController,
      obscureText: model.isObscureText,
      decoration: AppStyle.passwordTextFieldStyle(
        S().currentPassword,
        model.isObscureText,
        model.togglePasswordVisibility,
      ),
    );
  }
}
