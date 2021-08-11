import 'package:flutter/material.dart';

class FlutterPopoverOverlay extends StatelessWidget {
  final Widget child;

  FlutterPopoverOverlay({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Overlay(
      initialEntries: [
        OverlayEntry(builder: (ctx) => child),
      ],
    );
  }
}
