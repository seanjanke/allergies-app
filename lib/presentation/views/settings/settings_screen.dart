import 'package:allergies/core/theme/theme.dart';
import 'package:allergies/data/controller/theme_controller.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatelessWidget {
  static const routeName = "/settings";
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeController themeController = Get.find();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Beamer.of(context).beamBack();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text("Einstellungen"),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                themeController.switchThroughThemes();
              },
              child: Container(
                width: double.infinity,
                padding: mediumPadding,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: smallCirular,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Darstellung",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Obx(
                      () => Text(
                        themeController.themeMode.value.name.tr.capitalize!,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
