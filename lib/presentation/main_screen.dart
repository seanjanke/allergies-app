import 'package:allergies/core/theme/color_palette.dart';
import 'package:allergies/core/theme/scaling_system.dart';
import 'package:allergies/data/models/bottom_nav_item.dart';
import 'package:allergies/presentation/views/allergies/allergies_screen.dart';
import 'package:allergies/presentation/views/scanner/scanner_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:rive/rive.dart';

class MainScreen extends StatefulWidget {
  static const routeName = '/';
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  List<SMIBool> riveIconInputs = [];

  void animateIcon(int index) {
    bool currentValue = riveIconInputs[index].value;

    if (currentValue == false) {
      riveIconInputs[index].change(true);
      if (index == 0) {
        riveIconInputs[1].change(false);
        Future.delayed(const Duration(milliseconds: 2650), () {
          riveIconInputs[index].change(false);
        });
      }
    } else {
      riveIconInputs[index].change(false);
    }
  }

  void onInit(Artboard artboard) {
    StateMachineController? controller =
        StateMachineController.fromArtboard(artboard, "State Machine 1");

    artboard.addController(controller!);

    riveIconInputs.add(controller.findInput<bool>('Active') as SMIBool);

    for (SMIBool icon in riveIconInputs) {
      icon.change(false);
    }
  }

  static const List screens = [
    ScannerScreen(),
    //HistoryScreen(),
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
          bottom: 48,
          top: 20,
          left: 20,
          right: 20,
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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            bottomNavItems.length,
            (index) {
              final riveIcon = bottomNavItems[index].rive;
              return GestureDetector(
                onTap: () {
                  onItemTapped(index);
                  animateIcon(index);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
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
                    const Gap(6),
                    Text(
                      bottomNavItems[index].title,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: black),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
