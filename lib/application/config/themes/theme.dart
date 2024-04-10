import 'package:bmw_world/application/config/themes/custom_theme/text_theme.dart';
import 'package:flutter/material.dart';

import 'custom_theme/bottom_navigation_bar_theme.dart';
import 'custom_theme/color_theme.dart';
import 'custom_theme/elevated_button_theme.dart';
import 'custom_theme/outlined_button_theme.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  textTheme:textThemeLight,
  colorScheme: colorSchemeLight,
  elevatedButtonTheme: elevatedButtonTheme,
  outlinedButtonTheme: outlinedButton,
  bottomNavigationBarTheme: bottomNavBarThemeDataLight,
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  textTheme:textThemeDark,
  colorScheme: colorSchemeDark,
  elevatedButtonTheme: elevatedButtonTheme,
  outlinedButtonTheme: outlinedButton,
  bottomNavigationBarTheme: bottomNavBarThemeDataDark
);
