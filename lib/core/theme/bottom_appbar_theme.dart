import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'theme.dart';

var ligthBottomAppbarTheme = BottomNavigationBarThemeData(
  backgroundColor: white,
  selectedItemColor: primary,
  unselectedItemColor: neutral400,
  showSelectedLabels: true,
  showUnselectedLabels: true,
  type: BottomNavigationBarType.fixed,
  landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
  selectedLabelStyle: GoogleFonts.lexend(fontSize: 14),
  unselectedLabelStyle: GoogleFonts.lexend(fontSize: 14),
);

var darkBottomAppbarTheme = BottomNavigationBarThemeData(
  backgroundColor: neutral900,
  selectedItemColor: primary,
  unselectedItemColor: neutral500,
  showSelectedLabels: true,
  showUnselectedLabels: true,
  type: BottomNavigationBarType.fixed,
  landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
  selectedLabelStyle: GoogleFonts.lexend(fontSize: 14),
  unselectedLabelStyle: GoogleFonts.lexend(fontSize: 14),
);
