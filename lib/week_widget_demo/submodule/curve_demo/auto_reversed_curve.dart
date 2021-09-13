import 'package:flutter/material.dart';

class AutoReversedCurve extends Curve {
  final Curve curve;

  AutoReversedCurve([this.curve = Curves.linear]);

  @override
  double transform(double t) {
    if (t <= 0.5) {
      return curve.transform(t * 2);
    } else {
      return curve.transform((1 - t) * 2);
    }
  }

  @override
  Curve get flipped => this;
}
