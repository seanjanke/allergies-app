import 'package:allergies/core/theme/theme.dart';
import 'package:flutter/material.dart';

class FoodListTile extends StatelessWidget {
  final String name;
  final List<String> allergenes;
  const FoodListTile({super.key, required this.name, required this.allergenes});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: largePadding,
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
                  name,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                smallGap,
                ...(allergenes.map((allergy) => Text(allergy)).toList()),
              ],
            ),
          ),
          Container(
            padding: smallPadding,
            decoration: BoxDecoration(
              color: allergenes.isEmpty ? success500 : warning500,
              borderRadius: smallCirular,
            ),
            child: Text(
              allergenes.isEmpty ? "👍" : "👎",
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
        ],
      ),
    );
  }
}
