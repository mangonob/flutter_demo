import 'package:flutter/material.dart';

import 'painter/autolayout_label_painter.dart';
import 'painter/pie_chart_series_paint.dart';
import 'serie.dart';

class PieChart extends StatelessWidget {
  final List<PieChartSerie> series;
  final Color? backgroundColor;
  final bool isLabelAutoLayout;

  PieChart({
    Key? key,
    required this.series,
    this.backgroundColor = Colors.white,
    this.isLabelAutoLayout = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Container(
        color: backgroundColor,
        child: CustomPaint(
          child: ClipRect(
            child: PieChartSeriesPaint(
              series: series,
              isLablePainted: !isLabelAutoLayout,
            ),
          ),
          foregroundPainter:
              isLabelAutoLayout ? AutoLayoutLabelPainter(series: series) : null,
        ),
      ),
    );
  }
}
