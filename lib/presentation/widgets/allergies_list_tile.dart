import 'package:allergies/core/theme/theme.dart';
import 'package:flutter/material.dart';

class AllergiesListTile extends StatelessWidget {
  final String name;
  const AllergiesListTile({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: largePadding,
      decoration: BoxDecoration(
        color: neutral100,
        borderRadius: smallCirular,
      ),
      child: Text(
        name,
        style: Theme.of(context).textTheme.headlineSmall,
      ),
    );
  }
}
