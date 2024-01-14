import 'package:flutter/material.dart';

class ChangePasswordModel extends ChangeNotifier {
  late final TextEditingController currentPasswordController =
      TextEditingController();
  late final TextEditingController newPasswordController =
      TextEditingController();
  late final TextEditingController confirmPasswordController =
      TextEditingController();

  bool _isValidPassword = false;
  bool get isValidPassword => _isValidPassword;

  bool hasMinLength = false;
  bool hasUpperCase = false;
  bool hasLowerCase = false;
  bool hasNumber = false;
  bool isObscureText = true;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool arePasswordsEqual = false;

  ChangePasswordModel() {
    confirmPasswordController.addListener(checkEqualPasswords);
    newPasswordController.addListener(validatePassword);
  }

  void checkEqualPasswords() {
    String newPassword = newPasswordController.text;
    String confirmPassword = confirmPasswordController.text;

    if (newPassword == confirmPassword) {
      arePasswordsEqual = true;
      _errorMessage = null;
    } else {
      _errorMessage = "Passwords do not match";
    }

    if (newPassword.isEmpty || confirmPassword.isEmpty) {
      _errorMessage = "";
      notifyListeners();
    }
    notifyListeners();
  }

  void togglePasswordVisibility() {
    isObscureText = !isObscureText;
    notifyListeners();
  }

  void validatePassword() {
    final String password = newPasswordController.text;
    hasMinLength = password.length >= 8;
    hasUpperCase = password.contains(RegExp(r'[A-Z]'));
    hasLowerCase = password.contains(RegExp(r'[a-z]'));
    hasNumber = password.contains(RegExp(r'[0-9]'));

    _isValidPassword = hasMinLength && hasUpperCase && hasNumber;

    notifyListeners();
  }
}
