// ignore_for_file: library_private_types_in_public_api

import 'dart:math' as math;

import 'package:breathe/model/settings.dart';
import 'package:breathe/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tinycolor2/tinycolor2.dart';

class CupertinoBreathe extends StatefulWidget {
  const CupertinoBreathe({super.key});

  @override
  _CupertinoBreatheState createState() => _CupertinoBreatheState();
}

class _CupertinoBreatheState extends State<CupertinoBreathe> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);
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
        aspectRatio: 0.75,
        child: Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            final AppState appState = ref.watch(appStateProvider);
            return CustomPaint(
              painter: _BreathePainter(
                CurvedAnimation(parent: _controller, curve: Curves.easeOutQuart, reverseCurve: Curves.easeOutQuart),
                color: Theme.of(context).colorScheme.secondary,
                isDarkMode: appState.isDarkMode,
              ),
              size: Size.infinite,
            );
          },
        ),
      ),
    );
  }
}

class _BreathePainter extends CustomPainter {
  _BreathePainter(
    this.animation, {
    required this.isDarkMode,
    // ignore: unused_element
    this.count = 6,
    required this.color,
  })  : circlePaint = Paint()
          ..color = isDarkMode ? color : TinyColor.fromColor(color).lighten(15).saturate(28).color
          ..blendMode = isDarkMode ? BlendMode.screen : BlendMode.modulate,
        super(repaint: animation);

  final Animation<double> animation;
  final int count;
  final Paint circlePaint;
  final Color color;
  final bool isDarkMode;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = size.center(Offset.zero);
    final double radius = (size.shortestSide * 0.25) * animation.value;
    for (int index = 0; index < count; index++) {
      final double indexAngle = index * math.pi / count * 2;
      final double angle = indexAngle + (math.pi * 1.5 * animation.value);
      final Offset offset = Offset(math.sin(angle), math.cos(angle)) * radius * 0.985;
      canvas.drawCircle(center + offset * animation.value, radius, circlePaint);
    }
  }

  @override
  bool shouldRepaint(_BreathePainter oldDelegate) => animation != oldDelegate.animation;
}
