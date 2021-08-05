import 'package:flutter/material.dart';

import '../area.dart';
import '../serie.dart';

class LineChartSeriesPainter extends CustomPainter {
  final LineChartSerie serie;
  final Area area;

  LineChartSeriesPainter({
    required this.serie,
    required this.area,
  }) : super();

  @override
  void paint(Canvas canvas, Size size) {
    if (serie.data.isEmpty) return;

    final style = serie.style;

    final xUnit = size.width / area.width;
    final yUnit = size.height / area.height;
    final points = serie.points
        .map((p) => Offset(
              (p.dx - area.minX) * xUnit,
              size.height - (p.dy - area.minY) * yUnit,
            ))
        .toList();
    final head = points.first;
    final tail = points.skip(1);
    final path = Path();
    path.moveTo(head.dx, head.dy);
    tail.forEach(
      (point) => path.lineTo(point.dx, point.dy),
    );

    canvas.drawPath(
      path,
      Paint()
        ..style = PaintingStyle.stroke
        ..color = style.lineStyle.color
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..strokeJoin = style.strokeJoin
        ..strokeWidth = style.lineStyle.width,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
