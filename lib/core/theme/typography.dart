import 'package:allergies/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var lightTextTheme = TextTheme(
  displayLarge: GoogleFonts.lexend(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: black,
  ),
  displayMedium: GoogleFonts.lexend(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: black,
  ),
  displaySmall: GoogleFonts.lexend(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: black,
  ),
  headlineLarge: GoogleFonts.lexend(
    fontSize: 26,
    fontWeight: FontWeight.bold,
    color: black,
  ),
  headlineMedium: GoogleFonts.lexend(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: black,
  ),
  headlineSmall: GoogleFonts.lexend(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: black,
  ),
  labelLarge: GoogleFonts.lexend(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: black,
  ),
  labelMedium: GoogleFonts.lexend(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: black,
  ),
  labelSmall: GoogleFonts.lexend(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: black,
  ),
  bodyLarge: GoogleFonts.lexend(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: black,
  ),
  bodyMedium: GoogleFonts.lexend(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: black,
  ),
  bodySmall: GoogleFonts.lexend(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: black,
  ),
);

var darkTextTheme = TextTheme(
  displayLarge: GoogleFonts.lexend(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: white,
  ),
  displayMedium: GoogleFonts.lexend(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: white,
  ),
  displaySmall: GoogleFonts.lexend(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: white,
  ),
  headlineLarge: GoogleFonts.lexend(
    fontSize: 26,
    fontWeight: FontWeight.bold,
    color: white,
  ),
  headlineMedium: GoogleFonts.lexend(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: white,
  ),
  headlineSmall: GoogleFonts.lexend(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: white,
  ),
  labelLarge: GoogleFonts.lexend(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: white,
  ),
  labelMedium: GoogleFonts.lexend(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: white,
  ),
  labelSmall: GoogleFonts.lexend(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: white,
  ),
  bodyLarge: GoogleFonts.lexend(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: white,
  ),
  bodyMedium: GoogleFonts.lexend(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: white,
  ),
  bodySmall: GoogleFonts.lexend(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: white,
  ),
);

const lightTextSelectionTheme = TextSelectionThemeData(
  cursorColor: neutral100,
  selectionColor: primary100,
  selectionHandleColor: primary,
);

const darkTextSelectionTheme = TextSelectionThemeData(
  cursorColor: neutral900,
  selectionColor: primary700,
  selectionHandleColor: primary,
);
