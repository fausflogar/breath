import 'package:breathe/model/settings.dart';
import 'package:breathe/providers/settings_provider.dart';
import 'package:breathe/widgets/sun_and_moon_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DarkModeSwitcher extends ConsumerWidget {
  const DarkModeSwitcher({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppState appState = ref.watch(appStateProvider);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        ref.read(appStateProvider.notifier).toggleDarkMode();
      },
      child: Align(
        alignment: Alignment.topRight,
        child: Container(
          padding: const EdgeInsets.all(24),
          child: SunAndMoonSwitcher(
            isDarkMode: appState.isDarkMode,
          ),
        ),
      ),
    );
  }
}
