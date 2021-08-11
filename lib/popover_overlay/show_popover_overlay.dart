import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_demo/popover_overlay/popover_overlay.dart';

import 'popover_widget.dart';

showPopoverOverlay(
  BuildContext context, {
  required PopoverBuilder popoverBuilder,
  Color? barrierColor,
  EdgeInsets targetMargin = EdgeInsets.zero,
}) {
  final maybeOverlay = Overlay.of(context);
  assert(maybeOverlay != null);
  final OverlayState overlay = maybeOverlay!;
  final overlayBox = overlay.context.findRenderObject() as RenderBox;
  final box = context.findRenderObject() as RenderBox;
  final targetRect = Rect.fromPoints(
    overlayBox.globalToLocal(box.localToGlobal(box.semanticBounds.topLeft)),
    overlayBox.globalToLocal(box.localToGlobal(box.semanticBounds.bottomRight)),
  );
  late OverlayEntry overlayEntry;
  final dismiss = () => overlayEntry.remove();

  overlayEntry = OverlayEntry(builder: (ctx) {
    return PopoverOverlay(
      targetRect: Rect.fromLTRB(
        targetRect.left - targetMargin.left,
        targetRect.top - targetMargin.top,
        targetRect.right + targetMargin.right,
        targetRect.bottom + targetMargin.bottom,
      ),
      popoverBuilder: popoverBuilder,
      position: PopoverPositoin.bottom,
      dismiss: dismiss,
      barrierColor: barrierColor,
    );
  });

  overlay.insert(overlayEntry);
}
