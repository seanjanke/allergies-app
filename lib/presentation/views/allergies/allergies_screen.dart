import 'package:allergies/core/theme/theme.dart';
import 'package:allergies/data/controller/food_controller.dart';
import 'package:allergies/data/models/allergy.dart';
import 'package:allergies/presentation/widgets/allergies_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

class AllergiesScreen extends StatefulWidget {
  static const routeName = 'allergies';
  const AllergiesScreen({super.key});

  @override
  State<AllergiesScreen> createState() => _AllergiesScreenState();
}

class _AllergiesScreenState extends State<AllergiesScreen> {
  FoodController foodController = Get.find();

  void test() {
    print('pressed');
  }

  @override
  void initState() {
    foodController.getAllergies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: safeArea,
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
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                GestureDetector(
                  onTap: () {
                    foodController.addAllergy(
                      const Allergy(allergy: Allergies.lactose),
                    );
                    foodController.getAllergies();
                  },
                  child: Container(
                    padding: smallPadding,
                    decoration: BoxDecoration(
                      color: primary,
                      borderRadius: smallCirular,
                    ),
                    child: const Icon(
                      Icons.add,
                      color: white,
                    ),
                  ),
                ),
              ],
            ),
            largeGap,
            Expanded(
              child: Obx(
                () => ListView.builder(
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
