import 'package:allergies/core/theme/theme.dart';
import 'package:flutter/material.dart';

class AllergiesScreen extends StatelessWidget {
  static const routeName = 'allergies';
  const AllergiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: safeArea,
        child: Center(
          child: Text("Allergies"),
        ),
      ),
    );
  }
}
