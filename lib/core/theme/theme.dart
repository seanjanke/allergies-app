import 'package:allergies/core/theme/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

export 'color_palette.dart';
export 'scaling_system.dart';

//LIGHT THEME

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,
  primaryColor: primary,
  scaffoldBackgroundColor: background,
  textTheme: TextTheme(
    displayLarge: GoogleFonts.lexend(
      fontSize: 32,
      fontWeight: FontWeight.w700,
      color: neutral900,
    ),
    displayMedium: GoogleFonts.lexend(
      fontSize: 28,
      fontWeight: FontWeight.w700,
      color: neutral900,
    ),
    displaySmall: GoogleFonts.lexend(
      fontSize: 24,
      fontWeight: FontWeight.w700,
      color: neutral900,
    ),
    headlineLarge: GoogleFonts.lexend(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: neutral900,
    ),
    headlineMedium: GoogleFonts.lexend(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: neutral900,
    ),
    headlineSmall: GoogleFonts.lexend(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: neutral900,
    ),
    labelLarge: GoogleFonts.lexend(
      color: neutral500,
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),
    labelMedium: GoogleFonts.lexend(
      color: neutral500,
      fontSize: 14,
      fontWeight: FontWeight.w600,
    ),
    labelSmall: GoogleFonts.lexend(
      color: neutral500,
      fontSize: 14,
      fontWeight: FontWeight.w600,
    ),
    bodyLarge: GoogleFonts.lexend(
      color: neutral300,
      fontSize: 18,
      fontWeight: FontWeight.w500,
    ),
    bodyMedium: GoogleFonts.lexend(
      color: neutral300,
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
    bodySmall: GoogleFonts.lexend(
      color: neutral300,
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
  ),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: neutral100,
    selectionColor: primary100,
    selectionHandleColor: primary,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: white,
    centerTitle: true,
    scrolledUnderElevation: 0,
    iconTheme: const IconThemeData(color: black),
    titleTextStyle: GoogleFonts.lexend(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: neutral900,
    ),
  ),
);
