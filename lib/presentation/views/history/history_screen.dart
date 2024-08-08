import 'package:allergies/core/locales.dart';
import 'package:allergies/core/theme/theme.dart';
import 'package:allergies/data/controller/food_controller.dart';
import 'package:allergies/data/models/food.dart';
import 'package:allergies/data/services/food_service.dart';
import 'package:allergies/presentation/views/food/pages/food_detail_screen.dart';
import 'package:allergies/presentation/widgets/food_list_tile.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localization/flutter_localization.dart';
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
        top: false,
        minimum: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                OpenFoodFactsApi.fetchAndPrintProduct("4337256771726", context)
                    .then((food) {
                  if (food != null) {
                    foodController.addFood(food);

                    List<String> commonAllergens =
                        food.allergens.where((allergy) {
                      return foodController.allergiesList.any(
                          (controllerAllergy) =>
                              controllerAllergy.name(context).toLowerCase() ==
                              allergy.toLowerCase());
                    }).toList();

                    foodController.selectedFood.value = Food(
                      name: food.name,
                      allergens: commonAllergens,
                      traces: food.traces,
                      ingredients: food.ingredients,
                    );
                  } else {
                    print('Food not found.');
                  }
                });
              },
              child: Text(
                LocaleData.historyTitle.getString(context),
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            mediumGap,
            Expanded(
              child: Obx(
                () {
                  if (foodController.foodsList.isEmpty) {
                    //TODO: show empty state image
                    return Center(
                      child: Text(
                        LocaleData.noScans.getString(context),
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant),
                        textAlign: TextAlign.center,
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
                      stickyHeaderBackgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      padding: EdgeInsets.zero,
                      groupSeparatorBuilder: (Food food) => Padding(
                        padding: smallPadding,
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
                              return LocaleData.today.getString(context);
                            } else if (uploadDate ==
                                DateTime(now.year, now.month, now.day - 1)) {
                              return LocaleData.yesterday.getString(context);
                            } else {
                              return DateFormat('dd.MM.yyyy')
                                  .format(food.uploadTime!);
                            }
                          })(),
                          style:
                              Theme.of(context).textTheme.labelMedium!.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant,
                                  ),
                        ),
                      ),
                      itemBuilder: (context, Food food) {
                        bool hasAllergies = food.allergens.any((allergy) {
                          return foodController.allergiesList.any(
                              (controllerAllergy) =>
                                  controllerAllergy.name.toString() == allergy);
                        });

                        List<String> commonAllergens =
                            food.allergens.where((allergy) {
                          return foodController.allergiesList.any(
                              (controllerAllergy) =>
                                  controllerAllergy
                                      .name(context)
                                      .toLowerCase() ==
                                  allergy.toLowerCase());
                        }).toList();

                        final String name = food.name.value.isNotEmpty
                            ? food.name.value
                            : LocaleData.unknown.getString(context);

                        return GestureDetector(
                          onTap: () {
                            foodController.selectedFood.value = Food(
                              name: food.name,
                              allergens: commonAllergens,
                              traces: food.traces,
                              ingredients: food.ingredients,
                            );

                            Beamer.of(context)
                                .beamToNamed(FoodDetailScreen.routeName);
                          },
                          child: FoodListTile(
                            name: name,
                            allergenes: commonAllergens,
                            hasAllergies: hasAllergies,
                          ),
                        );
                      },
                    );
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
