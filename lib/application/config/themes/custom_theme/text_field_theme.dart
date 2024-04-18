import 'package:bmw_world/application/config/themes/custom_theme/color_theme.dart';
import 'package:flutter/material.dart';

InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: colorSchemeLight.secondary),
  ),
  border: OutlineInputBorder(
    borderSide: BorderSide(color:colorSchemeLight.primary),
    borderRadius: BorderRadius.circular(12),
  ),
);