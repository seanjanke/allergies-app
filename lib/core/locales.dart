import 'package:flutter_localization/flutter_localization.dart';

const List<MapLocale> LOCALES = [
  MapLocale("en", LocaleData.EN),
  MapLocale("de", LocaleData.DE),
  MapLocale("es", LocaleData.ES),
  MapLocale("fr", LocaleData.FR),
];

mixin LocaleData {
  static const String bottomNavItem1Titel = "bottomNavItem1Titel";
  static const String bottomNavItem2Titel = "bottomNavItem2Titel";
  static const String bottomNavItem3Titel = "bottomNavItem3Titel";
  static const String scanResultInfo = "scanResultInfo";
  static const String noAllergies = "noAllergies";
  static const String historyTitle = "historyTitle";
  static const String today = "today";
  static const String yesterday = "yesterday";
  static const String allergiesTitle = "allergiesTitle";
  static const String noAllergenesSelected = "noAllergenesSelected";
  static const String settingsTitle = "settingsTitle";
  static const String settingsAppearance = "settingsAppearance";
  static const String settingsLanguage = "settingsLanguage";
  static const String lightMode = "lightMode";
  static const String darkMode = "darkMode";
  static const String systemMode = "systemMode";
  static const String moreLanguagesSoon = "moreLanguagesSoon";
  static const String safe = "safe";
  static const String contactUs = "contactUs";
  static const String shareApp = "shareApp";
  static const String reviewApp = "reviewApp";
  static const String madeWithLoveInBerlin = "madeWithLoveInBerlin";

  static const Map<String, dynamic> EN = {
    bottomNavItem1Titel: "Scan",
    bottomNavItem2Titel: "History",
    bottomNavItem3Titel: "Profile",
    scanResultInfo: "Your scanned products will be shown here",
    noAllergies: "No Allergens",
    historyTitle: "History",
    today: "Today",
    yesterday: "Yesterday",
    allergiesTitle: "Allegens",
    noAllergenesSelected: "No Allergenes selected",
    settingsTitle: "Settings",
    settingsAppearance: "Appearance",
    settingsLanguage: "Language",
    lightMode: "Light",
    darkMode: "Dark",
    systemMode: "System",
    moreLanguagesSoon: "More languages coming soon",
    safe: "Safe",
    contactUs: "Write Us",
    shareApp: "Share App",
    reviewApp: "Review App",
    madeWithLoveInBerlin: "Made with ❤️ in Berlin",
  };

  static const Map<String, dynamic> DE = {
    bottomNavItem1Titel: "Scan",
    bottomNavItem2Titel: "Verlauf",
    bottomNavItem3Titel: "Profil",
    scanResultInfo: "Hier werden deine gescannten Produkte angezeigt",
    noAllergies: "Keine Allergene",
    historyTitle: "Verlauf",
    today: "Heute",
    yesterday: "Gestern",
    allergiesTitle: "Allergene",
    noAllergenesSelected: "Keine Allergene vorhanden",
    settingsTitle: "Einstellungen",
    settingsAppearance: "Darstellung",
    settingsLanguage: "Sprache",
    lightMode: "Hell",
    darkMode: "Dunkel",
    systemMode: "System",
    moreLanguagesSoon: "Weitere Sprachen kommen bald",
    safe: "Speichern",
    contactUs: "Schreibe uns",
    shareApp: "App teilen",
    reviewApp: "App bewerten",
    madeWithLoveInBerlin: "Programmiert mit ❤️ in Berlin",
  };

  static const Map<String, dynamic> ES = {
    bottomNavItem1Titel: "Escanear",
    bottomNavItem2Titel: "Historia",
    bottomNavItem3Titel: "Perfil",
    scanResultInfo: "Sus productos escaneados se muestran aquí",
    noAllergies: "Sin alérgenos",
    historyTitle: "Historia",
    today: "Hoy",
    yesterday: "Ayer",
    allergiesTitle: "Alérgenos",
    noAllergenesSelected: "No se han seleccionado alérgenos",
    settingsTitle: "Ajustes",
    settingsAppearance: "Apariencia",
    settingsLanguage: "Idioma",
    lightMode: "Brillante",
    darkMode: "Oscura",
    systemMode: "Sistema",
    moreLanguagesSoon: "Próximamente más idiomas",
    safe: "Guardar",
    contactUs: "Escríbanos",
    shareApp: "Compartir la aplicación",
    reviewApp: "Valora la aplicación",
    madeWithLoveInBerlin: "Hecho con ❤️ en Berlin",
  };

  static const Map<String, dynamic> FR = {
    bottomNavItem1Titel: "Scanner",
    bottomNavItem2Titel: "Histoire",
    bottomNavItem3Titel: "Profil",
    scanResultInfo: "Aucun alergène",
    historyTitle: "Histoire",
    today: "Aujourd'hui",
    yesterday: "Hier",
    allergiesTitle: "Alergène",
    noAllergenesSelected: "Aucun allergène sélectionné",
    settingsTitle: "Réglages",
    settingsAppearance: "Apparence",
    settingsLanguage: "Langue",
    lightMode: "Clair",
    darkMode: "Sombre",
    systemMode: "Système",
    moreLanguagesSoon: "D'autres langues seront bientôt disponibles",
    safe: "Sauvegarder",
    contactUs: "Écrivez-nous",
    shareApp: "Partage l'app",
    reviewApp: "Évaluer l'app",
    madeWithLoveInBerlin: "Fait avec ❤️ à Berlin",
  };
}
