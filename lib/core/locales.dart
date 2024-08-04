import 'package:flutter_localization/flutter_localization.dart';

const List<MapLocale> LOCALES = [
  MapLocale("en", LocaleData.EN),
  MapLocale("de", LocaleData.DE),
];

mixin LocaleData {
  static const String bottomNavItem1Titel = "bottomNavItem1Titel";
  static const String bottomNavItem2Titel = "bottomNavItem2Titel";
  static const String bottomNavItem3Titel = "bottomNavItem3Titel";

  static const Map<String, dynamic> EN = {
    bottomNavItem1Titel: "Scan",
    bottomNavItem2Titel: "History",
    bottomNavItem3Titel: "Profile",
  };

  static const Map<String, dynamic> DE = {
    bottomNavItem1Titel: "Scan",
    bottomNavItem2Titel: "Verlauf",
    bottomNavItem3Titel: "Profil",
  };
}
