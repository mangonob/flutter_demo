import 'dart:math';

import 'package:flutter/material.dart';

enum StatusBarOrientation {
  portrait,
  portraitUnsideDown,
  landscapeRight,
  landscapeLeft,
}

class OrientationWidget extends StatelessWidget {
  final Widget child;
  final StatusBarOrientation orientation;

  OrientationWidget({
    Key? key,
    required this.child,
    this.orientation = StatusBarOrientation.portrait,
  }) : super(key: key);

  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      assert(constraints.biggest.width.isFinite);
      assert(constraints.biggest.height.isFinite);

      final isPortrait = orientation == StatusBarOrientation.portrait ||
          orientation == StatusBarOrientation.portraitUnsideDown;

      final size = isPortrait
          ? constraints.biggest
          : Size(
              constraints.biggest.height,
              constraints.biggest.width,
            );

      Matrix4 t;
      switch (orientation) {
        case StatusBarOrientation.portrait:
          t = Matrix4.identity();
          break;
        case StatusBarOrientation.portraitUnsideDown:
          t = Matrix4.rotationZ(pi);
          break;
        case StatusBarOrientation.landscapeLeft:
          t = Matrix4.rotationZ(-pi / 2);
          break;
        case StatusBarOrientation.landscapeRight:
          t = Matrix4.rotationZ(pi / 2);
          break;
      }

      return OverflowBox(
        maxWidth: double.infinity,
        maxHeight: double.infinity,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 250),
          width: size.width,
          height: size.height,
          transform: t,
          transformAlignment: Alignment.center,
          child: child,
        ),
      );
    });
  }
}
