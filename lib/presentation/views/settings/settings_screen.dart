import 'package:allergies/core/about.dart';
import 'package:allergies/core/theme/scaling_system.dart';
import 'package:allergies/data/controller/theme_controller.dart';
import 'package:allergies/presentation/views/settings/components/settings_list_tile.dart';
import 'package:allergies/presentation/views/settings/pages/settings_language_screen.dart';
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SettingsListTile(
              title: "Darstellung",
              onTap: () {
                themeController.switchThroughThemes();
              },
              trailing: Obx(
                () => Text(
                  themeController.themeMode.value.name.tr.capitalize!,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ),
            SettingsListTile(
              title: "Sprache",
              onTap: () {
                Beamer.of(context)
                    .beamToNamed(SettingsLanguageScreen.routeName);
              },
              trailing: const Icon(Icons.chevron_right),
            ),
            SettingsListTile(
              title: "Schreib uns",
              onTap: () {},
            ),
            SettingsListTile(
              title: "App teilen",
              onTap: () {},
            ),
            SettingsListTile(
              title: "App bewerten",
              onTap: () {},
            ),
            const Spacer(),
            const Text("Made with ❤️ in Berlin"),
            extraSmallGap,
            Text(
              "Version $version",
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
