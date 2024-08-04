import 'package:flutter/material.dart';

import '../../../../core/theme/theme.dart';

class LanguageListTile extends StatefulWidget {
  final String title;
  final VoidCallback onTap;
  final VoidCallback onSelect;
  final bool isSelected;

  const LanguageListTile({
    super.key,
    required this.title,
    required this.onTap,
    required this.onSelect,
    required this.isSelected,
  });

  @override
  State<LanguageListTile> createState() => _LanguageListTileState();
}

class _LanguageListTileState extends State<LanguageListTile> {
  bool isTapped = false;

  void onItemTap() {
    widget.onSelect();
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onItemTap,
      onTapDown: (details) {
        setState(() {
          isTapped = true;
        });
      },
      onTapUp: (details) {
        setState(() {
          isTapped = false;
        });
      },
      onTapCancel: () {
        setState(() {
          isTapped = false;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        padding: isTapped ? const EdgeInsets.all(1) : EdgeInsets.zero,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          width: isTapped ? double.infinity - 2 : double.infinity,
          padding: isTapped
              ? mediumPadding - const EdgeInsets.symmetric(vertical: 1)
              : mediumPadding,
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: widget.isSelected
                ? primary.withOpacity(0.4)
                : Theme.of(context).colorScheme.surface,
            borderRadius: smallCirular,
            border: Border.all(
              color: widget.isSelected
                  ? primary
                  : Theme.of(context).colorScheme.surface,
              width: 2,
            ),
          ),
          child: Row(
            children: [
              Text(
                widget.title,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
