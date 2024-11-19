// ignore_for_file: library_private_types_in_public_api

import 'dart:math';

import 'package:breathe/constants/theme.dart';
import 'package:flutter/material.dart';
import 'package:tinycolor2/tinycolor2.dart';

class CountdownCircle extends StatefulWidget {
  const CountdownCircle({super.key, required this.duration});

  final Duration duration;

  @override
  _CountdownCircleState createState() => _CountdownCircleState();
}

class _CountdownCircleState extends State<CountdownCircle> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _controller.forward().orCancel;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AspectRatio(
        aspectRatio: 1,
        child: CustomPaint(
          painter: _CircleCountdownPainter(
            thinRing: Theme.of(context).colorScheme.secondary.withOpacity(0.85),
            tickerRing: Theme.of(context).colorScheme.secondary,
            animation: Tween<double>(begin: 0, end: pi * 2).animate(CurvedAnimation(parent: _controller, curve: Curves.linear)),
          ),
          size: Size.infinite,
        ),
      ),
    );
  }
}

class _CircleCountdownPainter extends CustomPainter {
  _CircleCountdownPainter({required this.animation, required this.thinRing, required this.tickerRing})
      : fillerPaint = Paint()
          ..color = accent
          ..style = PaintingStyle.stroke
          ..strokeWidth = 42.0
          ..strokeCap = StrokeCap.round,
        super(repaint: animation);

  // The color of the thinRing
  final Color thinRing;

  // The color of the ticking circle
  final Color tickerRing;
  final Animation<double> animation;
  final Paint fillerPaint;

  Paint circlePaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 3.0
    ..strokeCap = StrokeCap.round;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = size.center(Offset.zero);
    final double radius = size.shortestSide * 0.30;
    final Rect rect = Rect.fromCircle(center: center, radius: radius);

    // Draw the thin ring
    canvas.drawCircle(
      center,
      radius,
      circlePaint..color = thinRing,
    );

    final Gradient gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: <Color>[
        TinyColor.fromColor(tickerRing).lighten(8).color,
        tickerRing,
        TinyColor.fromColor(tickerRing).darken(5).color,
      ],
      stops: const <double>[0, 0.5, 1],
    );

    /// Draw the countdown circle based on [animation.value]
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(pi * 3 / 2);
    canvas.translate(-center.dx, -center.dy);
    canvas.drawArc(
      rect,
      0,
      animation.value,
      false,
      fillerPaint..shader = gradient.createShader(rect),
    );
    canvas.restore();
  }

  @override
  bool shouldRepaint(_CircleCountdownPainter oldDelegate) {
    return animation != oldDelegate.animation;
  }
}
