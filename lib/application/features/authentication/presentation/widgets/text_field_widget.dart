
import 'package:flutter/material.dart';

Widget buildTextFormField({
  required String labelText,
  required TextEditingController controller,
  required FormFieldValidator<String>? validator,
  TextInputType? textInputType,
  bool obscureText = false,
}) {
  return TextFormField(
    decoration: InputDecoration(
      labelText: labelText,
    ),
    controller: controller,
    keyboardType: textInputType,
    obscureText: obscureText,
    validator: validator,
  );
}
