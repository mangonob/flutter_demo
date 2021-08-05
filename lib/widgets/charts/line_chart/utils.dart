import 'dart:ui';

extension CanvasUtils on Canvas {
  void routine(Canvas paint, void Function() routine) {
    paint.save();
    routine();
    paint.restore();
  }
}
