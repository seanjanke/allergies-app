import 'package:allergies/data/controller/food_controller.dart';
import 'package:allergies/data/models/allergy.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/theme/theme.dart';

class AllergiesListTile extends StatefulWidget {
  final Allergy allergy;
  final bool isActive;

  const AllergiesListTile({
    super.key,
    required this.allergy,
    required this.isActive,
  });

  @override
  State<AllergiesListTile> createState() => _AllergiesListTileState();
}

class _AllergiesListTileState extends State<AllergiesListTile> {
  FoodController foodController = Get.find();
  bool isActive = false;

  void getIsActive() {
    setState(() {
      isActive = widget.isActive;
    });
  }

  @override
  void initState() {
    getIsActive();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isActive) {
          foodController.removeAllergy(widget.allergy);
          setState(() {
            isActive = false;
          });
        } else {
          foodController.addAllergy(widget.allergy);
          setState(() {
            isActive = true;
          });
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
            color: isActive ? primary : Theme.of(context).colorScheme.surface,
            width: 2,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: mediumCirular,
                    child: Image.asset(
                      widget.allergy.imagePath!,
                      width: 80,
                    ),
                  ),
                  mediumGap,
                  Expanded(
                    child: Text(
                      widget.allergy.name(context),
                      style: Theme.of(context).textTheme.bodyLarge,
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
  }
}
