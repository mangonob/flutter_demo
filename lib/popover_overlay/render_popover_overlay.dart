import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tuple/tuple.dart';

import 'popover_widget.dart';
import 'utils.dart';

class RenderPopoverOverlay extends RenderShiftedBox {
  Rect targetRect;
  PopoverPositoin suggestPosition;
  PopoverPositoin? _position;

  PopoverPositoin get position => _position ?? suggestPosition;

  RenderPopoverOverlay({
    required this.targetRect,
    required this.suggestPosition,
    RenderBox? child,
  }) : super(child);

  @override
  void performLayout() {
    size = constraints.biggest;

    if (child != null) {
      var _child = child!;
      _child.layout(BoxConstraints(), parentUsesSize: true);
      final childSize = _child.size;
      final parentData = _child.parentData as BoxParentData;
      final info = _getPopoverInfo(childSize);
      parentData.offset = info.item1.topLeft;
      _position = info.item2;
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    super.paint(context, offset);
    context.canvas.save();
    context.canvas.translate(offset.dx, offset.dy);
    _paint(context);
    context.canvas.restore();
  }

  void _paint(PaintingContext context) {}

  Rect _getPopoverSuggestRect(Size size) {
    switch (suggestPosition) {
      case PopoverPositoin.top:
        return Rect.fromLTWH(
          targetRect.topCenter.dx - size.width / 2,
          targetRect.top - size.height,
          size.width,
          size.height,
        );
      case PopoverPositoin.left:
        return Rect.fromLTWH(
          targetRect.left - size.width,
          targetRect.centerLeft.dy - size.height / 2,
          size.width,
          size.height,
        );
      case PopoverPositoin.right:
        return Rect.fromLTWH(
          targetRect.right,
          targetRect.centerLeft.dy - size.height / 2,
          size.width,
          size.height,
        );
      case PopoverPositoin.bottom:
        return Rect.fromLTWH(
          targetRect.topCenter.dx - size.width / 2,
          targetRect.bottom,
          size.width,
          size.height,
        );
    }
  }

  Tuple2<Rect, PopoverPositoin> _getPopoverInfo(Size size) {
    var rect = _getPopoverSuggestRect(size);
    final containerSize = this.size;
    final topEdge = targetRect.top;
    final leftEdge = targetRect.left;
    final bottomEdge = containerSize.height - targetRect.bottom;
    final rightEdge = containerSize.width - targetRect.right;
    var position = suggestPosition;

    switch (position) {
      case PopoverPositoin.top:
        if (topEdge < size.height && topEdge < bottomEdge) {
          rect = rect.flipVertical(targetRect.center.dy);
          position = PopoverPositoin.bottom;
        }
        break;
      case PopoverPositoin.bottom:
        if (bottomEdge < size.height && bottomEdge < topEdge) {
          rect = rect.flipVertical(targetRect.center.dy);
          position = PopoverPositoin.top;
        }
        break;
      case PopoverPositoin.left:
        if (leftEdge < size.width && leftEdge < rightEdge) {
          rect = rect.flipHorizontal(targetRect.center.dx);
          position = PopoverPositoin.right;
        }
        break;
      case PopoverPositoin.right:
        if (rightEdge < size.width && rightEdge < leftEdge) {
          rect = rect.flipHorizontal(targetRect.center.dx);
          position = PopoverPositoin.left;
        }
        break;
    }

    rect = _adjustInContainer(rect, position);

    return Tuple2(rect, position);
  }

  Rect _adjustInContainer(Rect rect, PopoverPositoin position) {
    var adjusted = Rect.fromLTWH(rect.left, rect.top, rect.width, rect.height);
    final containerSize = this.size;

    switch (position) {
      case PopoverPositoin.top:
      case PopoverPositoin.bottom:
        if (adjusted.width <= containerSize.width) {
          if (adjusted.left < 0) {
            adjusted = adjusted.translate(-adjusted.left, 0);
          } else if (adjusted.right > containerSize.width) {
            adjusted =
                adjusted.translate(containerSize.width - adjusted.right, 0);
          }
        }
        break;
      case PopoverPositoin.left:
      case PopoverPositoin.right:
        if (adjusted.height <= containerSize.height) {
          if (adjusted.top < 0) {
            adjusted = adjusted.translate(0, -adjusted.top);
          } else if (adjusted.bottom > containerSize.height) {
            adjusted =
                adjusted.translate(0, containerSize.height - adjusted.bottom);
          }
        }
        break;
    }

    return adjusted;
  }
}
