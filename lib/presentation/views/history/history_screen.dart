import 'package:allergies/core/theme/theme.dart';
import 'package:allergies/data/controller/food_controller.dart';
import 'package:allergies/presentation/widgets/food_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryScreen extends StatefulWidget {
  static const routeName = 'history';
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  FoodController foodController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: safeArea,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Verlauf",
              style: Theme.of(context).textTheme.displaySmall,
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
