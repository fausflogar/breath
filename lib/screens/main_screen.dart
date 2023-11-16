import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart' as cupertino;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_breathe/constants/preset_timers.dart';
import 'package:just_breathe/constants/theme.dart';
import 'package:just_breathe/constants/ui.dart';
import 'package:just_breathe/generated/l10n.dart';
import 'package:just_breathe/pages_routes.dart';
import 'package:just_breathe/providers/settings_provider.dart';
import 'package:just_breathe/screens/about_screen.dart';
import 'package:just_breathe/screens/meditation_screen.dart';
import 'package:just_breathe/widgets/dark_mode_switcher.dart';
import 'package:just_breathe/widgets/settings_card.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainScreen extends StatefulWidget {
  MainScreen({this.startingAnimation = false, Key? key}) : super(key: key);

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

    _scaffold = AnimationController(
        vsync: this, value: widget.startingAnimation ? 0.0 : 1.0, duration: Duration(milliseconds: 1800));
    _logo = AnimationController(
        vsync: this, value: widget.startingAnimation ? 0.0 : 1.0, duration: Duration(milliseconds: 1800));
    _animation = Tween<Offset>(begin: Offset(0, 0.25), end: Offset(0, 0)).animate(
      CurvedAnimation(parent: _scaffold, curve: Curves.easeOutQuart),
    );

    _logoAnimation = Tween<Offset>(begin: Offset(0, 0.65), end: Offset(0, 0)).animate(
      CurvedAnimation(
        parent: _logo,
        curve: Interval(
          0.25,
          1.0,
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
          leading: SizedBox.shrink(),
          actions: [
            DarkModeSwitcher(),
          ],
        ),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Spacer(
                flex: 1,
              ),
              Expanded(
                child: SlideTransition(
                  position: _logoAnimation,
                  child: SvgPicture.asset(
                    'assets/images/lotus.svg',
                    semanticsLabel: '$appTitle logo',
                    colorFilter: ColorFilter.mode(accent, BlendMode.srcIn),
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
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      S.of(context)!.tagline,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    IconButton(
                        icon: Icon(
                          Icons.info,
                          color: Theme.of(context).iconTheme.color?.withOpacity(0.25),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                              PageRoutes.slide(() => AboutScreen(), startOffset: Offset(0, 1), milliseconds: 580));
                        }),
                  ],
                ),
              ),
              Expanded(
                flex: 6,
                child: Container(
                  // padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    children: <Widget>[
                      SettingsCard(
                        start: true,
                        title: Text(
                          S.of(context)!.durationSettingLabel,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        leading: Icon(Icons.hourglass_empty),
                        trailing: Consumer(
                          builder: (BuildContext context, WidgetRef ref, Widget? child) {
                            final _appState = ref.watch(appStateProvider);
                            return DropdownButton<Duration>(
                              underline: Container(),
                              items: kPresetTimers.map((preset) {
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
                              value: _appState.duration,
                              onChanged: (value) {
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
                        leading: Icon(Icons.music_note),
                        trailing: Consumer(
                          builder: (BuildContext context, WidgetRef ref, Widget? child) {
                            final _appState = ref.watch(appStateProvider);
                            return cupertino.CupertinoSwitch(
                              activeColor: accent,
                              onChanged: (value) {
                                ref.read(appStateProvider.notifier).togglePlaySounds();
                              },
                              value: _appState.playSounds,
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
                        leading: Icon(Icons.favorite),
                        // ignore: missing_required_param
                        trailing: Consumer(
                          builder: (BuildContext context, WidgetRef ref, Widget? child) {
                            final _appState = ref.watch(appStateProvider);
                            return cupertino.CupertinoSwitch(
                              activeColor: accent,
                              onChanged: (_) {
                                ref.read(appStateProvider.notifier).toggleZenMode();
                              },
                              value: _appState.isZenMode,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Spacer(
                flex: 1,
              ),
              Flexible(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 21.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(68.0),
                        )),
                        backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.secondary),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(PageRoutes.fade(() => MeditationScreen(), milliseconds: 300));
                      },
                      child: Text(
                        S.of(context)!.beginButton.toUpperCase(),
                        style: GoogleFonts.varelaRound(
                          color: fgDark,
                          fontWeight: FontWeight.w600,
                          fontSize: 18.0,
                        ),
                      ).padding(all: 8.0),
                    ),
                  ),
                ),
              ),
              Spacer(
                flex: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
