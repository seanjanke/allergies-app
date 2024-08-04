import 'package:allergies/presentation/views/allergies/allergies_screen.dart';
import 'package:allergies/presentation/views/history/history_screen.dart';
import 'package:allergies/presentation/main_screen.dart';
import 'package:allergies/presentation/views/scanner/scanner_screen.dart';
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
    },
  ).call,
);
