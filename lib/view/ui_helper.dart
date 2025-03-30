import 'package:flutter/material.dart';

class UiHelper extends InheritedWidget {
  final double screenWidth;
  final double screenHeight;

  const UiHelper({
    Key? key,
    required this.screenWidth,
    required this.screenHeight,
    required Widget child,
  }) : super(key: key, child: child);

  static UiHelper? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<UiHelper>();
  }

  @override
  bool updateShouldNotify(covariant UiHelper oldWidget) {
    return screenWidth != oldWidget.screenWidth || screenHeight != oldWidget.screenHeight;
  }
}
