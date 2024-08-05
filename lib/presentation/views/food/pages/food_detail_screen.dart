import 'package:allergies/core/theme/theme.dart';
import 'package:allergies/data/controller/food_controller.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FoodDetailScreen extends StatelessWidget {
  static const routeName = "foodDetail";

  const FoodDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    FoodController controller = Get.find();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Beamer.of(context).beamBack();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(controller.selectedFood.value.name.value.capitalize!),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
              () => Text(
                controller.selectedFood.value.name.value.capitalize!,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            largeGap,
            Flexible(
              child: Obx(
                () => controller.selectedFood.value.allergens.isEmpty
                    ? const Center(
                        child: Text("Keine Allergene gefunden"),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount:
                            controller.selectedFood.value.allergens.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: mediumPadding,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surface,
                              borderRadius: mediumCirular,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding: smallPadding,
                                  decoration: BoxDecoration(
                                    color: warning100,
                                    borderRadius: smallCirular,
                                  ),
                                  child: const Icon(
                                    Icons.warning,
                                    color: warning500,
                                  ),
                                ),
                                mediumGap,
                                Text(
                                  controller.selectedFood.value.allergens[index]
                                      .capitalize!,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
            ),
            largeGap,
            Obx(
              () => Text(
                controller.selectedFood.value.ingredients,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
