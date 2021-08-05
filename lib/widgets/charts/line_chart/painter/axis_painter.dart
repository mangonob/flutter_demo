import 'package:flutter/material.dart';

import '../area.dart';
import '../axis.dart';
import '../style.dart';

class LineChartAxisPainter extends CustomPainter {
  final LineChartAxis? xAxis;
  final LineChartAxis? yAxis;
  final LineChartAxis? rightAxis;
  final Area area;

  LineChartAxisPainter({
    this.xAxis,
    this.yAxis,
    this.rightAxis,
    required this.area,
  }) : super();

  @override
  void paint(Canvas canvas, Size size) {
    if (xAxis != null) {
      canvas.save();
      canvas.translate(0, size.height);

      final lineStyle = xAxis?.style.lineStyle;
      if (lineStyle != null) {
        canvas.drawLine(
          Offset.zero,
          Offset(size.width, 0),
          Paint()
            ..strokeWidth = lineStyle.width
            ..strokeCap = StrokeCap.square
            ..color = lineStyle.color,
        );
      }

      double step;
      int count;
      if (xAxis!.tickSpan != null) {
        step = xAxis!.tickSpan!.toDouble();
        count = (area.width / step).floor();
      } else {
        count = xAxis!.tickSpanCount!;
        step = area.width / count;
      }

      final unit = size.width / area.width;

      List.generate(count + 1, (i) => i).forEach((index) {
        final value = step * index + area.minX;
        final axisStyle = xAxis!.style;
        final tickStyle = axisStyle.tickStyle;

        // Draw x-Axis tick
        if (axisStyle.hasTick && count != 0 && axisStyle.tickSize != 0) {
          canvas.drawLine(
            Offset(step * index * unit, -axisStyle.tickSize),
            Offset(step * index * unit, 0),
            Paint()
              ..color = tickStyle.color
              ..strokeWidth = tickStyle.width,
          );
        }

        _drawLabel(
          canvas,
          Offset(step * index * unit, 0),
          label: xAxis!.formatter == null
              ? value.toString()
              : xAxis!.formatter!(value),
          unit: unit,
          style: axisStyle,
          isFirst: index == 0,
          isLast: index == count,
        );
      });

      canvas.restore();
    }

    if (yAxis != null) {
      final lineStyle = yAxis?.style.lineStyle;
      if (lineStyle != null) {
        canvas.drawLine(
          Offset.zero,
          Offset(0, size.height),
          Paint()
            ..strokeWidth = lineStyle.width
            ..color = lineStyle.color,
        );
      }

      double step;
      int count;
      if (yAxis!.tickSpan != null) {
        step = yAxis!.tickSpan!.toDouble();
        count = (area.height / step).floor();
      } else {
        count = yAxis!.tickSpanCount!;
        step = area.height / count;
      }

      final unit = size.height / area.height;

      List.generate(count + 1, (i) => i).forEach((index) {
        final value = step * index + area.minY;
        final axisStyle = yAxis!.style;
        final tickStyle = axisStyle.tickStyle;

        // Draw y-Axis tick
        if (axisStyle.hasTick && count != 0 && axisStyle.tickSize != 0) {
          canvas.drawLine(
            Offset(0, size.height - step * index * unit),
            Offset(axisStyle.tickSize, size.height - step * index * unit),
            Paint()
              ..color = tickStyle.color
              ..strokeWidth = tickStyle.width,
          );
        }

        _drawLabel(
          canvas,
          Offset(0, size.height - step * index * unit),
          label: yAxis!.formatter == null
              ? value.toString()
              : yAxis!.formatter!(value),
          unit: unit,
          style: axisStyle,
          isFirst: index == 0,
          isLast: index == count,
        );
      });
    }
  }

  _drawLabel(
    Canvas canvas,
    Offset offset, {
    required String label,
    required num unit,
    required LineChartAxisStyle style,
    bool isFirst = false,
    bool isLast = false,
  }) {
    canvas.save();
    canvas.translate(offset.dx, offset.dy);

    final textStyle = style.labelStyle;
    final padding = style.labelPadding;
    final alignment = (isFirst
            ? style.firstLabelAlignment
            : isLast
                ? style.lastLabelAlignment
                : null) ??
        style.labelAlignment;

    final tp = TextPainter(
      textDirection: TextDirection.ltr,
      text: TextSpan(text: label, style: textStyle),
    );
    tp.layout();

    final textSize = Size(
      tp.size.width + padding.left + padding.right,
      tp.size.height + padding.top + padding.bottom,
    );

    // if (alignment == Alignment.topRight) {
    // }

    Offset labelOffset = Offset.zero;

    if (alignment == Alignment.topLeft) {
      labelOffset = Offset(-textSize.width, -textSize.height);
    } else if (alignment == Alignment.topCenter) {
      labelOffset = Offset(-textSize.width / 2, -textSize.height);
    } else if (alignment == Alignment.topRight) {
      labelOffset = Offset(0, -textSize.height);
    } else if (alignment == Alignment.centerLeft) {
      labelOffset = Offset(-textSize.width, -textSize.height / 2);
    } else if (alignment == Alignment.center) {
      labelOffset = Offset(-textSize.width / 2, -textSize.height / 2);
    } else if (alignment == Alignment.centerRight) {
      labelOffset = Offset(0, -textSize.height / 2);
    } else if (alignment == Alignment.bottomLeft) {
      labelOffset = Offset(-textSize.width, 0);
    } else if (alignment == Alignment.bottomCenter) {
      labelOffset = Offset(-textSize.width / 2, 0);
    } else if (alignment == Alignment.bottomRight) {
      labelOffset = Offset(0, 0);
    }

    tp.paint(
      canvas,
      Offset(
        labelOffset.dx + padding.left,
        labelOffset.dy + padding.top,
      ),
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
