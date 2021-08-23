import 'package:flutter/material.dart';

import '../serie.dart';
import 'pie_chart_serie_painter.dart';

class PieChartSeriesPaint extends StatelessWidget {
  final List<PieChartSerie> series;
  final bool isLablePainted;

  PieChartSeriesPaint({
    Key? key,
    required this.series,
    this.isLablePainted = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (series.isEmpty) {
      return SizedBox();
    } else {
      final head = series.first;
      final tail = series.skip(1).toList();
      return CustomPaint(
        painter: PieChartSeriePainter(
          serie: head,
          isLablePainted: isLablePainted,
        ),
        child: PieChartSeriesPaint(
          series: tail,
          isLablePainted: isLablePainted,
        ),
      );
    }
  }
}
