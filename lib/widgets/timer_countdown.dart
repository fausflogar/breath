import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_breathe/generated/l10n.dart';
import 'package:just_breathe/model/quote.dart';
import 'package:just_breathe/utils/extensions.dart';
import 'package:just_breathe/pages_routes.dart';
import 'package:just_breathe/screens/completion_screen.dart';
import 'package:just_breathe/screens/main_screen.dart';
import 'package:just_breathe/utils/utils.dart';
import 'package:just_breathe/widgets/nash_breathe.dart';
import 'package:just_breathe/widgets/countdown_circle.dart';
import 'package:styled_widget/styled_widget.dart';

/// This is the class that is responsible for keeping a timer.
/// It can either display a simple breathe animation, if [zenMode] is enabled
/// or traditional countdown timer
/// It can play a gong sounds to mark the beginning and end of the countdown
class TimerCountdown extends StatefulWidget {
  /// How many seconds to countdown from
  final Duration duration;
  final bool zenMode;
  final bool playSounds;

  TimerCountdown(this.duration, {required this.zenMode, required this.playSounds, Key? key}) : super(key: key);

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
      final player = AudioPlayer();
      await player.setAsset('assets/audio/gong.mp3');
      player.play();

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
    _timer = Timer.periodic(Duration(milliseconds: 10), (Timer t) {
      // update display
      setState(() {
        var diff = (_elapsedTime - _stopwatch.elapsed);
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
      Navigator.of(context).pushReplacement(PageRoutes.fade(() => MainScreen(), milliseconds: 450));
    } else {
      Quote _quote = getQuote(context);
      Navigator.of(context).pushReplacement(PageRoutes.fade(
          () => CompletionScreen(
                quote: _quote,
              ),
          milliseconds: 800));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        widget.zenMode
            ? Expanded(child: CupertinoBreathe())
            : Expanded(
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    SizedBox.expand(
                      child: CountdownCircle(
                        duration: widget.duration,
                      ),
                    ),
                    Container(
                      child: Text(
                        _display,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ],
                ),
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
                  backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).disabledColor),
                ),
                onPressed: () => stop(),
                child: Text(
                  S.of(context)!.endButton.toUpperCase(),
                  style: GoogleFonts.varelaRound(
                    color: Color(0xFF707073),
                    fontWeight: FontWeight.w600,
                    fontSize: 18.0,
                  ),
                ).padding(all: 8.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
