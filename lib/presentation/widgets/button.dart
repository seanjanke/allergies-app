import 'package:flutter/material.dart';

import '../../core/theme/theme.dart';

class Button extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onTap;

  const Button({
    required this.label,
    required this.color,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color,
            borderRadius: smallCirular,
          ),
          child: Center(
            child: Text(
              label,
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: white,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
