import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

import '../area.dart';
import '../axis.dart';
import '../grid.dart';
import '../serie.dart';
import '../style.dart';

class LineChartPainter extends CustomPainter {
  final LineChartStyle? style;
  final LineChartGrid? grid;
  final LineChartAxis? xAxis;
  final LineChartAxis? yAxis;
  final LineChartAxis? rightAxis;
  final List<LineChartSerie> series;
  final EdgeInsets padding;
  final Offset? activePosition;
  final Area area;

  LineChartPainter({
    this.grid,
    this.xAxis,
    this.yAxis,
    this.rightAxis,
    this.series = const [],
    required this.padding,
    this.activePosition,
    this.style,
    required this.area,
  }) : super();

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    canvas.translate(padding.left, padding.top);
    _paintIndicator(
      canvas,
      Size(
        size.width - padding.left - padding.right,
        size.height - padding.top - padding.bottom,
      ),
    );
    canvas.restore();
  }

  _paintIndicator(Canvas canvas, Size size) {
    if (this.activePosition == null) return;
    if (this.style == null) return;
    if (this.style?.horizontalIndicatorLine == null &&
        this.style?.verticalIndicatorLine == null) return;
    if (this.series.isEmpty) return;

    canvas.save();
    canvas.clipRect(Rect.fromLTWH(0, 0, size.width, size.height));

    final activePosition = this.activePosition!;
    final position = activePosition.translate(-padding.left, -padding.top);
    final point = area.convertPointFromGrid(position, gridSize: size);

    final style = this.style!;
    final hI = style.horizontalIndicatorLine;
    final vI = style.verticalIndicatorLine;

    final serieNearest = series
        .where((s) => s.onActived != null)
        .map((serie) => Tuple2(
              serie,
              serie.nearest(
                point: point,
                inHorizontal:
                    style.indicaotrMainAxis == IndicatorMainAxis.horzontal,
              ),
            ))
        .where((t) => t.item2 != null)
        .map((t) => Tuple2(t.item1, t.item2!));

    if (serieNearest.isEmpty) return;

    final choiced = serieNearest.last;
    final activeSerie = choiced.item1;
    final activeData = choiced.item2.item1;
    final activePoint =
        area.convertPointToGird(choiced.item2.item2, gridSize: size);
    final onActived = activeSerie.onActived;
    onActived!(activeData);

    if (hI != null) {
      canvas.drawLine(
        Offset(activePoint.dx, 0),
        Offset(activePoint.dx, size.height),
        Paint()
          ..strokeWidth = hI.width
          ..color = hI.color,
      );
    }

    if (vI != null) {
      canvas.drawLine(
        Offset(0, activePoint.dy),
        Offset(size.width, activePoint.dy),
        Paint()
          ..strokeWidth = vI.width
          ..color = vI.color,
      );
    }

    if (style.indicator != null && style.indicatorSize != null) {
      final indicator = style.indicator!;
      final size = style.indicatorSize!;
      indicator.createBoxPainter().paint(
          canvas,
          Offset(activePoint.dx - size.width / 2,
              activePoint.dy - size.height / 2),
          ImageConfiguration(size: size));
    }

    canvas.restore();
  }
}
