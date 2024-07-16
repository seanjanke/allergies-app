import 'package:flutter/material.dart';

class ScannerScreen extends StatelessWidget {
  static const routeName = 'scanner';
  const ScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Scanner"),
      ),
    );
  }
}
