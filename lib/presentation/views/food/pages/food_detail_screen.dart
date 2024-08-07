import 'dart:developer';

import 'package:allergies/core/locales.dart';
import 'package:allergies/core/theme/theme.dart';
import 'package:allergies/data/controller/food_controller.dart';
import 'package:allergies/presentation/widgets/button.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
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
        title: Text(LocaleData.productInformation.getString(context)),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
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
                    Obx(
                      () => Text(
                        controller.selectedFood.value.brand.value.capitalize!,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    extraLargeGap,
                    Text(
                      LocaleData.allergenesAndTraces.getString(context),
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    mediumGap,
                    Obx(
                      () => controller.selectedFood.value.allergens.isEmpty
                          ? Container(
                              width: double.infinity,
                              margin: const EdgeInsets.only(bottom: 12),
                              padding: largePadding,
                              decoration: BoxDecoration(
                                color: success500.withOpacity(0.4),
                                borderRadius: mediumCirular,
                                border: Border.all(
                                  color: success500,
                                  width: 2,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "👍",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
                                  ),
                                  mediumGap,
                                  Expanded(
                                    child: Text(
                                      LocaleData.noAllergenesFound
                                          .getString(context),
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller
                                  .selectedFood.value.allergens.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: const EdgeInsets.only(bottom: 12),
                                  padding: largePadding,
                                  decoration: BoxDecoration(
                                    color: error500.withOpacity(0.4),
                                    borderRadius: mediumCirular,
                                    border: Border.all(
                                      width: 2,
                                      color: error500,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "👎",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall,
                                      ),
                                      mediumGap,
                                      Text(
                                        controller.selectedFood.value
                                            .allergens[index].capitalize!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                    ),
                    Obx(
                      () => controller.selectedFood.value.traces.isEmpty
                          ? Container(
                              width: double.infinity,
                              padding: largePadding,
                              decoration: BoxDecoration(
                                color: success500.withOpacity(0.4),
                                borderRadius: mediumCirular,
                                border: Border.all(
                                  color: success500,
                                  width: 2,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "👍",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
                                  ),
                                  mediumGap,
                                  Expanded(
                                    child: Text(
                                      LocaleData.noTracesFound
                                          .getString(context),
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount:
                                  controller.selectedFood.value.traces.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  padding: largePadding,
                                  margin: const EdgeInsets.only(bottom: 12),
                                  decoration: BoxDecoration(
                                    color: warning500.withOpacity(0.4),
                                    border:
                                        Border.all(color: warning500, width: 2),
                                    borderRadius: mediumCirular,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "⚠️",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall,
                                      ),
                                      mediumGap,
                                      Expanded(
                                        child: Text(
                                          controller.selectedFood.value
                                              .traces[index].capitalize!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                    ),
                    extraLargeGap,
                    Text(
                      LocaleData.ingredients.getString(context),
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    smallGap,
                    Obx(
                      () => Text(
                        controller.selectedFood.value.ingredients.isNotEmpty
                            ? controller.selectedFood.value.ingredients
                            : LocaleData.noIngredientsFound.getString(context),
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            largeGap,
            Button(
              label: LocaleData.close.getString(context),
              color: primary,
              onTap: () {
                Beamer.of(context).beamBack();
              },
            ),
          ],
        ),
      ),
    );
  }
}
