import 'package:allergies/core/theme/color_palette.dart';
import 'package:allergies/presentation/views/allergies/allergies_screen.dart';
import 'package:allergies/presentation/views/history/history_screen.dart';
import 'package:allergies/presentation/views/scanner/scanner_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainScreen extends StatefulWidget {
  static const routeName = '/';
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  static const List screens = [
    ScannerScreen(),
    HistoryScreen(),
    AllergiesScreen(),
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: screens.elementAt(selectedIndex),
      ),
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          backgroundColor: white,
          selectedItemColor: primary,
          unselectedItemColor: neutral400,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedLabelStyle: GoogleFonts.lexend(fontSize: 14),
          unselectedLabelStyle: GoogleFonts.lexend(fontSize: 14),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.qr_code),
              label: 'Scanner',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'Verlauf',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.back_hand_outlined),
              label: 'Allergien',
            ),
          ],
          currentIndex: selectedIndex,
          onTap: onItemTapped,
        ),
      ),
    );
  }
}
