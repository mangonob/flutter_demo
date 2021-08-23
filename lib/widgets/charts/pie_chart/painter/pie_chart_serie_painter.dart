import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:quiver/iterables.dart';

import '../serie.dart';
import '../style.dart';

class PieChartSeriePainter extends CustomPainter {
  final PieChartSerie serie;
  final bool isLablePainted;

  PieChartSeriePainter({
    required this.serie,
    this.isLablePainted = true,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final values = serie.values;
    final style = serie.style;
    final innerRadius = style.innerRadius!;
    final outerRadius = style.outerRadius!;

    canvas.save();
    canvas.translate(size.width / 2, size.height / 2);

    canvas.saveLayer(Rect.largest, Paint());

    if (values.isEmpty) {
      if (!serie.isSkipDrawWhenEmpty)
        canvas.drawOval(
            Rect.fromLTRB(
              -outerRadius,
              -outerRadius,
              outerRadius,
              outerRadius,
            ),
            Paint()..color = style.emptyColor!);
    } else {
      final sectorRanges = serie.sectorRanges();

      if (sectorRanges != null) {
        enumerate(sectorRanges).forEach(
          (entry) => paintSector(
            canvas,
            from: entry.value.first,
            to: entry.value.last,
            index: entry.index,
          ),
        );
      }
    }

    if (style.innerRadius! > 0) {
      // Clip inner area

      canvas.drawOval(
        Rect.fromLTRB(
          -innerRadius,
          -innerRadius,
          innerRadius,
          innerRadius,
        ),
        Paint()
          ..blendMode = BlendMode.clear
          ..color = Colors.transparent,
      );
    }

    canvas.restore();

    canvas.restore();
  }

  void paintSector(
    Canvas canvas, {
    required num from,
    required num to,
    required int index,
  }) {
    final style = serie.style;
    final isClosewise = style.direction! == PieChartSerieDirection.clockwise;
    final radius = style.outerRadius!;
    final span = style.span!;
    final theta = span / radius;
    final pieColor = serie.colorFn != null
        ? serie.colorFn!(serie.data[index], index) ?? style.color!
        : style.color!;

    final half = (to + from) / 2;

    final spanSign = isClosewise ? 1 : -1;
    final sectorPath = Path()
      ..moveTo(0, 0)
      ..lineTo(
        radius * cos(from + spanSign * theta),
        radius * sin(from + spanSign * theta),
      )
      ..arcToPoint(
        Offset(
          radius * cos(to - spanSign * theta),
          radius * sin(to - spanSign * theta),
        ),
        radius: Radius.circular(radius),
        largeArc: (to - from).abs() > pi,
        clockwise: isClosewise,
      );

    /// Draw sector
    canvas.save();
    canvas.drawPath(
      sectorPath,
      Paint()
        ..style = PaintingStyle.fill
        ..color = pieColor,
    );
    canvas.restore();

    /// Draw leading line, label line
    final leadingDistance = style.leadingLineDistance!;
    final d1 = leadingDistance + radius;
    final d2 = d1 + style.leadingLineLength!;
    final leadingStart = Offset(d1 * cos(half), d1 * sin(half));
    final leadingEnd = Offset(d2 * cos(half), d2 * sin(half));
    final sx = cos(half).sign;
    final labelLineLength = style.labelLineLength!;
    final labelLineEnd =
        Offset(leadingEnd.dx + sx * labelLineLength, leadingEnd.dy);

    final linePath = Path()
      ..moveTo(leadingStart.dx, leadingStart.dy)
      ..lineTo(leadingEnd.dx, leadingEnd.dy)
      ..lineTo(labelLineEnd.dx, labelLineEnd.dy);

    final lineColor = serie.lineColorFn != null
        ? serie.lineColorFn!(serie.data[index], index) ?? style.lineColor!
        : style.lineColor!;

    canvas.drawPath(
      linePath,
      Paint()
        ..color = lineColor
        ..strokeWidth = style.lineWidth!
        ..style = PaintingStyle.stroke,
    );

    if (isLablePainted) {
      /// Draw label
      final label = serie.labelFormatter != null
          ? serie.labelFormatter!(serie.values[index])
          : (serie.values[index] * 100).toStringAsFixed(1) + "%";
      final labelPainter = TextPainter(
        text: TextSpan(text: label, style: style.labelStyle!),
        textDirection: TextDirection.ltr,
      );

      labelPainter.layout();
      final labelPadding = style.labelPadding!;
      final labelSize = Size(
        labelPainter.size.width + labelPadding.left + labelPadding.right,
        labelPainter.size.height + labelPadding.top + labelPadding.bottom,
      );
      final labelOrigin = Offset(
        sx >= 0 ? labelLineEnd.dx : labelLineEnd.dx - labelSize.width,
        labelLineEnd.dy - labelSize.height / 2,
      ).translate(labelPadding.left, labelPadding.top);
      labelPainter.paint(canvas, labelOrigin);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
