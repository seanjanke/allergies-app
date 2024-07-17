import 'package:allergies/data/controller/food_controller.dart';
import 'package:allergies/data/models/food.dart';
import 'package:allergies/presentation/widgets/button.dart';
import 'package:allergies/presentation/widgets/food_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
            large2Gap,
            IconButton(
              onPressed: () {
                try {
                  foodController.addFood(Food(
                    name: RxString("Banane"),
                    allergens: [
                      'Wheat',
                      'Soy',
                    ],
                  ));
                } catch (e) {
                  print(e.toString());
                }
              },
              icon: Icon(Icons.abc),
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
          ],
        ),
      ),
    );
  }
}
