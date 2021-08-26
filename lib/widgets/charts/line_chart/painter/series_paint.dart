import 'package:flutter/material.dart';

import '../area.dart';
import '../serie.dart';
import 'serie_paint.dart';

class LineChartSeriesPaint extends StatelessWidget {
  final List<LineChartSerie> series;
  final Area area;
  final EdgeInsets padding;
  final Offset? activePosition;

  LineChartSeriesPaint({
    required this.series,
    required this.area,
    required this.padding,
    this.activePosition,
  }) : super();

  @override
  Widget build(BuildContext context) {
    if (series.isEmpty) {
      return SizedBox();
    } else {
      final head = series.first;
      final tail = series.skip(1);
      return SeriePaint(
        serie: head,
        area: area,
        padding: padding,
        activePosition: activePosition,
        child: LineChartSeriesPaint(
          series: tail.toList(),
          area: area,
          padding: padding,
        ),
      );
    }
  }
}
