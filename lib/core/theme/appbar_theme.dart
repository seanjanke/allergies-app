import 'package:allergies/core/theme/theme.dart';
import 'package:allergies/core/theme/typography.dart';
import 'package:flutter/material.dart';

var lightAppbarTheme = AppBarTheme(
  backgroundColor: white,
  centerTitle: true,
  scrolledUnderElevation: 0,
  iconTheme: const IconThemeData(color: black),
  titleTextStyle: lightTextTheme.headlineSmall,
);

var darkAppbarTheme = AppBarTheme(
  backgroundColor: neutral900,
  centerTitle: true,
  scrolledUnderElevation: 0,
  iconTheme: const IconThemeData(color: neutral100),
  titleTextStyle: darkTextTheme.headlineSmall,
);
