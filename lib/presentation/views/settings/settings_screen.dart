import 'package:allergies/core/about.dart';
import 'package:allergies/core/locales.dart';
import 'package:allergies/core/theme/theme.dart';
import 'package:allergies/data/controller/general_controller.dart';
import 'package:allergies/data/controller/theme_controller.dart';
import 'package:allergies/presentation/views/settings/components/settings_list_tile.dart';
import 'package:allergies/presentation/views/settings/pages/settings_language_screen.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatelessWidget {
  static const routeName = "/settings";
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeController themeController = Get.find();
    GeneralController generalController = Get.find();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Beamer.of(context).beamBack();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(LocaleData.settingsTitle.getString(context)),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ContainerListTile(
              title: LocaleData.settingsAppearance.getString(context),
              onTap: () {
                themeController.switchThroughThemes();
              },
              trailing: Obx(() {
                var themeMode = "";
                if (themeController.themeMode.value.name == "light") {
                  themeMode = LocaleData.lightMode.getString(context);
                } else if (themeController.themeMode.value.name == "dark") {
                  themeMode = LocaleData.darkMode.getString(context);
                } else {
                  themeMode = LocaleData.systemMode.getString(context);
                }
                return Text(
                  themeMode,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                );
              }),
            ),
            ContainerListTile(
              title: LocaleData.settingsLanguage.getString(context),
              onTap: () {
                Beamer.of(context)
                    .beamToNamed(SettingsLanguageScreen.routeName);
              },
              trailing: Icon(
                Icons.chevron_right,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            ContainerListTile(
              title: "Haptisches Feedback",
              onTap: () {
                generalController.toggleHapticFeedback();
              },
              trailing: SizedBox(
                height: 20,
                child: Obx(
                  () => Switch(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    value: generalController.useHapticFeedback.value,
                    activeColor: primary,
                    inactiveThumbColor: neutral600,
                    inactiveTrackColor: neutral800,
                    activeTrackColor: primary.withOpacity(0.4),
                    onChanged: (bool newValue) {
                      generalController.toggleHapticFeedback();
                    },
                  ),
                ),
              ),
            ),
            ContainerListTile(
              title: LocaleData.contactUs.getString(context),
              onTap: () async {
                var url = Uri.parse("mailto:contact@jnk-studios.com");
                if (await canLaunchUrl(url)) {
                  await launchUrl(url);
                } else {
                  throw 'Could not launch $url';
                }
              },
            ),
            ContainerListTile(
              title: LocaleData.shareApp.getString(context),
              onTap: () {},
            ),
            ContainerListTile(
              title: LocaleData.reviewApp.getString(context),
              onTap: () {},
            ),
            const Spacer(),
            Text(LocaleData.madeWithLoveInBerlin.getString(context)),
            extraSmallGap,
            Text(
              "V $version",
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
