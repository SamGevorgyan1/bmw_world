import 'package:flutter/material.dart';

import 'color_theme.dart';

/// Light Mode
TextTheme textThemeLight = TextTheme(
  displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: colorSchemeLight.onBackground),
  displayMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: colorSchemeLight.onBackground),
  displaySmall: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: colorSchemeLight.onBackground),
  headlineLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: colorSchemeLight.onBackground),
  headlineMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: colorSchemeLight.onBackground),
  headlineSmall: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: colorSchemeLight.onBackground),
  titleLarge: TextStyle(fontSize: 20, color: colorSchemeLight.onBackground),
  titleMedium: TextStyle(fontSize: 18, color: colorSchemeLight.onBackground),
  titleSmall: TextStyle(fontSize: 16, color: colorSchemeLight.onBackground),
  bodyLarge: TextStyle(fontSize: 16, color: colorSchemeLight.onBackground),
  bodyMedium: TextStyle(fontSize: 14, color: colorSchemeLight.onBackground),
  bodySmall: TextStyle(fontSize: 12, color: colorSchemeLight.onBackground),
  labelLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: colorSchemeLight.onBackground),
);

/// Dark Mode
TextTheme textThemeDark = TextTheme(
  displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: colorSchemeDark.onBackground),
  displayMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: colorSchemeDark.onBackground),
  displaySmall: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: colorSchemeDark.onBackground),
  headlineLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: colorSchemeDark.onBackground),
  headlineMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: colorSchemeDark.onBackground),
  headlineSmall: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: colorSchemeDark.onBackground),
  titleLarge: TextStyle(fontSize: 20, color: colorSchemeDark.onBackground),
  titleMedium: TextStyle(fontSize: 18, color: colorSchemeDark.onBackground),
  titleSmall: TextStyle(fontSize: 16, color: colorSchemeDark.onBackground),
  bodyLarge: TextStyle(fontSize: 16, color: colorSchemeDark.onBackground),
  bodyMedium: TextStyle(fontSize: 14, color: colorSchemeDark.onBackground),
  bodySmall: TextStyle(fontSize: 12, color: colorSchemeDark.onBackground),
  labelLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: colorSchemeDark.onBackground),
);