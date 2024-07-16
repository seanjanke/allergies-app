import 'package:flutter/material.dart';

class AllergiesScreen extends StatelessWidget {
  static const routeName = 'allergies';
  const AllergiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Allergies"),
      ),
    );
  }
}
