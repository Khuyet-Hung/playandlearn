import 'package:flutter/widgets.dart';

class MotionScope extends InheritedWidget {
  const MotionScope({
    super.key,
    required this.reduceMotion,
    required super.child,
  });

  final bool reduceMotion;

  static bool reducedOf(BuildContext context) =>
      (context
              .dependOnInheritedWidgetOfExactType<MotionScope>()
              ?.reduceMotion ??
          false) ||
      MediaQuery.disableAnimationsOf(context);

  static Duration durationOf(BuildContext context, int milliseconds) =>
      reducedOf(context) ? Duration.zero : Duration(milliseconds: milliseconds);

  @override
  bool updateShouldNotify(MotionScope oldWidget) =>
      reduceMotion != oldWidget.reduceMotion;
}
