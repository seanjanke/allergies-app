import 'package:allergies/core/locales.dart';
import 'package:allergies/core/theme/theme.dart';
import 'package:allergies/data/controller/food_controller.dart';
import 'package:allergies/data/models/allergy.dart';
import 'package:allergies/presentation/views/settings/components/settings_list_tile.dart';
import 'package:allergies/presentation/views/settings/settings_screen.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
    /*
    final suggestions = allAllergies
        .where(
          (allergene) =>
              allergene.allergeneType.name.contains(searchTerm.toLowerCase()),
        )
        .toList();
        

    setState(() {
      allergies = suggestions;
    });
    */
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
            largeGap,
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
            largeGap,
            Flexible(
              child: allergies.isEmpty
                  ? Center(
                      child: Text(
                        LocaleData.noAllergenesFound.getString(context),
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  : ListView.builder(
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

                          return GestureDetector(
                            onTap: () {
                              if (isActive) {
                                foodController.removeAllergy(allergies[index]);
                              } else {
                                foodController.addAllergy(allergies[index]);
                              }
                            },
                            child: Container(
                              padding: smallPadding,
                              margin: const EdgeInsets.only(bottom: 12),
                              decoration: BoxDecoration(
                                color: isActive
                                    ? primary.withOpacity(0.4)
                                    : Theme.of(context).colorScheme.surface,
                                borderRadius: mediumCirular,
                                border: Border.all(
                                  color: isActive
                                      ? primary
                                      : Theme.of(context).colorScheme.surface,
                                  width: 2,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        ClipRRect(
                                          borderRadius: mediumCirular,
                                          child: Image.asset(
                                            allergies[index].imagePath!,
                                            width: 80,
                                          ),
                                        ),
                                        mediumGap,
                                        Expanded(
                                          child: Text(
                                            allergies[index].name(context),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Visibility(
                                    visible: isActive,
                                    child: const Padding(
                                      padding: EdgeInsets.only(
                                        left: 16,
                                        right: 8,
                                      ),
                                      child: Icon(
                                        Icons.check_circle,
                                        color: primary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                      },
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
