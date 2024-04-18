import 'package:flutter/material.dart';

OutlinedButtonThemeData outlinedButton = OutlinedButtonThemeData(
  style: ButtonStyle(
    side: const MaterialStatePropertyAll(
      BorderSide(color: Colors.black, width: 1),
    ),
    padding: const MaterialStatePropertyAll(
      EdgeInsets.symmetric(horizontal: 8),
    ),
    shape: MaterialStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
    elevation: const MaterialStatePropertyAll(0),
  ),
);