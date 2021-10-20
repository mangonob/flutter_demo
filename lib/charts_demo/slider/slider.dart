import 'package:flutter/material.dart';

class _SliderInfo extends InheritedWidget {
  final double offset;

  _SliderInfo({
    Key? key,
    required Widget child,
    required this.offset,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_SliderInfo oldWidget) {
    return oldWidget.offset != offset;
  }
}

class Slider {}
