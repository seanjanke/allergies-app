import 'package:flutter/material.dart';

//COLOR PALETTE

//neutral
const white = Colors.white;
const lightBackground = Color.fromARGB(255, 251, 251, 251);
const neutral50 = Color.fromRGBO(234, 238, 241, 1);
const neutral100 = Color.fromRGBO(211, 219, 224, 1);
const neutral200 = Color.fromRGBO(190, 200, 207, 1);
const neutral300 = Color.fromRGBO(169, 181, 189, 1);
const neutral400 = Color.fromRGBO(147, 160, 170, 1);
const neutral500 = Color.fromRGBO(111, 128, 141, 1);
const neutral600 = Color.fromRGBO(71, 89, 101, 1);
const neutral700 = Color.fromRGBO(38, 59, 74, 1);
const neutral800 = Color.fromRGBO(17, 36, 50, 1);
const neutral900 = Color.fromRGBO(3, 19, 32, 1);
const darkBackground = Color.fromRGBO(0, 7, 13, 1);
const black = Colors.black;

//primary
const primary50 = Color.fromARGB(255, 237, 244, 251);
const primary100 = Color.fromARGB(255, 220, 238, 253);
const primary200 = Color.fromARGB(255, 178, 217, 249);
const primary300 = Color.fromARGB(255, 114, 184, 241);
const primary400 = Color.fromARGB(255, 74, 167, 243);
const primary = Color.fromARGB(255, 11, 127, 222);
const primary600 = Color.fromARGB(255, 5, 97, 172);
const primary700 = Color.fromARGB(255, 6, 73, 129);
const primary800 = Color.fromARGB(255, 5, 58, 101);
const primary900 = Color.fromARGB(255, 3, 45, 79);

Map<int, Color> primaryColorMap = {
  50: primary50,
  100: primary100,
  200: primary200,
  300: primary300,
  400: primary400,
  500: primary,
  600: primary600,
  700: primary700,
  800: primary800,
  900: primary900,
};

//STATES
const success100 = Color.fromARGB(255, 229, 255, 212);
const success500 = Color.fromARGB(255, 107, 218, 33);
const success900 = Color.fromARGB(255, 33, 76, 3);

const warning100 = Color.fromARGB(255, 255, 216, 212);
const warning500 = Color.fromARGB(255, 218, 52, 33);
const warning900 = Color.fromARGB(255, 76, 11, 3);

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: primary,
  onPrimary: neutral100,
  secondary: Colors.orangeAccent,
  onSecondary: neutral100,
  error: warning500,
  onError: neutral100,
  background: lightBackground,
  onBackground: neutral900,
  surface: neutral50,
  onSurface: neutral900,
  onSurfaceVariant: neutral400,
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: primary,
  onPrimary: neutral100,
  secondary: Colors.orangeAccent,
  onSecondary: neutral100,
  error: warning500,
  onError: neutral100,
  background: darkBackground,
  onBackground: neutral100,
  surface: neutral900,
  onSurface: neutral100,
  onSurfaceVariant: neutral500,
);
