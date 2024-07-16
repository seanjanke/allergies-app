import 'package:allergies/core/theme/theme.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  static const routeName = 'history';
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: safeArea,
        child: Center(
          child: Text("History"),
        ),
      ),
    );
  }
}
