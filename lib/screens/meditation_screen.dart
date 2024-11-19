import 'package:breathe/providers/settings_provider.dart';
import 'package:breathe/widgets/dark_mode_switcher.dart';
import 'package:breathe/widgets/timer_countdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MeditationScreen extends ConsumerWidget {
  const MeditationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox.shrink(),
        actions: const <Widget>[
          DarkModeSwitcher(),
        ],
      ),
      body: Center(
        child: TimerCountdown(
          ref.read(appStateProvider).duration,
          zenMode: ref.read(appStateProvider).isZenMode,
          playSounds: ref.read(appStateProvider).playSounds,
        ),
      ),
    );
  }
}
