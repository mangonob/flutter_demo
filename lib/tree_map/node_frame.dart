import 'package:flutter/material.dart';

class NodeFrame extends InheritedWidget {
  final Rect frame;

  NodeFrame({
    Key? key,
    required Widget child,
    required this.frame,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(NodeFrame oldWidget) {
    return oldWidget.frame != frame;
  }

  static NodeFrame of(BuildContext context) =>
      context.findAncestorWidgetOfExactType<NodeFrame>()!;
}
