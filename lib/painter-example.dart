import 'package:flutter/material.dart';

class PainterExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          color: Colors.green,
          child: CustomPaint(
            size: Size(300, 300),
            painter: Painter(),
          ),
        ),
      ),
    );
  }
}

class Painter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = Colors.red;
    paint.strokeWidth = 3;
    canvas.clipRect(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawLine(Offset(0, 0), Offset(100, 100), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    print(oldDelegate);
    return false;
  }
}
