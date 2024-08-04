import 'package:allergies/core/theme/theme.dart';
import 'package:allergies/data/controller/food_controller.dart';
import 'package:allergies/data/models/allergy.dart';
import 'package:allergies/presentation/views/settings/settings_screen.dart';
import 'package:allergies/presentation/widgets/allergies_list_tile.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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
  List<Allergies> selectedAllergies = [];
  bool showWrap = false;

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
                  "Allergien",
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
            mediumGap,
            GestureDetector(
              onTap: () {
                setState(() {
                  showWrap = !showWrap;
                });

                for (Allergy allergyItem in foodController.allergiesList) {
                  selectedAllergies.add(allergyItem.allergy);
                }
              },
              child: Container(
                padding: smallPadding,
                decoration: BoxDecoration(
                  color: primary,
                  borderRadius: smallCirular,
                ),
                child: Icon(
                  showWrap == false ? Icons.add : Icons.check,
                  color: white,
                  size: 20,
                ),
              ),
            ),
            Expanded(
              child: Obx(
                () {
                  if (showWrap == true) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          direction: Axis.horizontal,
                          alignment: WrapAlignment.start,
                          runAlignment: WrapAlignment.start,
                          spacing: 12,
                          runSpacing: 12,
                          children: Allergies.values.map(
                            (item) {
                              bool isSelected =
                                  selectedAllergies.contains(item);
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (isSelected) {
                                      selectedAllergies.remove(item);
                                      foodController.removeAllergy(
                                          Allergy(allergy: item));
                                      foodController.getAllergies();
                                    } else {
                                      selectedAllergies.add(item);
                                      foodController
                                          .addAllergy(Allergy(allergy: item));
                                      foodController.getAllergies();
                                    }
                                  });
                                },
                                child: Container(
                                  padding: mediumPadding,
                                  decoration: BoxDecoration(
                                    color: isSelected ? primary300 : neutral100,
                                    borderRadius: largeCirular,
                                  ),
                                  child: Text(
                                    item.name.capitalize!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
                                  ),
                                ),
                              );
                            },
                          ).toList(),
                        ),
                        mediumGap,
                        const Divider(
                          color: neutral100,
                          thickness: 2,
                        ),
                        mediumGap,
                        foodController.allergiesList.isEmpty
                            ? Expanded(
                                child: Center(
                                  child: Text(
                                    "Keine Allergien vorhanden",
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ),
                              )
                            : Expanded(
                                child: ListView.builder(
                                  itemCount:
                                      foodController.allergiesList.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: const EdgeInsets.only(bottom: 12),
                                      height: 80,
                                      child: Slidable(
                                        direction: Axis.horizontal,
                                        endActionPane: ActionPane(
                                          motion: const ScrollMotion(),
                                          extentRatio: 0.4,
                                          children: [
                                            SlidableAction(
                                              onPressed: (context) {
                                                foodController.removeAllergy(
                                                    foodController
                                                        .allergiesList[index]);
                                              },
                                              backgroundColor: warning100,
                                              foregroundColor: warning500,
                                              icon: Icons.delete,
                                              borderRadius: smallCirular,
                                            )
                                          ],
                                        ),
                                        child: AllergiesListTile(
                                          name: foodController
                                              .allergiesList[index].name,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                      ],
                    );
                  } else {
                    if (foodController.allergiesList.isEmpty) {
                      return Center(
                        child: Text(
                          "Keine Allergien vorhanden",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: foodController.allergiesList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            height: 80,
                            child: Slidable(
                              direction: Axis.horizontal,
                              endActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                extentRatio: 0.4,
                                children: [
                                  SlidableAction(
                                    onPressed: (context) {
                                      foodController.removeAllergy(
                                          foodController.allergiesList[index]);
                                    },
                                    backgroundColor: warning100,
                                    foregroundColor: warning500,
                                    icon: Icons.delete,
                                    borderRadius: smallCirular,
                                  )
                                ],
                              ),
                              child: AllergiesListTile(
                                name: foodController.allergiesList[index].name,
                              ),
                            ),
                          );
                        },
                      );
                    }
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
