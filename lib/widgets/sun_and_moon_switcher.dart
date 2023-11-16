import 'package:flutter/material.dart';

class SunAndMoonSwitcher extends StatelessWidget {
  const SunAndMoonSwitcher({
    Key? key,
    required this.isDarkMode,
  }) : super(key: key);
  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Icon(
      isDarkMode ? Icons.dark_mode : Icons.light_mode,
      color: Theme.of(context).colorScheme.secondary,
      size: 28.0,
    );
  }
}
