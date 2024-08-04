import 'package:flutter/material.dart';

import '../../../../core/theme/theme.dart';

class SettingsListTile extends StatefulWidget {
  final String title;
  final VoidCallback onTap;
  final Widget? trailing;

  const SettingsListTile({
    super.key,
    required this.title,
    required this.onTap,
    this.trailing,
  });

  @override
  State<SettingsListTile> createState() => _SettingsListTileState();
}

class _SettingsListTileState extends State<SettingsListTile> {
  bool isTapped = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
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
            color: Theme.of(context).colorScheme.surface,
            borderRadius: smallCirular,
          ),
          child: widget.trailing != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.title,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    widget.trailing!
                  ],
                )
              : Center(
                  child: Text(
                    widget.title,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
        ),
      ),
    );
  }
}
