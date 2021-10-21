import 'package:flutter/material.dart';

class DropdownOverlay extends StatefulWidget {
  final Widget overlay;
  final Widget child;
  final Color? backgroundColor;
  final bool isVisiable;
  final Duration duration;

  DropdownOverlay({
    Key? key,
    required this.overlay,
    required this.child,
    this.backgroundColor,
    this.isVisiable = true,
    this.duration = const Duration(milliseconds: 250),
  }) : super(key: key);

  @override
  State<DropdownOverlay> createState() => _DropdownOverlayState();
}

class _DropdownOverlayState extends State<DropdownOverlay>
    with SingleTickerProviderStateMixin {
  bool _isVisiable = false;
  late AnimationController _aniController;

  @override
  void initState() {
    super.initState();

    _aniController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _performAnimateIfNeeded();
  }

  @override
  void didUpdateWidget(covariant DropdownOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.duration != oldWidget.duration)
      _aniController.duration = widget.duration;

    _performAnimateIfNeeded();
  }

  _performAnimateIfNeeded() async {
    if (_isVisiable != widget.isVisiable) {
      if (widget.isVisiable) {
        setState(() {
          _isVisiable = true;
        });
        await _aniController.forward();
      } else {
        await _aniController.reverse();
        setState(() {
          _isVisiable = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor =
        this.widget.backgroundColor ?? Colors.black.withOpacity(0.5);

    if (_isVisiable) {
      return ClipRect(
        child: Stack(
          children: [
            Positioned.fill(child: widget.child),
            Positioned.fill(
              child: FadeTransition(
                opacity: _aniController,
                child: Container(color: backgroundColor),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SlideTransition(
                position: Tween<Offset>(begin: Offset(0, -1), end: Offset.zero)
                    .animate(_aniController),
                child: widget.overlay,
              ),
            ),
          ],
        ),
      );
    } else {
      return widget.child;
    }
  }
}
