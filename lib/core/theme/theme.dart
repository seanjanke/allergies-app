import 'package:allergies/core/theme/appbar_theme.dart';
import 'package:allergies/core/theme/bottom_appbar_theme.dart';
import 'package:allergies/core/theme/color_palette.dart';
import 'package:allergies/core/theme/icon_theme.dart';
import 'package:allergies/core/theme/typography.dart';
import 'package:flutter/material.dart';

export 'color_palette.dart';
export 'scaling_system.dart';

//LIGHT THEME

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  primaryColor: primary,
  scaffoldBackgroundColor: lightBackground,
  primarySwatch: MaterialColor(primary.value, primaryColorMap),
  colorScheme: lightColorScheme,
  textTheme: lightTextTheme,
  textSelectionTheme: lightTextSelectionTheme,
  appBarTheme: lightAppbarTheme,
  bottomNavigationBarTheme: ligthBottomAppbarTheme,
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  iconButtonTheme: iconButtonThemeLight,
  iconTheme: iconThemeLight,
);

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  primaryColor: primary,
  primarySwatch: MaterialColor(primary.value, primaryColorMap),
  colorScheme: darkColorScheme,
  scaffoldBackgroundColor: darkBackground,
  textTheme: darkTextTheme,
  textSelectionTheme: darkTextSelectionTheme,
  appBarTheme: darkAppbarTheme,
  bottomNavigationBarTheme: darkBottomAppbarTheme,
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  iconButtonTheme: iconButtonThemeDark,
  iconTheme: iconThemeDark,
);
