import 'package:allergies/core/locales.dart';
import 'package:allergies/core/theme/theme.dart';
import 'package:allergies/data/controller/food_controller.dart';
import 'package:allergies/presentation/views/settings/components/settings_list_tile.dart';
import 'package:allergies/presentation/views/settings/settings_screen.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class AllergiesScreen extends StatefulWidget {
  static const routeName = 'allergies';
  const AllergiesScreen({super.key});

  @override
  State<AllergiesScreen> createState() => _AllergiesScreenState();
}

class _AllergiesScreenState extends State<AllergiesScreen> {
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  LocaleData.allergiesTitle.getString(context),
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                GestureDetector(
                  onTap: () {
                    Beamer.of(context).beamToNamed(SettingsScreen.routeName);
                  },
                  child: const FaIcon(FontAwesomeIcons.gear),
                ),
              ],
            ),
            largeGap,
            Flexible(
              child: Obx(
                () => ListView.builder(
                  shrinkWrap: true,
                  itemCount: foodController.allergiesList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: largePadding,
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: mediumCirular,
                        ),
                        child: Text(
                          foodController.allergiesList[index].name(context),
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Obx(
              () => Visibility(
                visible: foodController.allergiesList.isEmpty,
                child: ContainerListTile(
                  title: LocaleData.add.getString(context),
                  color: primary.withOpacity(0.6),
                  onTap: () {
                    //TODO: implement this
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
