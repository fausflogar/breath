// ignore_for_file: library_private_types_in_public_api

import 'dart:async';

import 'package:breathe/generated/l10n.dart';
import 'package:breathe/model/quote.dart';
import 'package:breathe/pages_routes.dart';
import 'package:breathe/screens/completion_screen.dart';
import 'package:breathe/screens/main_screen.dart';
import 'package:breathe/utils/extensions.dart';
import 'package:breathe/utils/utils.dart';
import 'package:breathe/widgets/big_button.dart';
import 'package:breathe/widgets/countdown_circle.dart';
import 'package:breathe/widgets/nash_breathe.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

/// This is the class that is responsible for keeping a timer.
/// It can either display a simple breathe animation, if [zenMode] is enabled
/// or traditional countdown timer
/// It can play a gong sounds to mark the beginning and end of the countdown
class TimerCountdown extends StatefulWidget {
  const TimerCountdown(this.duration, {required this.zenMode, required this.playSounds, super.key});

  /// How many seconds to countdown from
  final Duration duration;
  final bool zenMode;
  final bool playSounds;

  @override
  _TimerCountdown createState() => _TimerCountdown();
}

class _TimerCountdown extends State<TimerCountdown> {
  late Stopwatch _stopwatch;

  // The thing that ticks
  late Timer _timer;

  // Keeps track of how much time has elapsed
  late Duration _elapsedTime;

  // This string that is displayed as the countdown timer
  String _display = 'Be at peace';

  // Play a sound
  Future<void> _playSound() async {
    if (widget.playSounds) {
      final AudioPlayer player = AudioPlayer();
      await player.setAsset('assets/audio/gong.mp3');
      await player.play();
    }
  }

  @override
  void initState() {
    super.initState();
    _playSound();
    _elapsedTime = widget.duration;
    _stopwatch = Stopwatch();
    // start();
    start();
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
    _stopwatch.stop();
  }

  // This will start the Timer
  void start() {
    if (!_stopwatch.isRunning) {
      _stopwatch.start();
    }
    // if (_timer != null) {
    //   if (_timer.isActive) return;
    // }
    _timer = Timer.periodic(const Duration(milliseconds: 10), (Timer t) {
      // update display
      setState(() {
        final Duration diff = _elapsedTime - _stopwatch.elapsed;
        _display = diff.clockFmt();
        if (diff.inMilliseconds <= 0) {
          _playSound();
          stop(cancelled: false);
        }
      });
    });
  }

  // This will pause the timer
  void pause() {
    if (!_stopwatch.isRunning) {
      return;
    }
    setState(() {
      _stopwatch.stop();
    });
  }

  // This will stop the timer
  void stop({bool cancelled = true}) {
    if (!_stopwatch.isRunning) {
      return;
    }
    setState(() {
      _timer.cancel();
      _stopwatch.stop();
    });

    if (cancelled) {
      Navigator.of(context).pushReplacement(PageRoutes.fade(() => const MainScreen(), milliseconds: 450));
    } else {
      final Quote quote = getQuote(context);
      Navigator.of(context).pushReplacement(
        PageRoutes.fade(
          () => CompletionScreen(
            quote: quote,
          ),
          milliseconds: 800,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        if (widget.zenMode)
          const Expanded(child: CupertinoBreathe())
        else
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                SizedBox.expand(
                  child: CountdownCircle(
                    duration: widget.duration,
                  ),
                ),
                Text(
                  _display,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
        Flexible(
          child: BigButton(text: S.of(context)!.endButton.toUpperCase(), onPressed: () => stop()),
        ),
      ],
    );
  }
}
