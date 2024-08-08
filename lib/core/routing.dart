import 'package:allergies/presentation/views/allergies/allergies_screen.dart';
import 'package:allergies/presentation/views/food/pages/food_detail_screen.dart';
import 'package:allergies/presentation/views/history/history_screen.dart';
import 'package:allergies/presentation/main_screen.dart';
import 'package:allergies/presentation/views/scanner/pages/scanner_screen.dart';
import 'package:allergies/presentation/views/settings/pages/settings_language_screen.dart';
import 'package:allergies/presentation/views/settings/settings_screen.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

final routerDelegate = BeamerDelegate(
  locationBuilder: RoutesLocationBuilder(
    routes: {
      MainScreen.routeName: (context, state, data) => const BeamPage(
            key: ValueKey(''),
            title: 'Allergien App',
            child: MainScreen(),
          ),
      HistoryScreen.routeName: (context, state, data) => const BeamPage(
            key: ValueKey('history'),
            title: 'Verlauf',
            child: HistoryScreen(),
          ),
      AllergiesScreen.routeName: (context, state, data) => const BeamPage(
            key: ValueKey('allergies'),
            title: 'Allergien',
            child: AllergiesScreen(),
          ),
      ScannerScreen.routeName: (context, state, data) => const BeamPage(
            key: ValueKey('scanner'),
            title: 'Scanner',
            child: ScannerScreen(),
          ),
      SettingsScreen.routeName: (context, state, data) => const BeamPage(
            key: ValueKey('settings'),
            title: 'Einstellungen',
            child: SettingsScreen(),
          ),
      SettingsLanguageScreen.routeName: (context, state, data) =>
          const BeamPage(
            key: ValueKey('settingsLanguage'),
            title: 'Sprache',
            child: SettingsLanguageScreen(),
          ),
      FoodDetailScreen.routeName: (context, state, data) => const BeamPage(
            key: ValueKey('foodDetail'),
            title: 'Lebensmittel',
            child: FoodDetailScreen(),
          )
    },
  ).call,
);
