import 'package:flutter/material.dart';

import '../area.dart';
import '../serie.dart';
import 'serie_painter.dart';

class LineChartSeriesPaint extends StatelessWidget {
  final List<LineChartSerie> series;
  final Area area;
  final EdgeInsets padding;

  LineChartSeriesPaint({
    required this.series,
    required this.area,
    required this.padding,
  }) : super();

  @override
  Widget build(BuildContext context) {
    if (series.isEmpty) {
      return SizedBox();
    } else {
      final head = series.first;
      final tail = series.skip(1);
      return CustomPaint(
        painter: LineChartSeriesPainter(
          serie: head,
          area: area,
          padding: padding,
        ),
        child: LineChartSeriesPaint(
          series: tail.toList(),
          area: area,
          padding: padding,
        ),
      );
    }
  }
}
