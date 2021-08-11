import 'package:flutter/material.dart';

extension RectUtils on Rect {
  Rect flipVertical(double axis) {
    final top = axis * 2 - bottomLeft.dy;
    final bottom = axis * 2 - topLeft.dy;
    final left = topLeft.dx;
    final right = topRight.dx;
    return Rect.fromLTRB(left, top, right, bottom);
  }

  Rect flipHorizontal(double axis) {
    final top = topLeft.dy;
    final bottom = bottomLeft.dy;
    final left = axis * 2 - topRight.dx;
    final right = axis * 2 - topLeft.dx;
    return Rect.fromLTRB(left, top, right, bottom);
  }

  Rect adjustVertical(Rect container) {
    throw 42;
  }

  Rect adjustHorizontal(Rect container) {
    throw 42;
  }
}
