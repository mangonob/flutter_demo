import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class RenderPopoverOverlay extends RenderShiftedBox {
  Rect targetRect;

  RenderPopoverOverlay({
    required this.targetRect,
    RenderBox? child,
  }) : super(child);

  @override
  void performLayout() {
    size = constraints.biggest;

    if (child != null) {
      var _child = child!;
      _child.layout(constraints);
      // final parentData = _child.parentData as BoxParentData;
      // parentData.offset = Offset(100, 100);
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    context.canvas.drawRect(targetRect, Paint()..color = Colors.red);
    super.paint(context, offset);
  }
}
