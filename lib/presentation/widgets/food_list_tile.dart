import 'package:allergies/core/locales.dart';
import 'package:allergies/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:get/get.dart';

class FoodListTile extends StatelessWidget {
  final String name;
  final bool hasAllergies;
  final List<String> allergenes;
  const FoodListTile(
      {super.key,
      required this.name,
      required this.allergenes,
      required this.hasAllergies});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: largePadding,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
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
                  name.capitalize!,
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
                extraSmallGap,
                if (allergenes.isNotEmpty) ...[
                  Text(
                    allergenes
                        .map((allergen) => allergen.capitalize!)
                        .join(', '),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ] else ...[
                  Text(
                    LocaleData.noAllergies.getString(context),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                ],
              ],
            ),
          ),
          mediumGap,
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: allergenes.isEmpty
                  ? success500.withOpacity(0.6)
                  : error500.withOpacity(0.8),
              borderRadius: smallCirular,
            ),
            child: Center(
              child: Text(
                allergenes.isEmpty ? "👍" : "👎",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
