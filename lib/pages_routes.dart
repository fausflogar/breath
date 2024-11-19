// Lifted from
// blog.gskinner.com/archives/2020/03/flutter-simplify-your-pageroutes.html

import 'package:flutter/material.dart';

typedef PageBuilder = Widget Function();

class PageRoutes {
  static const double kDefaultDuration = .35;
  static const Curve kDefaultEaseFwd = Curves.easeOut;
  static const Curve kDefaultEaseReverse = Curves.easeOut;

  static Route<T> zoneIn<T>(
    PageBuilder page, [
    double duration = kDefaultDuration,
  ]) {
    return PageRouteBuilder<T>(
      transitionDuration: Duration(milliseconds: (duration * 2200).round()),
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) => page(),
      transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
        return ScaleTransition(
          scale: Tween<double>(begin: 2.05, end: 1).animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOutQuart,
            ),
          ),
          child: child,
        );
      },
    );
  }

  static Route<T> fade<T>(PageBuilder page, {int milliseconds = 1800}) {
    return PageRouteBuilder<T>(
      transitionDuration: Duration(milliseconds: milliseconds),
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) => page(),
      transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
        return FadeTransition(
          opacity: CurvedAnimation(
            parent: animation,
            curve: Curves.easeInQuart,
            reverseCurve: Curves.easeInQuart,
          ),
          child: child,
        );
      },
    );
  }

  static Route<T> slide<T>(
    PageBuilder page, {
    int milliseconds = 1800,
    Offset startOffset = const Offset(1, 0),
    Curve easeFwd = kDefaultEaseFwd,
    Curve easeReverse = kDefaultEaseReverse,
  }) {
    return PageRouteBuilder<T>(
      transitionDuration: Duration(milliseconds: milliseconds),
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) => page(),
      transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
        final bool reverse = animation.status == AnimationStatus.reverse;
        return SlideTransition(
          position: Tween<Offset>(begin: startOffset, end: Offset.zero).animate(
            CurvedAnimation(
              parent: animation,
              curve: reverse ? easeReverse : easeFwd,
            ),
          ),
          child: child,
        );
      },
    );
  }
}
