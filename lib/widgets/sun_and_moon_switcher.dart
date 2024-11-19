import 'package:flutter/material.dart';

class SunAndMoonSwitcher extends StatelessWidget {
  const SunAndMoonSwitcher({
    super.key,
    required this.isDarkMode,
  });

  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Icon(
      isDarkMode ? Icons.dark_mode : Icons.light_mode,
      color: Theme.of(context).colorScheme.secondary,
      size: 28,
    );
  }
}
