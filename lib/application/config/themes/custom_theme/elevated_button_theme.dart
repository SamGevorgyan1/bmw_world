import 'package:flutter/material.dart';

ElevatedButtonThemeData elevatedButtonTheme = ElevatedButtonThemeData(
  style: ButtonStyle(
    padding: const MaterialStatePropertyAll(EdgeInsets.all(20)),
    //backgroundColor: const MaterialStatePropertyAll(Colors.grey),
    //foregroundColor: const MaterialStatePropertyAll(Colors.black87),
    shape: MaterialStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
    elevation: const MaterialStatePropertyAll(0),
  ),
);

