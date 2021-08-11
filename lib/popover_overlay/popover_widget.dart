import 'package:flutter/material.dart';
import 'package:flutter_demo/popover_overlay/render_popover_overlay.dart';

enum PopoverPositoin {
  top,
  left,
  right,
  bottom,
}

class PopoverWidget extends SingleChildRenderObjectWidget {
  final Rect targetRect;
  final PopoverPositoin position;

  PopoverWidget({
    required this.targetRect,
    required Widget child,
    this.position = PopoverPositoin.bottom,
  }) : super(child: child);

  @override
  RenderPopoverOverlay createRenderObject(BuildContext context) {
    return RenderPopoverOverlay(
      targetRect: targetRect,
      suggestPosition: position,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant RenderPopoverOverlay renderObject) {
    renderObject
      ..targetRect = targetRect
      ..suggestPosition = position;
  }
}
