import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_breathe/providers/settings_provider.dart';
import 'package:just_breathe/widgets/sun_and_moon_switcher.dart';

class DarkModeSwitcher extends ConsumerWidget {
  const DarkModeSwitcher({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _appState = ref.watch(appStateProvider);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        ref.read(appStateProvider.notifier).toggleDarkMode();
      },
      child: Align(
        alignment: Alignment.topRight,
        child: Container(
          padding: EdgeInsets.all(24.0),
          child: SunAndMoonSwitcher(
            isDarkMode: _appState.isDarkMode,
          ),
        ),
      ),
    );
  }
}
