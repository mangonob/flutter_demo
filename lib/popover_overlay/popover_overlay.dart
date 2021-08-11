import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_demo/popover_overlay/render_popover_overlay.dart';

import 'popover_widget.dart';

typedef PopoverBuilder = Widget Function(
  BuildContext,
  void Function() dismissOverlay,
);

class PopoverOverlay extends StatefulWidget {
  final Rect targetRect;
  final PopoverPositoin position;
  final PopoverBuilder popoverBuilder;
  final void Function()? dismiss;
  final Color? barrierColor;
  final Duration? animationDuration;

  PopoverOverlay({
    required this.targetRect,
    required this.popoverBuilder,
    required this.position,
    this.dismiss,
    this.barrierColor,
    this.animationDuration,
  }) : super();

  @override
  _PopoverOverlayState createState() => _PopoverOverlayState();
}

class _PopoverOverlayState extends State<PopoverOverlay>
    with TickerProviderStateMixin {
  PopoverPositoin? _position;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration ?? Duration(milliseconds: 125),
    );

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      final stack = context.findRenderObject() as RenderStack?;
      final overlay = stack?.lastChild as RenderPopoverOverlay?;
      if (overlay != null) {
        final newPosition = overlay.position;
        if (newPosition != _position) {
          setState(() {
            _position = newPosition;
          });
        }
      }
    });

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  _dismiss() async {
    await _animationController.reverse();
    if (widget.dismiss != null) widget.dismiss!();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: _dismiss,
          child: Container(color: widget.barrierColor),
        ),
        PopoverWidget(
          targetRect: widget.targetRect,
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (ctx, child) {
              print("Build");
              return Opacity(
                opacity: _animationController.value,
                child: Transform(
                  alignment: (_position ?? widget.position).alignment(),
                  transform: Matrix4Tween(
                    begin: Matrix4.diagonal3Values(0.5, 0.5, 1),
                    end: Matrix4.identity(),
                  ).animate(_animationController).value,
                  child: child,
                ),
              );
            },
            child: widget.popoverBuilder(
              context,
              _dismiss,
            ),
          ),
        ),
      ],
    );
  }
}

extension _TransformAlignment on PopoverPositoin {
  Alignment alignment() {
    switch (this) {
      case PopoverPositoin.top:
        return Alignment.bottomCenter;
      case PopoverPositoin.bottom:
        return Alignment.topCenter;
      case PopoverPositoin.left:
        return Alignment.centerRight;
      case PopoverPositoin.right:
        return Alignment.centerLeft;
    }
  }
}
