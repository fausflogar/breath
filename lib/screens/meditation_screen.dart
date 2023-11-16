import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_breathe/providers/settings_provider.dart';
import 'package:just_breathe/widgets/dark_mode_switcher.dart';
import 'package:just_breathe/widgets/timer_countdown.dart';

class MeditationScreen extends ConsumerWidget {
  const MeditationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox.shrink(),
        actions: [
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
