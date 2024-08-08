import 'package:allergies/core/locales.dart';
import 'package:allergies/core/theme/theme.dart';
import 'package:allergies/data/controller/food_controller.dart';
import 'package:allergies/data/models/allergy.dart';
import 'package:allergies/presentation/views/allergies/components/allergies_list_tile.dart';
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
  TextEditingController searchController = TextEditingController();

  List<Allergy> allergies = allAllergies;

  void searchAllergene(String searchTerm) {
    final suggestions = allAllergies.where((allergy) {
      final localizedAllergyName = allergy.name(context).toLowerCase();
      return localizedAllergyName.contains(searchTerm.toLowerCase());
    }).toList();

    setState(() {
      allergies = suggestions;
    });
  }

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
            extraLargeGap,
            TextFormField(
              controller: searchController,
              style: Theme.of(context).textTheme.bodyLarge,
              cursorColor: Theme.of(context).colorScheme.onSurface,
              textCapitalization: TextCapitalization.sentences,
              autofocus: false,
              decoration: InputDecoration(
                filled: true,
                fillColor: Theme.of(context).colorScheme.surface,
                contentPadding: mediumPadding,
                isDense: true,
                hintText: LocaleData.search.getString(context),
                hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: mediumCirular,
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.onTertiary,
                    width: 2,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: mediumCirular,
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.onTertiary,
                    width: 2,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: mediumCirular,
                ),
              ),
              onTapOutside: (event) {
                FocusManager.instance.primaryFocus!.unfocus();
              },
              onChanged: searchAllergene,
            ),
            extraLargeGap,
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: allergies.length,
                itemBuilder: (context, index) {
                  return Obx(() {
                    bool isActive = false;

                    for (Allergy item in foodController.allergiesList) {
                      if (item.allergeneType ==
                          allergies[index].allergeneType) {
                        isActive = true;
                      }
                    }

                    return AllergiesListTile(
                      allergy: allergies[index],
                      isActive: isActive,
                    );
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
