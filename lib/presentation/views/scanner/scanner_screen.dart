import 'package:allergies/data/controller/food_controller.dart';
import 'package:allergies/data/models/bottom_nav_item.dart';
import 'package:allergies/presentation/widgets/button.dart';
import 'package:allergies/presentation/widgets/food_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

import '../../../core/theme/theme.dart';

class ScannerScreen extends StatefulWidget {
  static const routeName = 'scanner';
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  FoodController foodController = Get.put(FoodController());
  List<SMIBool> riveIconInputs = [];

  void animateIcon(int index) {
    print('start anim');
    riveIconInputs[index].change(true);
    Future.delayed(const Duration(milliseconds: 2650), () {
      print('end anim');
      riveIconInputs[index].change(false);
    });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: safeArea,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Button(
                label: "Scan Food",
                color: primary,
                onTap: () async {
                  //foodController.addFoodFromBarcode("8076802085738");

                  //TODO: uncomment again

                  var res = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SimpleBarcodeScannerPage(
                        lineColor: "#ffffff",
                        cancelButtonText: "Abbrechen",
                        isShowFlashIcon: true,
                      ),
                    ),
                  );
                  setState(() {
                    if (res is String) {
                      foodController.addFoodFromBarcode(res);
                    }
                  });
                },
              ),
            ),
            largeGap,
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: foodController.foodsList.length,
                  itemBuilder: (context, index) {
                    return FoodListTile(
                      name: foodController.foodsList[index].name.value,
                      allergenes: foodController.foodsList[index].allergens,
                    );
                  },
                ),
              ),
            ),
            large2Gap,
            Container(
              height: 80,
              padding: mediumPadding,
              decoration: BoxDecoration(
                color: neutral100,
                borderRadius: smallCirular,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  bottomNavItems.length,
                  (index) {
                    final riveIcon = bottomNavItems[index].rive;
                    return GestureDetector(
                      onTap: () {
                        animateIcon(index);
                      },
                      child: SizedBox(
                        height: 40,
                        width: 40,
                        child: RiveAnimation.asset(
                          riveIcon.src,
                          artboard: riveIcon.artboard,
                          onInit: onInit,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
