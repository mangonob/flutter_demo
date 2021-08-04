import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_demo/popover_overlay/render_popover_overlay.dart';

class PopoverWidget extends SingleChildRenderObjectWidget {
  final Rect targetRect;

  PopoverWidget({
    required this.targetRect,
    required Widget child,
  }) : super(child: child);

  @override
  RenderPopoverOverlay createRenderObject(BuildContext context) {
    return RenderPopoverOverlay(targetRect: targetRect);
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant RenderPopoverOverlay renderObject) {
    renderObject..targetRect = targetRect;
  }
}

showPopoverOverlay(BuildContext context, {required Widget popover}) {
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
  overlayEntry = OverlayEntry(builder: (ctx) {
    return Stack(
      children: [
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => overlayEntry.remove(),
          child: Container(color: Colors.black.withAlpha(0x66)),
        ),
        PopoverWidget(
          targetRect: targetRect,
          child: popover,
        ),
      ],
    );
  });

  overlay.insert(overlayEntry);
}
