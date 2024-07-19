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
  void initState() {
    //foodController.getFoods();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.only(
          top: 20,
          left: 20,
          right: 20,
        ),
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
              child: FutureBuilder(
                future: foodController.getFoods(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Obx(() {
                      if (foodController.foodsList.isEmpty) {
                        return Center(
                          child: Text(
                            'Keine Scans vorhanden',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        );
                      } else {
                        return Obx(() {
                          print(foodController.foodsList.length);
                          return ListView.builder(
                            itemCount: foodController.foodsList.length,
                            itemBuilder: (context, index) {
                              bool hasAllergies = foodController
                                  .foodsList[index].allergens
                                  .any((allergy) {
                                return foodController.allergiesList.any(
                                    (controllerAllergy) =>
                                        controllerAllergy.name == allergy);
                              });

                              List<String> commonAllergens = foodController
                                  .foodsList[index].allergens
                                  .where((allergy) {
                                return foodController.allergiesList.any(
                                    (controllerAllergy) =>
                                        controllerAllergy.name.toLowerCase() ==
                                        allergy.toLowerCase());
                              }).toList();
                              return FoodListTile(
                                name:
                                    foodController.foodsList[index].name.value,
                                allergenes: commonAllergens,
                                hasAllergies: hasAllergies,
                              );
                            },
                          );
                        });
                      }
                    });
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
