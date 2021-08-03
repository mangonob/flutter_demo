import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  static Rect getWidgetBounds(BuildContext context) {
    final box = context.findRenderObject() as RenderBox?;
    return (box != null) ? box.semanticBounds : Rect.zero;
  }

  static Offset getWidgetLocalToGlobal(BuildContext context) {
    final box = context.findRenderObject() as RenderBox?;
    final containerBox =
        Navigator.of(context).context.findRenderObject() as RenderBox?;
    if (containerBox != null) {
      return box == null
          ? Offset.zero
          : containerBox.globalToLocal(box.localToGlobal(Offset.zero));
    } else {
      return box == null ? Offset.zero : box.localToGlobal(Offset.zero);
    }
  }

  static Size? getContainerSize(BuildContext context) {
    final box = Navigator.of(context).context.findRenderObject() as RenderBox?;
    return box?.semanticBounds.size;
  }
}
