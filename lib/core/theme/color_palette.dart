import 'package:flutter/material.dart';

//COLOR PALETTE

//neutral

const white = Colors.white;
const lightBackground = Color.fromARGB(255, 251, 251, 251);
const neutral50 = Color.fromRGBO(242, 242, 242, 1);
const neutral100 = Color.fromRGBO(230, 230, 230, 1);
const neutral200 = Color.fromRGBO(204, 204, 204, 1);
const neutral300 = Color.fromRGBO(179, 179, 179, 1);
const neutral400 = Color.fromRGBO(153, 153, 153, 1);
const neutral500 = Color.fromRGBO(128, 128, 128, 1);
const neutral600 = Color.fromRGBO(102, 102, 102, 1);
const neutral700 = Color.fromRGBO(77, 77, 77, 1);
const neutral800 = Color.fromRGBO(51, 51, 51, 1);
const neutral900 = Color.fromRGBO(26, 26, 26, 1);
const neutral950 = Color.fromRGBO(12, 12, 12, 1);
const darkBackground = Color.fromRGBO(6, 6, 6, 1);
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
const success500 = Color.fromARGB(255, 14, 215, 34);
const success900 = Color.fromARGB(255, 33, 76, 3);

const warning100 = Color.fromARGB(255, 241, 239, 200);
const warning500 = Color.fromARGB(255, 246, 238, 7);
const warning900 = Color.fromARGB(255, 88, 84, 1);

const error100 = Color.fromARGB(255, 255, 216, 212);
const error500 = Color.fromARGB(255, 218, 52, 33);
const error900 = Color.fromARGB(255, 76, 11, 3);

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: primary,
  onPrimary: neutral100,
  secondary: Colors.orangeAccent,
  onSecondary: neutral100,
  error: warning500,
  onError: neutral100,
  background: lightBackground,
  onBackground: neutral300, //unselected button on background
  surface: neutral50, //container on background
  onSurface: neutral950, //text on container on background
  onSurfaceVariant: neutral400, //info text on background
  tertiary: white, //white container on background
  onTertiary: neutral100, //border of container on background
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: primary,
  onPrimary: neutral100,
  secondary: Colors.orangeAccent,
  onSecondary: neutral100,
  error: warning500,
  onError: neutral100,
  background: black,
  onBackground: neutral900, //unselected button on background
  surface: neutral900, //container on background
  onSurface: neutral100, //text on container on background
  onSurfaceVariant: neutral500, //info text on background
  tertiary: neutral900, //dark container on background
  onTertiary: neutral800, //border of container on background
);
