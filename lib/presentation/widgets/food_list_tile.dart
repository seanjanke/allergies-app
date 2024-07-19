import 'package:allergies/core/theme/theme.dart';
import 'package:allergies/data/controller/food_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FoodListTile extends StatefulWidget {
  final String name;
  final bool hasAllergies;
  final List<String> allergenes;
  const FoodListTile(
      {super.key,
      required this.name,
      required this.allergenes,
      required this.hasAllergies});

  @override
  State<FoodListTile> createState() => _FoodListTileState();
}

class _FoodListTileState extends State<FoodListTile> {
  FoodController foodController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: mediumPadding,
      decoration: BoxDecoration(
        color: neutral100,
        borderRadius: smallCirular,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name.capitalize!,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                smallGap,
                if (widget.allergenes.isNotEmpty) ...[
                  Row(
                    children: [
                      for (var i = 0; i < widget.allergenes.length; i++)
                        Text(
                          i < widget.allergenes.length - 1
                              ? "${widget.allergenes[i].capitalize!}, "
                              : widget.allergenes[i].capitalize!,
                        ),
                    ],
                  ),
                ] else ...[
                  Text(
                    "Keine Allergene",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ],
            ),
          ),
          Container(
            padding: smallPadding,
            decoration: BoxDecoration(
              color: widget.allergenes.isEmpty ? success500 : warning500,
              borderRadius: smallCirular,
            ),
            child: Text(
              widget.allergenes.isEmpty ? "👍" : "👎",
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
        ],
      ),
    );
  }
}
