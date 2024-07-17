import 'package:allergies/core/theme/theme.dart';
import 'package:flutter/material.dart';

class AllergiesListTile extends StatelessWidget {
  final String name;
  const AllergiesListTile({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20),
      width: double.infinity,
      height: 80,
      decoration: BoxDecoration(
        color: neutral100,
        borderRadius: smallCirular,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
