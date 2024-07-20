import 'package:allergies/core/theme/theme.dart';
import 'package:allergies/data/controller/food_controller.dart';
import 'package:allergies/data/models/food.dart';
import 'package:allergies/presentation/widgets/food_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';
import 'package:intl/intl.dart';

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
              child: Obx(
                () {
                  if (foodController.foodsList.isEmpty) {
                    return Center(
                      child: Text(
                        'Keine Scans vorhanden',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    );
                  } else {
                    return StickyGroupedListView<Food, DateTime>(
                      elements: foodController.foodsList.value,
                      order: StickyGroupedListOrder.DESC,
                      groupBy: (Food food) => DateTime(
                        food.uploadTime!.year,
                        food.uploadTime!.month,
                        food.uploadTime!.day,
                      ),
                      stickyHeaderBackgroundColor: background,
                      groupSeparatorBuilder: (Food food) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          (() {
                            DateTime now = DateTime.now();
                            DateTime uploadDate = DateTime(
                              food.uploadTime!.year,
                              food.uploadTime!.month,
                              food.uploadTime!.day,
                            );

                            if (uploadDate ==
                                DateTime(now.year, now.month, now.day)) {
                              return "Heute";
                            } else if (uploadDate ==
                                DateTime(now.year, now.month, now.day - 1)) {
                              return "Gestern";
                            } else {
                              return DateFormat('dd.MM.yyyy')
                                  .format(food.uploadTime!);
                            }
                          })(),
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(color: neutral300),
                        ),
                      ),
                      itemBuilder: (context, Food food) {
                        bool hasAllergies = food.allergens.any((allergy) {
                          return foodController.allergiesList.any(
                              (controllerAllergy) =>
                                  controllerAllergy.name == allergy);
                        });

                        List<String> commonAllergens =
                            food.allergens.where((allergy) {
                          return foodController.allergiesList.any(
                              (controllerAllergy) =>
                                  controllerAllergy.name.toLowerCase() ==
                                  allergy.toLowerCase());
                        }).toList();

                        return FoodListTile(
                          name: food.name.value,
                          allergenes: commonAllergens,
                          hasAllergies: hasAllergies,
                        );
                      },
                    );
                  }
                },
              ),
            ),
            /*return ListView.builder(
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
                        if (foodController.foodsList[index].uploadTime !=
                            null) {
                          print(
                              "uploadTime: ${foodController.foodsList[index].uploadTime}");
                        } else {
                          print("uploadtime is null");
                        }
                        return FoodListTile(
                          name: foodController.foodsList[index].name.value,
                          allergenes: commonAllergens,
                          hasAllergies: hasAllergies,
                        );
                      },
                    );*/
          ],
        ),
      ),
    );
  }
}
