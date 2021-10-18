import 'package:flutter/material.dart';

class TreeMapConfig extends InheritedWidget {
  final Duration duration;
  final double space;

  TreeMapConfig({
    Key? key,
    required Widget child,
    required this.duration,
    required this.space,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(TreeMapConfig oldWidget) {
    return oldWidget.duration != duration || oldWidget.space != space;
  }

  static TreeMapConfig of(BuildContext context) =>
      context.findAncestorWidgetOfExactType<TreeMapConfig>()!;
}
