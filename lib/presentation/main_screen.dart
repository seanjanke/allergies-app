import 'package:allergies/core/theme/color_palette.dart';
import 'package:allergies/core/theme/scaling_system.dart';
import 'package:allergies/presentation/views/history/history_screen.dart';
import 'package:allergies/presentation/views/allergies/allergies_screen.dart';
import 'package:allergies/presentation/views/scanner/scanner_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class MainScreen extends StatefulWidget {
  static const routeName = '/';
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  /*int selectedIndex = 0;

  List<SMIBool> riveIconInputs = [];
  List<SMIBool> doneInputs = [];

  void animateIcon(int index) {
    bool currentValue = riveIconInputs[index].value;

    if (index == 0) {
      if (currentValue == false) {
        doneInputs.first.change(false);
        riveIconInputs[index].change(true);
        Future.delayed(const Duration(milliseconds: 2650), () {
          riveIconInputs[index].change(false);
        });
      }
    } else {
      doneInputs.first.change(true);
    }

    // if (currentValue == false) {
    //   riveIconInputs[index].change(true);
    //   if (index == 0) {
    //     riveIconInputs[2].change(false);
    //     Future.delayed(const Duration(milliseconds: 2650), () {
    //       riveIconInputs[index].change(false);
    //     });
    //   }
    // } else {
    //   riveIconInputs[index].change(false);
    // }
  }

  void onInit(Artboard artboard) {
    StateMachineController? controller =
        StateMachineController.fromArtboard(artboard, "State Machine 1");

    artboard.addController(controller!);

    riveIconInputs.add(controller.findInput<bool>('Active') as SMIBool);

    if (artboard.name == "Scan") {
      doneInputs.add(controller.findInput<bool>('Done') as SMIBool);
      doneInputs.first.change(false);
    }

    for (SMIBool icon in riveIconInputs) {
      icon.change(false);
    }
  }

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
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(
          bottom: 24,
          top: 8,
        ),
        decoration: BoxDecoration(
          color: white,
          borderRadius: smallCirular,
          border: const Border.fromBorderSide(
            BorderSide(
              color: neutral100,
              width: 1,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            bottomNavItems.length,
            (index) {
              final riveIcon = bottomNavItems[index].rive;
              return Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    onItemTapped(index);
                    //animateIcon(index);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 30,
                        width: 30,
                        child: RiveAnimation.asset(
                          riveIcon.src,
                          artboard: riveIcon.artboard,
                          onInit: onInit,
                        ),
                      ),
                      Text(
                        bottomNavItems[index].title,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: selectedIndex == index ? black : neutral300),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }*/

  int selectedIndex = 0;
  String batteryLevel = "";

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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: screens.elementAt(selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: onItemTapped,
        items: const [
          BottomNavigationBarItem(
            label: "Scan",
            icon: Icon(Icons.qr_code),
          ),
          BottomNavigationBarItem(
            label: "History",
            icon: Icon(Icons.history),
          ),
          BottomNavigationBarItem(
            label: "Profile",
            icon: Icon(Icons.person_outline),
          ),
        ],
      ),
    );
  }
}
