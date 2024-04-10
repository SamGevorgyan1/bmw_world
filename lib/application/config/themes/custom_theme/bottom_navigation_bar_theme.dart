import 'package:flutter/material.dart';

import 'color_theme.dart';

BottomNavigationBarThemeData bottomNavBarThemeDataLight = BottomNavigationBarThemeData(
  selectedItemColor: colorSchemeLight.primary,
  unselectedItemColor: colorSchemeDark.secondary,
);

BottomNavigationBarThemeData bottomNavBarThemeDataDark = BottomNavigationBarThemeData(
  selectedItemColor: colorSchemeDark.primary,
  unselectedItemColor: colorSchemeDark.secondary,
);
