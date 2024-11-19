// ignore_for_file: library_private_types_in_public_api

import 'package:breathe/constants/preset_timers.dart';
import 'package:breathe/constants/theme.dart';
import 'package:breathe/constants/ui.dart';
import 'package:breathe/generated/l10n.dart';
import 'package:breathe/model/settings.dart';
import 'package:breathe/pages_routes.dart';
import 'package:breathe/providers/settings_provider.dart';
import 'package:breathe/screens/about_screen.dart';
import 'package:breathe/screens/meditation_screen.dart';
import 'package:breathe/widgets/big_button.dart';
import 'package:breathe/widgets/dark_mode_switcher.dart';
import 'package:breathe/widgets/settings_card.dart';
import 'package:flutter/cupertino.dart' as cupertino;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({this.startingAnimation = false, super.key});

  /// Determins if the starting animation should be played. It should only be played when the app is first launched from quit.
  final bool startingAnimation;

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  late AnimationController _scaffold;
  late AnimationController _logo;
  late Animation<Offset> _animation;
  late Animation<Offset> _logoAnimation;

  @override
  void initState() {
    super.initState();

    _scaffold = AnimationController(vsync: this, value: widget.startingAnimation ? 0.0 : 1.0, duration: const Duration(milliseconds: 1800));
    _logo = AnimationController(vsync: this, value: widget.startingAnimation ? 0.0 : 1.0, duration: const Duration(milliseconds: 1800));
    _animation = Tween<Offset>(begin: const Offset(0, 0.25), end: Offset.zero).animate(
      CurvedAnimation(parent: _scaffold, curve: Curves.easeOutQuart),
    );

    _logoAnimation = Tween<Offset>(begin: const Offset(0, 0.65), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _logo,
        curve: const Interval(
          0.25,
          1,
          curve: Curves.ease,
        ),
      ),
    );

    if (widget.startingAnimation) {
      _scaffold.forward();
      _logo.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: Scaffold(
        appBar: AppBar(
          leading: const SizedBox.shrink(),
          actions: const <cupertino.Widget>[
            DarkModeSwitcher(),
          ],
        ),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              const Spacer(),
              Expanded(
                child: SlideTransition(
                  position: _logoAnimation,
                  child: SvgPicture.asset(
                    'assets/images/lotus.svg',
                    semanticsLabel: '$appTitle logo',
                    colorFilter: const ColorFilter.mode(accent, BlendMode.srcIn),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  children: <Widget>[
                    Text(
                      appTitle,
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      S.of(context)!.tagline,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.info,
                        color: accent,
                      ),
                      onPressed: () {
                        Navigator.of(context).push(PageRoutes.slide(() => const AboutScreen(), startOffset: const Offset(0, 1), milliseconds: 580));
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 6,
                child: Column(
                  children: <Widget>[
                    SettingsCard(
                      start: true,
                      title: Text(
                        S.of(context)!.durationSettingLabel,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      leading: const Icon(Icons.hourglass_empty),
                      trailing: Consumer(
                        builder: (BuildContext context, WidgetRef ref, Widget? child) {
                          final AppState appState = ref.watch(appStateProvider);
                          return DropdownButton<Duration>(
                            underline: Container(),
                            items: kPresetTimers.map((Duration preset) {
                              return DropdownMenuItem<Duration>(
                                value: preset,
                                child: Text(
                                  S.of(context)!.presetDuration(preset.inMinutes),
                                  textAlign: TextAlign.right,
                                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                        fontWeight: FontWeight.w300,
                                      ),
                                ),
                              );
                            }).toList(),
                            value: appState.duration,
                            onChanged: (Duration? value) {
                              ref.read(appStateProvider.notifier).setDuration(value!);
                            },
                          );
                        },
                      ),
                    ),
                    SettingsCard(
                      title: Text(
                        S.of(context)!.playSoundSettingLabel,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      leading: const Icon(Icons.music_note),
                      trailing: Consumer(
                        builder: (BuildContext context, WidgetRef ref, Widget? child) {
                          final AppState appState = ref.watch(appStateProvider);
                          return cupertino.CupertinoSwitch(
                            activeColor: accent,
                            onChanged: (bool value) {
                              ref.read(appStateProvider.notifier).togglePlaySounds();
                            },
                            value: appState.playSounds,
                          );
                        },
                      ),
                    ),
                    SettingsCard(
                      end: true,
                      title: Text(
                        S.of(context)!.zenModeSettingLabel,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      leading: const Icon(Icons.favorite),
                      // ignore: missing_required_param
                      trailing: Consumer(
                        builder: (BuildContext context, WidgetRef ref, Widget? child) {
                          final AppState appState = ref.watch(appStateProvider);
                          return cupertino.CupertinoSwitch(
                            activeColor: accent,
                            onChanged: (_) {
                              ref.read(appStateProvider.notifier).toggleZenMode();
                            },
                            value: appState.isZenMode,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Flexible(
                child: BigButton(
                  text: S.of(context)!.beginButton.toUpperCase(),
                  onPressed: () => Navigator.of(context).push(PageRoutes.fade(() => const MeditationScreen(), milliseconds: 300)),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
