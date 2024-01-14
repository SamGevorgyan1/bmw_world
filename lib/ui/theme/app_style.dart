import 'package:bmw_world/ui/theme/app_color.dart';
import 'package:flutter/material.dart';

abstract class AppStyle {
  static InputDecoration passwordTextFieldStyle(
    String label,
    bool isObscureText,
    VoidCallback callback,
  ) {
    return InputDecoration(
      border: const OutlineInputBorder(),
      label: Text(
        label,
        style: const TextStyle(color: AppColor.blueDark),
      ),
      suffix: GestureDetector(
        onTap: callback,
        child: Icon(
          isObscureText ? Icons.visibility_off : Icons.visibility,
        ),
      ),
      filled: true,
      fillColor: Colors.grey[200],
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColor.blueDark),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  static ButtonStyle buttonStyle() {
    return ButtonStyle(
      backgroundColor: MaterialStateProperty.all(AppColor.blueDark),
      foregroundColor: MaterialStateProperty.all(Colors.white),
      textStyle: MaterialStateProperty.all(
        const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
      ),
      padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(vertical: 15, horizontal: 20)),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      elevation: MaterialStateProperty.all(5),
    );
  }
}
