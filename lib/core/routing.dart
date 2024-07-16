import 'package:allergies/view/allergies/allergies_screen.dart';
import 'package:allergies/view/history/history_screen.dart';
import 'package:allergies/view/main_screen.dart';
import 'package:allergies/view/scanner/scanner_screen.dart';
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
    },
  ).call,
);
